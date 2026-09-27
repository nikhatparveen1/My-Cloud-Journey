terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

# 1. Dynamically fetch current public IP for SSH security
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

# 2. Latest Amazon Linux 2023 AMI in ap-south-2
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# 3. Security Group matching Step 6 requirements
resource "aws_security_group" "day45_sg" {
  name        = "day-45-deploy-sg"
  description = "Temporary SG for Day 45 Deployment"

  # SSH: Strict source restriction (Your IP only)
  ingress {
    description = "SSH from developer IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

  # Flask App: Public access on Port 5000
  ingress {
    description = "Public Flask App Access"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound All Traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-45-deploy-sg"
  }
}

# 4. Day 45 EC2 Instance with Docker Pre-installed
resource "aws_instance" "day45_ec2" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  key_name                    = "day-12-key"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.day45_sg.id]

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }

  # User data installs and starts Docker automatically on boot
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user
              EOF

  tags = {
    Name = "day-45-deploy"
  }
}

output "public_ip" {
  description = "Public IP address of day-45-deploy instance"
  value       = aws_instance.day45_ec2.public_ip
}

