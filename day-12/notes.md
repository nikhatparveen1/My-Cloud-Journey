# Day 12 — First EC2 Launch

## What I learned

- EC2 = Elastic Compute Cloud
- AMI = operating system image used to launch an instance
- Instance type controls compute resources
- Security Group acts as a virtual firewall
- Key pair is used for secure SSH authentication
- Public IPv4 allows internet connectivity
- Availability Zone is a specific location inside an AWS Region

## EC2 Instance

- Name: day-12-ec2
- Region: ap-south-2
- Availability Zone: ap-south-2a
- Instance type: t3.micro
- OS: Amazon Linux 2023
- State: Running
- Status checks:3/3 passed

## Important

This was a manual EC2 launch to understand AWS fundamentals before automating infrastructure with Terraform.

## Cost Safety

- No NAT Gateway
- No Load Balancer
- No RDS
- No EKS

Temporary resources will be terminated when no longer needed.
