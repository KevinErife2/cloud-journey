# outputs.tf - Modern Terraform Syntax

output "apache_url" {
  description = "URL to access Apache web server"
  value       = "http://${aws_instance.production_server.public_ip}"
  # ↑ This is CORRECT - we're building a string with "http://"
}

output "production_instance_id" {
  description = "ID of production EC2 instance"
  value       = aws_instance.production_server.id
  # ↑ BETTER - no interpolation needed for direct reference
}

output "production_public_ip" {
  description = "Public IP of production server"
  value       = aws_instance.production_server.public_ip
  # ↑ BETTER - direct reference
}

output "root_volume_id" {
  description = "ID of the root volume (contains Apache)"
  value       = aws_instance.production_server.root_block_device[0].volume_id
  # ↑ CORRECT - accessing nested attributes
}

output "data_volume_id" {
  description = "ID of the data volume"
  value       = aws_ebs_volume.data_volume.id
  # ↑ BETTER - direct reference
}

output "root_snapshot_id" {
  description = "ID of the Apache snapshot"
  value       = aws_ebs_snapshot.root_snapshot.id
  # ↑ BETTER - direct reference
}

output "data_snapshot_id" {
  description = "ID of the data snapshot"
  value       = aws_ebs_snapshot.data_snapshot.id
  # ↑ BETTER - direct reference
}

output "dr_apache_url" {
  description = "URL to access disaster recovery Apache server (if enabled)"
  value       = var.disaster_recovery_mode ? "http://${aws_instance.disaster_recovery[0].public_ip}" : "Not deployed - set disaster_recovery_mode=true"
  # ↑ CORRECT - combining ternary with string interpolation
}