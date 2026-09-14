# Day 22 — Public Route Table

## Route Table

A route table controls where network traffic goes.

## Public Route

Destination:

0.0.0.0/0

Target:

Internet Gateway

Meaning:

Traffic destined outside the VPC can be sent to the Internet Gateway.

## Public Subnet

10.0.1.0/24

Associated with:

day-22-public-route-table

## Private Subnet

10.0.2.0/24

Must NOT be associated with the public route table.

It must NOT have:

0.0.0.0/0 → Internet Gateway

## Important

IGW provides the gateway to the internet.

Route table decides where traffic goes.

Route table association connects a subnet to a route table.

## Mental Model

Public Subnet
    ↓
Public Route Table
    ↓
0.0.0.0/0
    ↓
Internet Gateway
    ↓
Internet

Private Subnet
    ↓
No direct IGW route

