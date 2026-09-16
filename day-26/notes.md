# Day 26 — SSH Agent Forwarding

## Goal

Access a private EC2 through a Bastion without copying the private SSH key to the Bastion.

## Architecture

CachyOS Laptop
    |
    | SSH + Agent Forwarding
    v
Bastion EC2
    |
    | SSH
    v
Private EC2
10.0.2.111

## SSH Key

Private key location:

/home/acer/.ssh/day-12-key.pem

The private key remains on the local machine.

## Commands

Start SSH agent in fish:

eval (ssh-agent -c)

Add SSH key:

ssh-add /home/acer/.ssh/day-12-key.pem

Verify key:

ssh-add -l

Connect to Bastion:

ssh -A -i /home/acer/.ssh/day-12-key.pem ec2-user@BASTION_PUBLIC_IP

Verify:

whoami
hostname
ssh-add -l

Connect from Bastion to Private EC2:

ssh ec2-user@10.0.2.111

Verify:

whoami
hostname
hostname -I

## Important Concept

SSH Agent Forwarding allows the Bastion to authenticate to the
private EC2 using the SSH agent on the local machine.

The .pem private key is NOT copied to the Bastion.

## Security Flow

Private Key
    |
    v
Local SSH Agent
    |
    | forwarded
    v
Bastion
    |
    v
Private EC2

## Network Observation

Private EC2:

10.0.2.111

The private subnet currently has only the local VPC route.

There is no NAT Gateway/default internet route.

Therefore internet access from the private EC2 is not available.

Example:

curl https://amazonlinux.com

does not complete.

This is expected with the current architecture.

## Day 26 Result

Successfully accessed:

Laptop
  -> Bastion
  -> Private EC2

without copying the private key to Bastion.

## Cleanup

Remove SSH key from local agent after practice:

ssh-add -d /home/acer/.ssh/day-12-key.pem
