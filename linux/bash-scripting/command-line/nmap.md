---
description: Network Mapper - WIP
---

# nmap

## Perform Host Discovery Using `nmap` \(WIP\)

You can use `nmap` to list live hosts in a network.

| Description | Flag |
| :--- | ---: |
| Probes ARP requests to the target host; an ARP response means that the host is active. | `-PR` |
| Attempts to determine the version of the services running | `-sV` |
| Port scan for port  | `-p <x>` |
| Scan all ports |   `-p-` |
| Disable host discovery and just scan for open ports.  Assumes host is already alive | `-Pn` |
| Enables OS and version detection, executes in-build scripts for further enumeration | `-A` |
| Scan with the default nmap scripts | `-sC` |
| Verbose mode | `-v` |
|  | `-sU` |
|  | `-sS` |
| Version identification  | `-sV`  |
| Disabling reverse DNS lookup | `-n` |
| To speed things up  | `-T4` |
| To use a list of IPs as input \(e.g.: ips.txt\)  | `-iL` |
| To see just open ports and not closed / filtered ones | `--open` |
|  For detailed information and running some scripts | `-A` |

