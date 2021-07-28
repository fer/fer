# Kenobi

## Task \#1: Deploy and Scan

{% tabs %}
{% tab title="First Tab" %}
```text
nmap -sV -n -v -Pn -p- -T4 -A --open -oX portScan.xml 10.10.128.62
```
{% endtab %}

{% tab title="Output" %}
```text
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times will be slower.
Starting Nmap 7.91 ( https://nmap.org ) at 2021-07-27 11:18 EDT
NSE: Loaded 153 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Initiating Connect Scan at 11:18
Scanning 10.10.128.62 [65535 ports]
Discovered open port 21/tcp on 10.10.128.62
Discovered open port 80/tcp on 10.10.128.62
Discovered open port 445/tcp on 10.10.128.62
Discovered open port 22/tcp on 10.10.128.62
Discovered open port 111/tcp on 10.10.128.62
Discovered open port 139/tcp on 10.10.128.62
Discovered open port 44015/tcp on 10.10.128.62
Discovered open port 36053/tcp on 10.10.128.62
Discovered open port 58355/tcp on 10.10.128.62
Discovered open port 2049/tcp on 10.10.128.62
Discovered open port 40521/tcp on 10.10.128.62
Completed Connect Scan at 11:18, 17.01s elapsed (65535 total ports)
Initiating Service scan at 11:18
Scanning 11 services on 10.10.128.62
Completed Service scan at 11:18, 11.47s elapsed (11 services on 1 host)
NSE: Script scanning 10.10.128.62.
Initiating NSE at 11:18
Completed NSE at 11:18, 2.79s elapsed
Initiating NSE at 11:18
Completed NSE at 11:18, 0.49s elapsed
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Nmap scan report for 10.10.128.62
Host is up (0.064s latency).
Not shown: 64338 closed ports, 1186 filtered ports
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT      STATE SERVICE     VERSION
21/tcp    open  ftp         ProFTPD 1.3.5
22/tcp    open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 b3:ad:83:41:49:e9:5d:16:8d:3b:0f:05:7b:e2:c0:ae (RSA)
|   256 f8:27:7d:64:29:97:e6:f8:65:54:65:22:f7:c8:1d:8a (ECDSA)
|_  256 5a:06:ed:eb:b6:56:7e:4c:01:dd:ea:bc:ba:fa:33:79 (ED25519)
80/tcp    open  http        Apache httpd 2.4.18 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
| http-robots.txt: 1 disallowed entry 
|_/admin.html
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Site doesn't have a title (text/html).
111/tcp   open  rpcbind     2-4 (RPC #100000)
| rpcinfo: 
|   program version    port/proto  service
|   100000  2,3,4        111/tcp   rpcbind
|   100000  2,3,4        111/udp   rpcbind
|   100000  3,4          111/tcp6  rpcbind
|   100000  3,4          111/udp6  rpcbind
|   100003  2,3,4       2049/tcp   nfs
|   100003  2,3,4       2049/tcp6  nfs
|   100003  2,3,4       2049/udp   nfs
|   100003  2,3,4       2049/udp6  nfs
|   100005  1,2,3      36053/tcp   mountd
|   100005  1,2,3      46060/udp6  mountd
|   100005  1,2,3      51586/udp   mountd
|   100005  1,2,3      53409/tcp6  mountd
|   100021  1,3,4      32990/udp   nlockmgr
|   100021  1,3,4      36027/tcp6  nlockmgr
|   100021  1,3,4      44015/tcp   nlockmgr
|   100021  1,3,4      54677/udp6  nlockmgr
|   100227  2,3         2049/tcp   nfs_acl
|   100227  2,3         2049/tcp6  nfs_acl
|   100227  2,3         2049/udp   nfs_acl
|_  100227  2,3         2049/udp6  nfs_acl
139/tcp   open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp   open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
2049/tcp  open  nfs_acl     2-3 (RPC #100227)
36053/tcp open  mountd      1-3 (RPC #100005)
40521/tcp open  mountd      1-3 (RPC #100005)
44015/tcp open  nlockmgr    1-4 (RPC #100021)
58355/tcp open  mountd      1-3 (RPC #100005)
Service Info: Host: KENOBI; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_clock-skew: mean: 1h40m02s, deviation: 2h53m12s, median: 1s
| nbstat: NetBIOS name: KENOBI, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| Names:
|   KENOBI<00>           Flags: <unique><active>
|   KENOBI<03>           Flags: <unique><active>
|   KENOBI<20>           Flags: <unique><active>
|   \x01\x02__MSBROWSE__\x02<01>  Flags: <group><active>
|   WORKGROUP<00>        Flags: <group><active>
|   WORKGROUP<1d>        Flags: <unique><active>
|_  WORKGROUP<1e>        Flags: <group><active>
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.3.11-Ubuntu)
|   Computer name: kenobi
|   NetBIOS computer name: KENOBI\x00
|   Domain name: \x00
|   FQDN: kenobi
|_  System time: 2021-07-27T10:18:37-05:00
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   2.02: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2021-07-27T15:18:37
|_  start_date: N/A

NSE: Script Post-scanning.
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Initiating NSE at 11:18
Completed NSE at 11:18, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 32.09 seconds

```
{% endtab %}
{% endtabs %}

