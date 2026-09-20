# Day 35 — Phase 2 Final Review

## Project

Custom AWS VPC + Bastion Architecture using Terraform.

## What I Built

- Custom VPC
- Public subnet
- Private subnet
- Internet Gateway
- Route tables
- Bastion EC2
- Private EC2
- NAT-based outbound connectivity
- Security Groups
- Terraform-managed infrastructure

## Main Architecture

Laptop
    |
    v
Bastion EC2
    |
    v
Private EC2

The Private EC2 has no public IP.

## Key Concepts Learned

- VPC
- CIDR
- Subnets
- Public vs private subnet
- Route tables
- Internet Gateway
- NAT
- Security Groups
- Bastion Host
- SSH agent forwarding
- Terraform
- Terraform state
- Infrastructure as Code

## Most Important Lesson

Network connectivity is the result of multiple components
working together:

Subnet
+
Route Table
+
Security Group
+
Gateway/NAT
+
Instance

## Portfolio Evidence

- Terraform architecture documentation
- README
- Private EC2 SSH proof
- GitHub repository

## Phase 2 Result

I can build and explain a custom AWS network using Terraform
and securely access a private EC2 through a Bastion Host.

## Next Phase

Project 2 — Dockerized Application + CI/CD.
