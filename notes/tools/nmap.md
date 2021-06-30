# nmap

## Perform Host Discovery Using `nmap` \(WIP\)

You can use `nmap` to list live hosts in a network.

| Scan | Description | Flag |
| :--- | :--- | :--- |
| ARP ping scan | Probes ARP requests to the target host; an ARP response means that the host is active. | `-PR` |
|  | Attempts to determine the version of the services running | `-sV` |
|  | Port scan for port  or scan all ports | `-p <x>` or `-p-` |
|  | Disable host discovery and just scan for open ports | `-Pn` |
|  | Enables OS and version detection, executes in-build scripts for further enumeration | `-A` |
|  | Scan with the default nmap scripts | `-sC` |
|  | Verbose mode | `-v` |
| UDP port scan |  | `-sU` |
| TCP SYN port scan |  | `-sS` |

