variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "volume_size" {
  description = "Size of EBS volume in GB"
  type        = number
  default     = 20
}

variable "snapshot_retention_count" {
  description = "Number of snapshots to keep"
  type        = number
  default     = 7
}

variable "snapshot_time" {
  description = "Time to take daily snapshot (UTC, 24-hour format)"
  type        = string
  default     = "03:00"
}

variable "disaster_recovery_mode" {
  description = "Set to true to deploy disaster recovery instance"
  type        = bool
  default     = false
}

variable "my_ami" {
  description = "AMI ID for EC2 instances"
  type        = string
  # You'll set this in terraform.tfvars
}