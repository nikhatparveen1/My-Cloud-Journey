# Day 30 — Verify NAT Instance Connectivity

## Goal

Verify that the Private EC2 can reach the Internet
through the NAT Instance.

## Network Path

Private EC2
    ↓
Private Route Table
    ↓
NAT Instance
    ↓
Internet Gateway
    ↓
Internet

## Private EC2

The Private EC2 has:

- Private IP
- No public IP
- Private subnet

## NAT Instance

The NAT Instance:

- Runs in the Public Subnet
- Uses t3.micro
- Has a public IP
- Has Source/Destination Check disabled
- Performs NAT for private traffic

## Verification Commands

ip addr
-> Shows network interfaces and IP addresses.

ip route
-> Shows routing table.

curl -I https://example.com
-> Tests outbound HTTP/HTTPS connectivity.

getent hosts example.com
-> Tests DNS resolution.

curl https://checkip.amazonaws.com
-> Shows the public IP seen by the Internet.

## Main Result

Private EC2 successfully reaches the Internet
through the NAT Instance without having a public IP.

## Important Concept

NAT provides outbound connectivity.

It does not make the Private EC2 directly
reachable from the Internet.

## Day 30 Architecture

Internet
   ↑
Internet Gateway
   ↑
NAT Instance
   ↑
Private Route Table
   ↑
Private EC20

