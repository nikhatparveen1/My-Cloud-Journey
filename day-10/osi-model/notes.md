# Day 10 — OSI Model

## 7 OSI Layers

7 - Application
6 - Presentation
5 - Session
4 - Transport
3 - Network
2 - Data Link
1 - Physical

## Important Examples

Layer 7:
HTTP, DNS, SSH

Layer 4:
TCP, UDP

Layer 3:
IP, routing, routers

Layer 2:
Ethernet, MAC, switches

Layer 1:
Cables, radio, physical signals

## Commands

ip addr
ip link
ip route
ss -tuln
ss -tan
dig google.com
ping -c 4 google.com

## Mental Model

Layer 7 = application/network services
Layer 4 = transport
Layer 3 = IP and routing
Layer 2 = MAC and frames
Layer 1 = physical transmission

## Troubleshooting

If DNS fails:
Check DNS/resolution.

If IP connectivity fails:
Check IP address, subnet and routes.

If local interface is down:
Check the network interface.

If a service is listening:
Check its TCP/UDP socket.

OSI helps identify which layer a networking problem belongs to.
