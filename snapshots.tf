# snapshots.tf - Manual Snapshot with Apache Data

# Wait for Apache to be fully installed before taking snapshot
resource "time_sleep" "wait_for_apache" {
  depends_on = [aws_instance.production_server]
  
  create_duration = "3m"  # Wait 3 minutes for Apache to install
}

# Snapshot of ROOT volume (contains Apache and web page)
resource "aws_ebs_snapshot" "root_snapshot" {
  volume_id = aws_instance.production_server.root_block_device[0].volume_id
  
  description = "Root volume snapshot with Apache - ${timestamp()}"
  
  tags = {
    Name         = "luit-apache-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
    Type         = "manual"
    CreatedBy    = "Terraform"
    Purpose      = "Apache-Backup"
    HasApache    = "true"
    WebContent   = "Welcome-LUIT-Students"
  }
  
  depends_on = [time_sleep.wait_for_apache]
}

# Snapshot of DATA volume
resource "aws_ebs_snapshot" "data_snapshot" {
  volume_id = aws_ebs_volume.data_volume.id
  
  description = "Data volume snapshot - ${timestamp()}"
  
  tags = {
    Name      = "luit-data-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
    Type      = "manual"
    CreatedBy = "Terraform"
  }
  
  depends_on = [time_sleep.wait_for_apache]
}