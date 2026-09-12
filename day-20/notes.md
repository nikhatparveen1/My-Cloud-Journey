# Day 20 — Internet Gateway

## Internet Gateway

An Internet Gateway (IGW) connects a VPC to the internet.

Terraform resource:

aws_internet_gateway.igw

It is attached to:

aws_vpc.main_vpc

## Current Architecture

VPC
10.0.0.0/16
│
├── Public Subnet
│   10.0.1.0/24
│
└── Private Subnet
    10.0.2.0/24

VPC
 │
 ▼
Internet Gateway

## Important

An Internet Gateway alone does not make a subnet public.

A route table must contain an internet route such as:

0.0.0.0/0 → Internet Gateway

The public route table will be created later.

## Terraform Workflow

terraform fmt
terraform validate
terraform plan
terraform apply

## Key Concept

IGW = connection point between VPC and internet.

Route Table = traffic directions.
