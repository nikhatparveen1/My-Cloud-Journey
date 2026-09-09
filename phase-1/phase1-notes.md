# Phase 1 — Networking Notes

## 1. IP Address

An IP address identifies a device or network interface on a network.

Example:

10.0.1.10

An IP address has two logical parts:

- Network portion
- Host portion

The subnet mask/CIDR tells us where the network portion ends and the host portion begins.

---

## 2. CIDR

CIDR means Classless Inter-Domain Routing.

Example:

10.0.0.0/24

The /24 means:

- 24 bits are used for the network
- 8 bits remain for hosts
- Total addresses = 2^8 = 256
- Traditional usable hosts = 254

Common examples:

/16 → 65,536 total addresses
/24 → 256 total addresses
/28 → 16 total addresses

Important rule:

Larger prefix = smaller network.

Example:

/16 is larger than /24.

/24 is larger than /28.

---

## 3. Subnetting

Subnetting means dividing one larger network into smaller networks.

Example:

10.0.0.0/16

Split into four /18 networks:

10.0.0.0/18
10.0.64.0/18
10.0.128.0/18
10.0.192.0/18

Each /18 subnet has:

16,384 total addresses
16,382 traditional usable addresses

Subnetting helps organize networks and separate resources.

---

## 4. DNS

DNS means Domain Name System.

DNS translates domain names into IP addresses.

Example:

example.com → IP address

Important DNS records:

A
→ Maps a name to an IPv4 address.

AAAA
→ Maps a name to an IPv6 address.

CNAME
→ Creates an alias for another hostname.

MX
→ Specifies mail servers for a domain.

NS
→ Specifies authoritative name servers.

PTR
→ Used for reverse DNS.

---

## 5. DNS Resolution

A simplified DNS lookup works like:

Client
↓
DNS resolver
↓
Root server
↓
TLD server
↓
Authoritative DNS server
↓
IP address

The result is returned to the client.

---

## 6. Gateway and Routing

A default gateway is used when traffic needs to leave the local network.

The routing table determines where network traffic should go.

Useful command:

ip route

---

## 7. Useful Networking Commands

Check IP addresses:

ip addr

Check routing:

ip route

Check DNS configuration:

resolvectl status

Resolve a hostname:

resolvectl query example.com

DNS lookup:

dig example.com

Test connectivity:

ping example.com

Show listening ports:

ss -tuln

---

## 8. What I Learned

IP address
→ identifies a network interface.

CIDR
→ describes the network size/prefix.

Subnetting
→ divides a network into smaller networks.

DNS
→ maps human-readable names to network addresses.

Routing
→ determines where packets should go.

Gateway
→ provides a path to other networks.

---

## 9. Connection to AWS

The concepts learned here are directly useful for AWS VPCs.

Example:

VPC
10.0.0.0/16

        ↓

Public subnet
10.0.1.0/24

        ↓

EC2
10.0.1.10

Later, AWS networking will use these concepts with:

- VPCs
- Subnets
- Route tables
- Internet Gateways
- Security Groups
- Private networks

