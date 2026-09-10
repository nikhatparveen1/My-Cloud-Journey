terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

resource "aws_security_group" "web_sg" {
  name        = "day-16-web-sg"
  description = "Allow SSH from my IP and HTTP from internet"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.47.135.83/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-16-web-sg"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0f3a9efc7dc1165a3"
  instance_type = "t3.micro"
  key_name      = "day-12-key"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "day-16-terraform-ec2"
  }

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Day 16 - Terraform EC2</h1>" > /usr/share/nginx/html/index.html
              EOF
}
