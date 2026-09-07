
# Day 11 — Buffer / Catch-up Review

## Days 3–5 — Linux

pwd = current directory
ls = list files
cd = change directory
mkdir = create directory
touch = create file
cp = copy
mv = move/rename
rm = remove
cat = display file
find = search for files/directories
grep = search text

Permissions:
r = 4
w = 2
x = 1

644 = rw-r--r--
600 = rw-------
755 = rwxr-xr-x

systemctl = service management/status
journalctl = system logs
ps = process snapshot
top = live process monitoring

## Day 6 — IP Networking

IP address = identifies device/interface
Subnet mask = separates network and host portions
Gateway = route to other networks
DNS = resolves names to IP addresses

## Day 7 — CIDR

Total addresses = 2^(32 - prefix)
Traditional usable hosts = total - 2

/16 = 65,536 total / 65,534 usable
/24 = 256 total / 254 usable
/26 = 64 total / 62 usable
/28 = 16 total / 14 usable
/30 = 4 total / 2 usable

Bigger prefix = smaller network.

## Day 8 — Subnetting

Subnetting divides a large network into smaller networks.

Example:

10.0.0.0/16 → four /18 networks

10.0.0.0/18
10.0.64.0/18
10.0.128.0/18
10.0.192.0/18

/18 mask = 255.255.192.0
Increment = 64

## Day 9 — DNS

A = IPv4
AAAA = IPv6
CNAME = alias
MX = mail
NS = name server
PTR = reverse DNS

dig = DNS investigation tool

## Day 10 — OSI

7 Application
6 Presentation
5 Session
4 Transport
3 Network
2 Data Link
1 Physical

DNS/HTTP/SSH → L7
TCP/UDP → L4
IP/Routing → L3
MAC/Ethernet → L2
Cable/Signals → L1

## Big Picture

IP = WHERE
CIDR = HOW BIG
Subnetting = HOW TO DIVIDE
DNS = WHAT NAME TO USE
OSI = WHERE TO TROUBLESHOOT

## Gaps

Linux:
- 

Networking:
- 

CIDR:
- 

Subnetting:
- 

DNS:
- 

OSI:
- 
EOF
