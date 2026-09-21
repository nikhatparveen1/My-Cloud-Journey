# Day 39 — Terraform EC2 + Docker

## Goal

Use Terraform to provision an EC2 instance in the
existing public subnet and run the Dockerized Flask
application on it.

## Architecture

Existing VPC
10.0.0.0/16
    ↓
Public subnet
10.0.1.0/24
    ↓
EC2 t3.micro
    ↓
Docker
    ↓
Flask container
    ↓
Port 5000

## Terraform Resources

- aws_security_group.docker_ec2_sg
- aws_instance.docker_ec2

## Data Sources

- Existing public subnet
- Existing VPC
- Existing day-12-key
- Current Amazon Linux 2023 AMI through SSM

## Important Concepts

Terraform
→ Infrastructure as Code.

Data source
→ Reads existing AWS information without creating it.

User data
→ Bootstraps the EC2 instance during launch.

Security Group
→ Controls network access to EC2.

Docker
→ Runs the application in a container.

Port mapping
→ EC2 port 5000 → container port 5000.

## Result

Terraform created the EC2 and security group.

EC2 installed Docker using user data.

Docker pulled the Day 38 image and started
the Flask container.

The application was accessed through:

http://<EC2_PUBLIC_IP>:5000
