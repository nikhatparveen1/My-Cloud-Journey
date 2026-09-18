terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "day-19-custom-vpc"
  }
}

resource "aws_subnet" "public_sub" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "day-19-public-subnet"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "day-19-private-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "day-20-igw"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "day-22-public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_security_group" "bastion_sg" {
  name        = "day-23-bastion-sg"
  description = "Allow SSH from anywhere to bastion"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from public internet"
    from_port   = 22
    to_port     = 22
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
    Name = "day-23-bastion-sg"
  }
}
resource "aws_security_group" "private_ec2_sg" {
  name        = "day-24-private-ec2-sg"
  description = "SSH access from bastion only"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-24-private-ec2-sg"
  }
}
resource "aws_instance" "private_ec2" {
  ami                    = "ami-0f84e72ee2b9c3a09"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_sub.id
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]
  key_name               = "day-12-key"

  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable --now nginx
              echo "Day 24 Private EC2" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "day-24-private-ec2"
  }
}
resource "aws_instance" "bastion" {
  ami                    = "ami-0f84e72ee2b9c3a09"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_sub.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = "day-12-key"

  associate_public_ip_address = true

  tags = {
    Name = "day-23-bastion"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "day-29-private-rt"
  }
}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_sub.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_security_group" "nat_sg" {
  name        = "day-29-nat-sg"
  description = "Security group for NAT instance"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "Allow private subnet traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.2.0/24"]
  }

  egress {
    description = "Allow outbound internet traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-29-nat-sg"
  }
}
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
resource "aws_instance" "nat_instance" {
  ami           = data.aws_ssm_parameter.al2023_ami.value
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_sub.id

  vpc_security_group_ids = [
    aws_security_group.nat_sg.id
  ]

  associate_public_ip_address = true

  source_dest_check = false

  user_data = <<-EOF
              #!/bin/bash
              set -e

              sysctl -w net.ipv4.ip_forward=1

              cat <<SYSCTL > /etc/sysctl.d/99-nat.conf
              net.ipv4.ip_forward = 1
              SYSCTL

              sysctl --system

              dnf install -y iptables-services

              systemctl enable --now iptables

              iptables -t nat -A POSTROUTING -o eth0 -s 10.0.2.0/24 -j MASQUERADE

              service iptables save
              EOF

  tags = {
    Name = "day-29-nat-instance"
  }
}
resource "aws_route" "private_default" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id
}
