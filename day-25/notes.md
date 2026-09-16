# Day 25 — Private EC2 Access Test

## Goal

Test direct SSH access to a private EC2.

## Result

Direct SSH from my laptop failed.

## Why?

The private EC2:

- Has no public IP
- Is inside the private subnet
- Is not directly reachable from the Internet

## Architecture

Internet
   |
   v
My Laptop
   |
   X
   |
Private EC2
10.0.2.x

Direct access is not possible.

## Correct Architecture

My Laptop
   |
   v
Bastion EC2
Public IP
   |
   | SSH
   v
Private EC2
Private IP

## Security Group

Private EC2 allows SSH from:

Bastion Security Group

It does not allow SSH from:

0.0.0.0/0

## Key Lesson

A private IP is reachable only when a valid network path exists.

A Security Group controls allowed traffic,
but it does not create a route.

A route table determines where traffic goes.

A public IP provides Internet reachability when
the surrounding routing and security configuration allows it.
