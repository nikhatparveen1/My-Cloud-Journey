# Day 15 — Phase 1 Review & Cleanup

## Phase 1 Completed

Days 3–15 covered:

- Linux command line
- Linux permissions
- systemd
- journalctl
- IP addressing
- Subnet masks
- CIDR
- Subnetting
- DNS
- OSI model
- EC2
- SSH
- Nginx
- AWS Security Groups

## AWS EC2

I manually launched an Amazon Linux 2023 EC2 instance in ap-south-2.

Instance type:

t3.micro

The EC2 was used to practice:

- Security Groups
- SSH
- Web server configuration
- HTTP access

After completing the exercise, the manual EC2 instance was terminated to avoid unnecessary AWS costs.

## Key Networking Concepts

IP address identifies a network interface.

CIDR describes network size.

Subnetting divides a network into smaller networks.

Routing determines where packets should go.

A gateway provides a path to another network.

DNS translates human-readable names into network addresses.

## Phase 1 → Phase 2

Phase 1 built the networking foundation.

Phase 2 will use these concepts to build a custom AWS VPC using Terraform.