## Task \#2: Enumerating SAMBA for shares

{% hint style="info" %}
**Samba** is the standard Windows interoperability suite of programs for Linux and Unix. It allows end users to access and use files, printers and other commonly shared resources on a companies intranet or internet. Its often referred to as a network file system.

**Samba** is based on the common client/server protocol of Server Message Block \(SMB\). SMB is developed only for Windows, without Samba, other computer platforms would be isolated from Windows machines, even if they were part of the same network.
{% endhint %}

{% tabs %}
{% tab title="Enumerate shares with nmap" %}
```text
nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse 10.10.233.180
```
{% endtab %}

{% tab title="Output" %}
```text
Starting Nmap 7.91 ( https://nmap.org ) at 2021-07-27 11:22 EDT
Nmap scan report for 10.10.128.62
Host is up (0.045s latency).

PORT    STATE SERVICE
445/tcp open  microsoft-ds

Host script results:
| smb-enum-shares: 
|   account_used: guest
|   \\10.10.128.62\IPC$: 
|     Type: STYPE_IPC_HIDDEN
|     Comment: IPC Service (kenobi server (Samba, Ubuntu))
|     Users: 2
|     Max Users: <unlimited>
|     Path: C:\tmp
|     Anonymous access: READ/WRITE
|     Current user access: READ/WRITE
|   \\10.10.128.62\anonymous: 
|     Type: STYPE_DISKTREE
|     Comment: 
|     Users: 0
|     Max Users: <unlimited>
|     Path: C:\home\kenobi\share
|     Anonymous access: READ/WRITE
|     Current user access: READ/WRITE
|   \\10.10.128.62\print$: 
|     Type: STYPE_DISKTREE
|     Comment: Printer Drivers
|     Users: 0
|     Max Users: <unlimited>
|     Path: C:\var\lib\samba\printers
|     Anonymous access: <none>
|_    Current user access: <none>

Nmap done: 1 IP address (1 host up) scanned in 7.05 seconds

```
{% endtab %}

{% tab title="smbclient" %}
```
$ smbclient //10.10.233.180/anonymous
lpcfg_do_global_parameter: WARNING: The "client use spnego" option is deprecated 
lpcfg_do_global_parameter: WARNING: The "client ntlmv2 auth" option is deprecated 
Enter WORKGROUP\kali's password: 
Try "help" to get a list of possible commands. 
smb: > ls 
.          D     0 Wed Sep 4 06:49:09 2019 
..         D     0 Wed Sep 4 06:56:07 2019 
log.txt    N 12237 Wed Sep 4 06:49:09 2019

    9204224 blocks of size 1024. 6877096 blocks available
smb: >
```
{% endtab %}

{% tab title="Enumerate RPC" %}
```
$ nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount 10.10.233.180
Starting Nmap 7.91 ( https://nmap.org ) at 2021-07-27 13:28 EDT
Nmap scan report for 10.10.233.180
Host is up (0.045s latency).

PORT    STATE SERVICE
111/tcp open  rpcbind
| nfs-showmount: 
|_  /var *

Nmap done: 1 IP address (1 host up) scanned in 0.66 seconds
```
{% endtab %}
{% endtabs %}

## Task \#3: Gain access with ProFtpd

{% hint style="info" %}
**ProFtpd** is a free and open-source FTP server, compatible with Unix and Windows systems. Its also been vulnerable in the past software versions.
{% endhint %}

{% tabs %}
{% tab title="What version" %}
```text
$ ftp                    
ftp> o 10.10.233.180
Connected to 10.10.233.180.
220 ProFTPD 1.3.5 Server (ProFTPD Default Installation) [10.10.233.180]
Name (10.10.233.180:kali): 
```
{% endtab %}

{% tab title="searchsploit" %}
```text
$ searchsploit proftpd 1.3.5
--------------------------------------------------------------
 Exploit Title                                                                                                                                                                                                                                                                              |  Path
--------------------------------------------------------------
ProFTPd 1.3.5 - 'mod_copy' Command Execution (Metasploit)     | linux/remote/37262.rb
ProFTPd 1.3.5 - 'mod_copy' Remote Command Execution           | linux/remote/36803.py
ProFTPd 1.3.5 - 'mod_copy' Remote Command Execution (2)       | linux/remote/49908.py
ProFTPd 1.3.5 - File Copy                                     | linux/remote/36742.txt
--------------------------------------------------------------
Shellcodes: No Results

```
{% endtab %}
{% endtabs %}

