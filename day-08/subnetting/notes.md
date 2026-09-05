# Day 8 — Subnetting

## Core Idea

Subnetting means dividing one network into smaller networks.

## Example

Original network:

10.0.0.0/16

Split into four /18 subnets.

Borrowed bits:

18 - 16 = 2 bits

Number of subnets:

2^2 = 4

## /18

Subnet mask:

255.255.192.0

Total addresses:

2^(32-18) = 16,384

Traditional usable hosts:

16,382

## Four /18 Subnets

1. 10.0.0.0/18
   Broadcast: 10.0.63.255

2. 10.0.64.0/18
   Broadcast: 10.0.127.255

3. 10.0.128.0/18
   Broadcast: 10.0.191.255

4. 10.0.192.0/18
   Broadcast: 10.0.255.255

## Important Formula

Number of subnets = 2^(borrowed bits)

Addresses per subnet = 2^(32 - prefix)

## Important Memory

Subnet increment = 256 - mask value
