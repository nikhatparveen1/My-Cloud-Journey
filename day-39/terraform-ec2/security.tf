resource "aws_security_group" "docker_ec2_sg" {
  name        = "day-39-docker-ec2-sg"
  description = "Security group for Day 39 Docker EC2"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "SSH from my current public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "Flask application"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.app_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-39-docker-ec2-sg"
  }
}
