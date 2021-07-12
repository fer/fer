---
description: >-
  You have been engaged in a Black-box Penetration Test (172.16.37.0/24 range).
  Your goal is to read the flag file on each machine.
---

# Black Box Test 3

## Discover live hosts on the network

```bash
sudo nmap -sn 172.16.37.0/24 --exclude 172.13.37.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

{% hint style="info" %}
Find more [**nmap options**](https://ferx.gitbook.io/wiki/linux/command-line/nmap).
{% endhint %}

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

### 172.16.37.234 \(flag.txt in ftp\)

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 40121 | ftp | ProFTPD 1.3.0a |
| 40180 | http | Apache httpd 2.4.18 \(\(Ubuntu\)\) |

## Machines

### 172.16.37.220

view-source:[http://172.16.37.220/](http://172.16.37.220/)

```text
<!--ens192    Link encap:Ethernet  HWaddr 00:50:56:a2:3a:e3  
          inet addr:172.16.37.220  Bcast:172.16.37.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fea2:3ae3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:77991 errors:0 dropped:24 overruns:0 frame:0
          TX packets:75345 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:4691219 (4.6 MB)  TX bytes:4120213 (4.1 MB)

ens224    Link encap:Ethernet  HWaddr 00:50:56:a2:ab:28  
          inet addr:172.16.50.222  Bcast:172.16.50.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fea2:ab28/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:29 errors:0 dropped:14 overruns:0 frame:0
          TX packets:51 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:3608 (3.6 KB)  TX bytes:6328 (6.3 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:12792 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12792 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:951696 (951.6 KB)  TX bytes:951696 (951.6 KB)

-->
```

### 172.16.37.234  \(flag.txt in ftp\)

view-source:[http://172.16.37.234:40180/xyz/](http://172.16.37.234:40180/xyz/)

```text
<!-- cmd: --><hr />ens192    Link encap:Ethernet  HWaddr 00:50:56:a2:e1:9a  
          inet addr:172.16.37.234  Bcast:172.16.37.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fea2:e19a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:951905 errors:0 dropped:27 overruns:0 frame:0
          TX packets:726303 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:159196687 (159.1 MB)  TX bytes:133205262 (133.2 MB)

ens224    Link encap:Ethernet  HWaddr 00:50:56:a2:47:7c  
          inet addr:172.16.50.224  Bcast:172.16.50.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fea2:477c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:54 errors:0 dropped:16 overruns:0 frame:0
          TX packets:29 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:6079 (6.0 KB)  TX bytes:3920 (3.9 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:25426 errors:0 dropped:0 overruns:0 frame:0
          TX packets:25426 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:1887092 (1.8 MB)  TX bytes:1887092 (1.8 MB)


```

#### FTP

Connect with ftpuser/ftpuser

```text
$ ftp
ftp> open 172.16.37.234 40121
Connected to 172.16.37.234.
220 ProFTPD 1.3.0a Server (ProFTPD Default Installation. Please use 'ftpuser' to log in.) [172.16.37.234]
Name (172.16.37.234:kali): ftpuser
331 Password required for ftpuser.
Password:
230 User ftpuser logged in.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls -la
200 PORT command successful
150 Opening ASCII mode data connection for file list
drwxr-xr-x   3 root     root         4096 May 17  2019 .
drwxr-xr-x   3 root     root         4096 May 17  2019 ..
-rw-------   1 root     root           27 Apr 26  2019 .flag.txt
drwxr-xr-x   3 root     root         4096 May 20  2019 html
226 Transfer complete.
ftp> get .flag.txt
local: .flag.txt remote: .flag.txt
200 PORT command successful
150 Opening BINARY mode data connection for .flag.txt (27 bytes)
226 Transfer complete.
27 bytes received in 0.02 secs (1.6571 kB/s)
ftp>
```

```text
$ cat .flag.txt           
You got the first machine!
```

```text
route add 172.16.50.0/24 via 10.13.37.1
sudo nmap -sn 172.16.50.0/24
```

We discovered 2 more machines we need to enumerate.

#### 172.16.50.222

```text
$ nmap -Pn 172.16.50.222                                                                                                                                                                                                                                                                                                1 ⨯
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times will be slower.
Starting Nmap 7.91 ( https://nmap.org ) at 2021-07-04 11:34 EDT
Nmap scan report for 172.16.50.222
Host is up (0.29s latency).
Not shown: 994 filtered ports
PORT      STATE SERVICE
135/tcp   open  msrpc
1310/tcp  open  husky
3871/tcp  open  avocent-adsap
5902/tcp  open  vnc-2
18101/tcp open  unknown
50002/tcp open  iiimsf

```

#### 172.16.50.224

```text
$ nmap -Pn 172.16.50.224
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times will be slower.
Starting Nmap 7.91 ( https://nmap.org ) at 2021-07-04 11:32 EDT
Nmap scan report for 172.16.50.224
Host is up (0.15s latency).
Not shown: 998 filtered ports
PORT     STATE SERVICE
995/tcp  open  pop3s
9666/tcp open  zoomcp
```

{% embed url="https://security.stackexchange.com/questions/188921/use-netcat-to-pivot" %}

{% embed url="https://www.hackplayers.com/2018/05/taller-de-pivoting-netcat-y-socat.html" %}

{% embed url="https://www.hackplayers.com/2018/05/taller-de-pivoting-netcat-y-socat.html" %}

```text
#!/bin/bash
while true; do
    # your netcat command(s) here
done;
```



