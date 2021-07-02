---
description: >-
  You have been engaged in a Black-box Penetration Test (172.16.64.0/24 range).
  Your goal is to read the flag file on each machine.
---

# Black Box Test 2

## Discover live hosts on the network

```bash
sudo nmap -sn 172.16.64.0/24 --exclude 172.16.64.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

### Hosts Alive

| Host | OS |
| :--- | :--- |
| 172.16.64.81 | Linux |
| 172.16.64.91 | Linux |
| 172.16.64.92 | Linux |
| 172.16.64.166 | Linux |

## Open Ports and Running Services

### 172.16.64.81

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 3306 | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

### 172.16.64.91

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 6379 | redis | Redis key-value store |

### 172.16.64.92

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 \(Ubuntu Linux; protocol 2.0\) |
| 53 | 53 | dnsmasq 2.75 |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 63306 | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

### 172.16.64.166

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 2222 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 \(Ubuntu Linux; protocol 2.0\) |
|  8080 | http | Apache httpd 2.4.18 \(Ubuntu\) |

## Machines

### 172.16.64.81



