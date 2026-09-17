# Day 27 — AWS Networking Consolidation

## Architecture

VPC
10.0.0.0/16
|
+-- Public Subnet
|   10.0.1.0/24
|   |
|   +-- Bastion EC2
|
+-- Private Subnet
    10.0.2.0/24
    |
    +-- Private EC2

## Public Subnet

The public subnet contains the Bastion.

The Bastion has a public IP and can be reached
from my laptop when the Security Group allows SSH.

## Private Subnet

The private subnet contains the Private EC2.

The Private EC2 has a private IP and no public IP.

It is not directly reachable from the Internet.

## Route Table

A route table determines where network traffic goes.

Public subnet:

0.0.0.0/0 -> Internet Gateway

## Internet Gateway

The Internet Gateway provides a path between
the VPC and the Internet when the routing and
security configuration permits it.

## Security Group

Security Groups control which traffic is allowed.

Private EC2 SSH access should be allowed from
the Bastion Security Group rather than from
0.0.0.0/0.

## Day 25

Direct:

Laptop -> Private EC2

Failed because the Private EC2 is not directly
Internet reachable.

## Day 26

Correct:

Laptop -> Bastion -> Private EC2

SSH Agent Forwarding allows authentication
without copying the private key to the Bastion.

## Important Difference

Route Table:
Determines where traffic goes.

Security Group:
Determines whether traffic is allowed.

Public IP:
Provides Internet-addressable connectivity
when routing and security allow it.

Private IP:
Used for communication inside private networks.

## Terraform

terraform state list
-> shows Terraform-managed resources

terraform fmt
-> formats Terraform files

terraform validate
-> validates Terraform configuration

terraform plan
-> previews infrastructure changes

terraform apply
-> applies changes

Day 27:
No infrastructure changes were intentionally created.
