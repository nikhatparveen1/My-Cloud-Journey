# Day 6 — Networking Basics

## IP Address

An IP address identifies a device/interface on a network.

Example:
192.168.1.10

## Subnet Mask

A subnet mask separates the network part from the host part.

IP       = 192.168.1.10
CIDR     = /24

Example:
255.255.255.0

CIDR:
/24

## Basic Example

IP: 192.168.1.10/24
Network: 192.168.1.0
Host: 10

## Important

/24 = 255.255.255.0

The subnet mask tells us which part of an IP belongs to the network
and which part identifies the host.

## Commands

ip addr
ip -br addr
ip link
ip -br link
ip route
hostname -I
ping
resolvectl status
