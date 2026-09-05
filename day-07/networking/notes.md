# Day 7 — CIDR Notation

## CIDR

CIDR tells us how many bits belong to the network portion.

Example:

192.168.1.0/24

## Formula

Total IPv4 addresses:

2^(32 - prefix)

Usable hosts:

2^(32 - prefix) - 2

## Important Examples

/16
Total addresses = 65,536
Usable hosts = 65,534
Mask = 255.255.0.0

/24
Total addresses = 256
Usable hosts = 254
Mask = 255.255.255.0

/28
Total addresses = 16
Usable hosts = 14
Mask = 255.255.255.240

## /28 Blocks

192.168.1.0/28
192.168.1.16/28
192.168.1.32/28
192.168.1.48/28
192.168.1.64/28

Each /28 block contains 16 addresses.

## Important Memory

Bigger prefix = smaller network

Smaller prefix = larger network

/16 has a larger network size than /24
/24 has a larger network size than /28
