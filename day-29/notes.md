# Day 29 — NAT Instance

## Goal

Configure a NAT instance so the Private EC2 can
have outbound Internet access without a public IP.

## Architecture

Internet
   |
   v
Internet Gateway
   |
   v
Public Subnet
   |
   v
NAT Instance
t3.micro
   |
   v
Private Route Table
   |
   v
Private Subnet
   |
   v
Private EC2

## NAT Instance

The NAT instance is an EC2 instance running
in the Public Subnet.

It has a public IP.

It forwards traffic from the private subnet
toward the Internet.

## Private EC2

The Private EC2 remains in the Private Subnet.

It has no public IP.

It uses the NAT instance for outbound Internet
traffic.

## Private Route Table

10.0.0.0/16 -> local

0.0.0.0/0 -> NAT Instance

## Important NAT Settings

IP forwarding must be enabled.

AWS source/destination check must be disabled
on the NAT instance.

iptables MASQUERADE performs source NAT.

## Security

Private EC2 is not directly exposed to the Internet.

NAT provides outbound connectivity.

NAT does not make the Private EC2 directly
Internet reachable.

## Important Difference

Internet Gateway:
Provides VPC Internet connectivity.

NAT Instance:
Allows private resources to initiate outbound
Internet connections.

Bastion:
Provides controlled administrative SSH access.

## Terraform

terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list

## Day 29 Result

NAT instance configured for the private subnet.

Day 30 will verify Internet connectivity
from the Private EC2 through the NAT instance.
