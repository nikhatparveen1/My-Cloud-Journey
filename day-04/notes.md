# Day 4 — Linux Permissions, systemd & journalctl

## Linux Permissions

r = read
w = write
x = execute

u = owner
g = group
o = others

chmod changes permissions.

Numeric permissions:
r = 4
w = 2
x = 1

644 = rw-r--r--
600 = rw-------
755 = rwxr-xr-x

## systemd

systemd manages system services.

systemctl is used to inspect/manage services.

Important commands:
systemctl status
systemctl is-active
systemctl is-enabled
systemctl list-units

## journalctl

journalctl reads systemd journal logs.

Important commands:
journalctl
journalctl -b
journalctl -u <service>
journalctl -p warning
journalctl -f


