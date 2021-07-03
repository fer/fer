---
description: You have been engaged in a Black-box Penetration Test (172.16.37.0/24 range).
---

# Black Box Test 3

## Discover live hosts on the network

```bash
sudo nmap -sn 172.16.37.0/24 --exclude 172.13.37.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

### Hosts Alive

| Host | OS |
| :--- | :--- |
| 172.16.37.220 | Linux |
| 172.16.37.234 | Linux |

## Open Ports and Running Services

### 172.16.37.220

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 80 | http | Apache httpd 2.4.18 \(\(Ubuntu\)\) |
| 3307 | tcp | tcpwrapped |

### 172.16.37.234

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 40121 | ftp | ProFTPD 1.3.0a |
| 40180 | http | Apache httpd 2.4.18 \(\(Ubuntu\)\) |

