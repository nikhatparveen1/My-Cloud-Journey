# Day 19 — Public and Private Subnets

## VPC

VPC CIDR:
10.0.0.0/16

The VPC is the overall virtual network.

## Public Subnet

CIDR:
10.0.1.0/24

Terraform:
map_public_ip_on_launch = true

## Private Subnet

CIDR:
10.0.2.0/24

No automatic public IP assignment.

## Important Concept

A subnet is not truly public just because it is called a public subnet.

Routing determines whether it can reach the internet.

Day 20 will add the Internet Gateway.

## Terraform Resources

aws_vpc.main_vpc
aws_subnet.public_sub
aws_subnet.private_sub

## Mental Model

VPC
 ├── Public Subnet
 │   └── 10.0.1.0/24
 │
 └── Private Subnet
     └── 10.0.2.0/24
