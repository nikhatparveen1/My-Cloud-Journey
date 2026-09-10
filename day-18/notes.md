# Day 18 — Custom VPC with Terraform

## VPC

VPC = Virtual Private Cloud.

A VPC is an isolated virtual network inside AWS.

## CIDR

Our VPC:

10.0.0.0/16

Total IPv4 addresses:

2^(32-16) = 65,536

## Terraform Resource

resource "aws_vpc" "main"

aws_vpc = resource type
main    = Terraform local name

## Important Concepts

VPC is not a subnet.

A VPC contains subnets.

Today we created only the VPC.

We did NOT create:
- EC2
- subnet
- Internet Gateway
- NAT Gateway
- route table

Those will be added later.

## Terraform Workflow

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy

## Mental Model

AWS
└── VPC
    └── 10.0.0.0/16
