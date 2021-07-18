# BB3

## Prework

### Connect to VPN

```bash
sudo openvpn black-box-penetration-test-3.ovpn
```

### Scan network

```bash
sudo nmap -sn 172.16.37.0/24 -oN hostAlive.nmap &&
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt &&
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml &&
nmap2md.sh portScan.xml | xclip
```

## Scanner

> Generated on **Sun Jul 18 11:53:14 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml
```

## Hosts Alive \(2\)

| Host | OS | Accuracy |
| :--- | :--- | :--- |
| 172.16.37.220 | Linux 3.11 - 4.1 | 95% |
| 172.16.37.234 | Linux 3.11 - 4.1 | 95% |

## Open Ports and Running Services

### 172.16.37.220 \(Linux 3.11 - 4.1 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 80/tcp | open | http | Apache httpd 2.4.18 |
| 3307/tcp | open | tcpwrapped |  |

{% tabs %}
{% tab title="Dirbuster" %}
* Target URL: [http://](http://172.16.64.81)172.16.37.220
* File Extension: \*
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt
{% endtab %}

{% tab title="Report" %}
```bash
DirBuster 1.0-RC1 - Report
http://www.owasp.org/index.php/Category:OWASP_DirBuster_Project
Report produced on Sun Jul 18 12:20:43 EDT 2021
--------------------------------

http://172.16.37.220:80
--------------------------------
Directories found during testing:

Dirs found with a 200 response:

/

Dirs found with a 403 response:

/icons/
/javascript/
/icons/small/


--------------------------------
--------------------------------

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
**Found relevant information at view-source:**[**http://172.16.37.220/**](http://172.16.37.220/)\*\*\*\*

```text
<!--ens192    Link encap:Ethernet  HWaddr 00:50:56:a0:9c:e3  
          inet addr:172.16.37.220  Bcast:172.16.37.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fea0:9ce3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:289106 errors:0 dropped:25 overruns:0 frame:0
          TX packets:258265 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:31871667 (31.8 MB)  TX bytes:27932510 (27.9 MB)

ens224    Link encap:Ethernet  HWaddr 00:50:56:a0:90:a2  
          inet addr:172.16.50.222  Bcast:172.16.50.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fea0:90a2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:31 errors:0 dropped:16 overruns:0 frame:0
          TX packets:45 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:3622 (3.6 KB)  TX bytes:5363 (5.3 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:10841 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10841 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:808036 (808.0 KB)  TX bytes:808036 (808.0 KB)

-->
```
{% endhint %}

### 172.16.37.234 \(Linux 3.11 - 4.1 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 40121/tcp | open | ftp | ProFTPD 1.3.0a |
| 40180/tcp | open | http | Apache httpd 2.4.18 |

{% tabs %}
{% tab title="Dirbuster" %}
* Target URL: [http://](http://172.16.64.81)172.16.37.234:40180
* File Extension: \*
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-2.3-small.txt
{% endtab %}

{% tab title="Report" %}
```bash

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
**ftp splash screen suggests to login with 'ftpuser' while trying to connect.**

```text
ftp 172.16.37.234 40121 
Connected to 172.16.37.234.
220 ProFTPD 1.3.0a Server (ProFTPD Default Installation. Please use 'ftpuser' to log in.) [172.16.37.234]
Name (172.16.37.234:kali): ftpuser
```
{% endhint %}

{% tabs %}
{% tab title="Hydra" %}
```bash
hydra -t 30 -l ftpuser -P /usr/share/seclists/Passwords/bt4-password.txt ftp://172.16.37.234:40121
```
{% endtab %}

{% tab title="Ouput" %}
```bash

```
{% endtab %}
{% endtabs %}

