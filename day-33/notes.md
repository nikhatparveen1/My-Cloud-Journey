# Day 33 — Private EC2 SSH Proof

## Goal

Demonstrate successful SSH access to a Private EC2
through the Bastion Host.

## Architecture

Laptop
   |
   | SSH
   v
Bastion EC2
Public Subnet
   |
   | SSH using private IP
   v
Private EC2
Private Subnet

## Private EC2

The Private EC2:

- Has a private IP
- Has no public IP
- Is located in the private subnet
- Is accessed through the Bastion

## SSH Flow

Local machine:

ssh -A ec2-user@$BASTION_IP

Bastion:

ssh ec2-user@$PRIVATE_IP

## SSH Agent Forwarding

The private key remains on the local machine.

The key is loaded into ssh-agent:

ssh-add /home/acer/Downloads/day-12-key.pem

The Bastion does not need a copy of the PEM file.

## Proof

The terminal screenshot shows a successful
connection to the Private EC2 using its private IP.

## Key Concept

A Bastion provides a controlled administrative
entry point into a private network.

The Private EC2 does not need a public IP
for administrative access when a Bastion path exists.

## Evidence

See:

day-33-private-ec2-ssh.png

