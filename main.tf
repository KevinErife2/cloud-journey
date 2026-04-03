# Security Group - Allow HTTP traffic
resource "aws_security_group" "web_server_sg" {
  name        = "luit-web-server-sg"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere (for administration)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LUIT-WebServer-SG"
  }
}

# Production EC2 Instance with Apache
resource "aws_instance" "production_server" {
  ami           = var.my_ami
  instance_type = var.instance_type
  
  # Attach security group
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  
  # Install Apache on first boot
  user_data = file("${path.module}/scripts/install_apache.sh")
  
  # Optional: Add SSH key if you want to connect
  # key_name = "your-key-name"
  
  tags = {
    Name        = "LUIT-Production-Server"
    Environment = "production"
    Backup      = "daily"
    ManagedBy   = "Terraform"
    Purpose     = "Apache-Web-Server"
  }
}

# Data Volume (for storing additional data)
resource "aws_ebs_volume" "data_volume" {
  availability_zone = aws_instance.production_server.availability_zone
  size              = var.volume_size
  
  tags = {
    Name      = "luit-production-data-volume"
    Backup    = "daily"
    ManagedBy = "Terraform"
  }
}

# Attach volume to instance
resource "aws_volume_attachment" "data_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data_volume.id
  instance_id = aws_instance.production_server.id
}