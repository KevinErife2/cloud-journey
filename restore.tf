# restore.tf - Fixed Disaster Recovery with Proper Dependencies

# Find the most recent ROOT snapshot (contains Apache)
data "aws_ebs_snapshot" "latest_root_backup" {
  most_recent = true
  
  filter {
    name   = "volume-id"
    values = [aws_instance.production_server.root_block_device[0].volume_id]
  }
  
  filter {
    name   = "status"
    values = ["completed"]  # Only use COMPLETED snapshots
  }
  
  filter {
    name   = "tag:HasApache"
    values = ["true"]
  }

  count = var.disaster_recovery_mode ? 1 : 0
  
  # IMPORTANT: Wait for snapshot to be created first
  depends_on = [aws_ebs_snapshot.root_snapshot]
}

# Find the most recent DATA snapshot
data "aws_ebs_snapshot" "latest_data_backup" {
  most_recent = true
  
  filter {
    name   = "volume-id"
    values = [aws_ebs_volume.data_volume.id]
  }
  
  filter {
    name   = "status"
    values = ["completed"]  # Only use COMPLETED snapshots
  }

  count = var.disaster_recovery_mode ? 1 : 0
  
  # IMPORTANT: Wait for snapshot to be created first
  depends_on = [aws_ebs_snapshot.data_snapshot]
}

# Wait for snapshots to complete before creating DR resources
resource "time_sleep" "wait_for_snapshots" {
  count = var.disaster_recovery_mode ? 1 : 0
  
  depends_on = [
    aws_ebs_snapshot.root_snapshot,
    aws_ebs_snapshot.data_snapshot
  ]
  
  create_duration = "2m"  # Wait 2 minutes for snapshots to complete
}

# Disaster Recovery Instance (boots from snapshot)
resource "aws_instance" "disaster_recovery" {
  count = var.disaster_recovery_mode ? 1 : 0
  
  ami           = var.my_ami
  instance_type = var.instance_type
  
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  
  tags = {
    Name        = "LUIT-DR-Server-Restored"
    Environment = "disaster-recovery"
    ManagedBy   = "Terraform"
    RestoredFrom = "Snapshot"
  }
  
  # Wait for snapshots to be ready
  depends_on = [time_sleep.wait_for_snapshots]
}

# Restored data volume from snapshot
resource "aws_ebs_volume" "restored_data_volume" {
  count = var.disaster_recovery_mode ? 1 : 0
  
  availability_zone = aws_instance.disaster_recovery[0].availability_zone
  snapshot_id       = data.aws_ebs_snapshot.latest_data_backup[0].id
  
  tags = {
    Name      = "luit-restored-data-volume"
    ManagedBy = "Terraform"
    Type      = "DisasterRecovery"
  }
  
  # Ensure snapshot lookup happened and sleep completed
  depends_on = [
    data.aws_ebs_snapshot.latest_data_backup,
    time_sleep.wait_for_snapshots
  ]
}

# Attach restored volume to DR instance
resource "aws_volume_attachment" "dr_attach" {
  count = var.disaster_recovery_mode ? 1 : 0
  
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.restored_data_volume[0].id
  instance_id = aws_instance.disaster_recovery[0].id
  
  depends_on = [
    aws_ebs_volume.restored_data_volume,
    aws_instance.disaster_recovery
  ]
}