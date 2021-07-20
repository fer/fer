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
nmap -v --script vuln 10.10.146.250
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



