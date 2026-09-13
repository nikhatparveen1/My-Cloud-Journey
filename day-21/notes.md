# Day 21 — VPC Debug & Review

## Day 18

Created custom VPC:

10.0.0.0/16

VPC = overall isolated virtual network.

## Day 19

Created:

Public Subnet:
10.0.1.0/24

Private Subnet:
10.0.2.0/24

Public subnet:
map_public_ip_on_launch = true

Private subnet:
map_public_ip_on_launch = false

## Day 20

Created Internet Gateway.

IGW attaches to the VPC.

## Important Concept

An Internet Gateway alone does not make a subnet public.

The route table determines where traffic goes.

Future public route:

0.0.0.0/0 → Internet Gateway

## Terraform Debugging

Terraform configuration
        ↓
Terraform State
        ↓
AWS infrastructure

Always compare desired state, Terraform state,
and actual AWS resources.

## Safety

Never blindly apply a Terraform plan.

Always:

terraform fmt
terraform validate
terraform plan
review
terraform apply
