# Day 28 — AWS Security Groups & Terraform

## Goal

Understand how Security Groups control network access
between the Bastion and Private EC2.

## Architecture

Laptop
   |
   | SSH
   v
Bastion EC2
Public Subnet
   |
   | SSH :22
   v
Private EC2
Private Subnet

## Security Group Concept

Security Group controls whether traffic is allowed.

Route Table determines where traffic goes.

## Bastion

Bastion is publicly reachable through its public IP
when its Security Group allows SSH from my IP.

## Private EC2

Private EC2 has no public IP.

Its SSH access should come from the Bastion Security Group.

Concept:

Bastion SG
    |
    | TCP 22
    v
Private EC2 SG

## Security Principle

Do not expose Private EC2 SSH to:

0.0.0.0/0

Allow SSH only from the required trusted source.

## Terraform Commands

terraform state list
-> Shows Terraform-managed resources.

terraform fmt
-> Formats Terraform code.

terraform fmt -check
-> Checks formatting.

terraform validate
-> Validates Terraform configuration.

terraform plan
-> Previews infrastructure changes.

## Safety

No unnecessary AWS resources were created.

Always inspect terraform plan before apply.

STOP -> VERIFY -> PROCEED
