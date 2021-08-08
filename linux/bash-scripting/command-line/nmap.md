---
description: Network Mapper - WIP
---

# nmap

{% hint style="info" %}
**Work In Progress**:

* [https://tryhackme.com/room/furthernmap](https://tryhackme.com/room/furthernmap)
{% endhint %}

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



```text
### Host discovery

| Option | Description                 |
| :----- | :-------------------------- |
| -sn    | No port scan                |
| -PR    | ARP Ping                    |
| -PU    | UDP Scan                    |
| -PE    | ECHO Scan                   |
| -PP    | ICMP Timestamp ping scan    |
| -PM    | ICMP Address mask ping scan |
| -PS    | TCP SYN Ping Scan           |
| -PA    | TCP ACK Ping Scan           |
| -PO    | IP Protocol Ping Scan       |

### Open Ports and Services Running

| Option | Description                       |
| :----- | :-------------------------------- |
| -sT    | TCP Connect/full open scan        |
| -sS    | Stealth Scan / TCP half-open scan |
| -sX    | Xmas Scan                         |
| -sM    | Maimon Scan                       |
| -sA    | ACK Scan                          |
| -sU    | UDP Scan                          |
| -sN    | Null Scan                         |
| -sl    | IDLE/IPID Header Scan             |
| -sY    | SCTP INIT Scan                    |
| -sZ    | SCTP COOKIE ECHO Scan             |
| -sV    | Detects service versions          |

### OS Discovery

| Option                        | Description                    |
| :---------------------------- | :----------------------------- |
| -A                            | Performs aggressive scan       |
| -O                            | OS Discovery                   |
| --script smb-os-discovery.nse | OS Discovery over SMB protocol |

### Scan beyond IDS and Firewall

| Option     | Description                                                                                             |
| :--------- | :------------------------------------------------------------------------------------------------------ |
| -f         | split the IP packet into tiny fragment packets                                                          |
| -g         | Source port manipulation, useful when the firewall is configured to allow packets from well-known ports |
| -mtu       | specifies the number of maximum transimision units, forcing fragmentation                               |
| -D RND:num | performs a decoy scan and RND generates a random and non-reserved IP addresses                          |

### Other Options

| Option   | Description             |
| :------- | :---------------------- |
| -oX name | Outputs to a file       |
| -p       | specifies a port number |
```

