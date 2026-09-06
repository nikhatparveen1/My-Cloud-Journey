# Day 9 — DNS Fundamentals

## What is DNS?

DNS translates domain names into IP addresses.

Example:

google.com → IP address

## DNS Records

A:
Domain → IPv4

AAAA:
Domain → IPv6

CNAME:
Hostname → another hostname

MX:
Domain → mail server

NS:
Domain → authoritative name servers

PTR:
IP address → hostname

## DNS Resolution

Client
↓
DNS Resolver
↓
Root DNS
↓
TLD DNS
↓
Authoritative DNS
↓
IP address
↓
Server

## Important Commands

resolvectl status
resolvectl query google.com
getent hosts google.com
dig google.com
dig +short google.com
dig google.com A
dig google.com AAAA
dig google.com MX
dig google.com NS
dig +trace google.com
dig -x 8.8.8.8

## Important Memory

A = IPv4
AAAA = IPv6
CNAME = Alias
MX = Mail
NS = Name Server
PTR = Reverse DNS
