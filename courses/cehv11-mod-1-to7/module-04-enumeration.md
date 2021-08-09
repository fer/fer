# Module 04: Enumeration

{% hint style="info" %}
**Objectives**

* Understanding Enumeration Concepts 
* Understanding Different Techniques for NetBIOS Enumeration 
* Understanding Different Techniques for SNMP and LDAP Enumeration 
* Understanding Different Techniques for NTP and NFS Enumeration
* Understanding Different Techniques for SMTP and DNS Enumeration
* Understanding Other Enumerations such as IPsec, VoIP, RPC, Linux/Unix, Telnet, FTP, TFTP, SMB, IPv6, and BGP enumeration
* Understanding Different Enumeration Countermeasures
{% endhint %}

## 1. Enumeration Concepts

* Enumeration involves an attacker creating active connections with a target system and performing directed queries to gain more information about the target.
* Attackers use the extracted information to identify points for a system attack and perform password attacks to gain unauthorized access to information system resources.
* Enumeration techniques are conducted in an intranet environment.

In particular, enumeration allows the attacker to collect the following information:

* Network resources 
* Network shares 
* Routing tables 
* Audit and service settings
* Machine names 
* Users and groups 
* Applications and banners
* SNMP and fully qualified domain name \(FQDN\) details
* Attackers may stumble upon a remote inter-process communication \(IPC\) share, such as IPC$ in Windows, which they can probe further to connect to an administrative share by brute-forcing admin credentials and obtain complete information about the file-system listing that the share represents.
* Enumeration activities may be illegal depending on the organization's policies and the laws that are in effect

### Techniques for Enumeration

* Extract usernames using email IDs
* Extract information using default passwords
* Brute force Active Directory
* Extract information using DNS Zone Transfer
* Extract user groups from Windows
* Extract usernames using SNMP 

### Services and Ports to Enumerate

| Protocol | Number | Service |
| :--- | :--- | :--- |
| TCP/UDP | 53 | DNS Zone Transfer |
| TCP/UDP | 135 | Microsoft RPC Endpoint Mapper |
| UDP | 137 | NetBIOS Name Service \(NBNS\) |
| TCP | 139 | NetBIOS Session Service \(SMB over NetBIOS\) |
| TCP/UDP | 445 | SMB over TCP \(Direct Host\) |
| UDP | 161 | Simple Network Management Protocol \(SNMP\) |
| TCP/UDP | 389 | Lightweight Directory Access Protocol \(LDAP\) |
| TCP | 2049 | Network File System \(NFS\) |
| TCP | 25 | Simple Mail Transfer Protocol \(SMTP\) |
| TCP/UDP | 162 | SNMP Trap |
| UDP | 500 | Internet Security Association and Key Management Protocol \(ISAKMP\)/Internet Key Exchange \(IKE\) |
| TCP | 22 | Secure Shell \(SSH\) |
| TCP/UDP | 3268 | Global Catalog Service |
| TCP/UDP 5060, | 5061 | Session Initiation Protocol \(SIP\) |
| TCP | 20/21 | File Transfer Protocol |
| TCP | 23 | Telnet |
| UDP | 69 | Trivial File Transfer Protocol \(TFTP\) |
| TCP | 179 | Border Gateway Protocol \(BGP\) |

## 2. NetBIOS Enumeration

* A NetBIOS name is a unique 16 ASCII character string used to identify the network devices over TCP/IP.
* fifteen characters are used for the device name, and the sixteenth character is reserved for the service or name record type

> Note: NetBIOS name resolution is not supported by Microsoft for Internet Protocol Version 6 \(IPv6\).

* NetBIOS was originally developed as an API for client software to access local area network \(LAN\) resources. Windows uses NetBIOS for file and printer sharing. 
* The NetBIOS name is a unique 16-character ASCII string assigned to Windows systems to identify network devices over TCP/IP; 15 characters are used for the device name, and the 16th is reserved for the service or record type.
* NetBIOS uses UDP port 137 \(name services\), UDP port 138 \(datagram services\), and TCP port 139 \(session services\). 
* Attackers usually target the NetBIOS service because it is easy to exploit and run on Windows systems even when not in use.

Attackers use the NetBIOS enumeration to obtain:

* The list of computers that belong to a domain.
* The list of shares on the individual hosts in the network.
* Policies and passwords.

| Name | NetBIOS Code | Type | Information Obtained |
| :--- | :--- | :--- | :--- |
|  | 00 | UNIQUE | Hostname |
|  | 00 | GROUP | Domain name |
|  | 03 | UNIQUE | Messenger service running for the computer |
|  | 03 | UNIQUE | Messenger service running for the logged-in user |
|  | 20 | UNIQUE | Server service running |
|  | 1D | GROUP | Master browser name for the subnet |
|  | 1B | UNIQUE | Domain master browser name, identifies the primary domain controller \(PDC\) for the domain |

An attacker who finds a Windows system with port 139 open can check to see which resources can be accessed or viewed on a remote system. However, to enumerate the NetBIOS names, the remote system must have enabled file and printer sharing. NetBIOS enumeration may enable an attacker to read or write to a remote computer system, depending on the availability of shares, or launch a DoS attack.

### Tools

* [**Nbtstat Utility**](https://docs.microsoft.com)

Syntax is as follows:

```text
nbtstat [-a RemoteName] [-A IP Address] [-c] [-n] [-r] [-R] [-RR] [-s] [-S] [Interval]
```

| Nbtstat Parameter | Function |
| :--- | :--- |
| -a RemoteName | Displays the NetBIOS name table of a remote computer, where RemoteName is the NetBIOS computer name of the remote computer |
| -A IP Address | Displays the NetBIOS name table of a remote computer, specified by the IP address \(in dotted decimal notation\) of the remote computer |
| -c | Lists the contents of the NetBIOS name cache, the table of NetBIOS names and their resolved IP addresses |
| -n | Displays the names registered locally by NetBIOS applications such as the server and redirector |
| -r | Displays a count of all names resolved by a broadcast or WINS server |
| -R | Purges the name cache and reloads all \#PRE-tagged entries from the Lmhosts file |
| -RR | Releases and re-registers all names with the name server |
| -s | Lists the NetBIOS sessions table converting destination IP addresses to computer NetBIOS names |
| -S | Lists the current NetBIOS sessions and their status with the IP addresses |
| Interval | Re-displays selected statistics, pausing at each display for the number of seconds specified in Interval |

* [**NetBIOS Enumerator**](http://nbtenum.sourceforge.net)
* **Nmap**: Attackers use the Nmap Scripting Engine \(NSE\) for discovering NetBIOS shares on a network. The nbstat script of NSE allows attackers to retrieve the target’s NetBIOS names and MAC addresses. By default, the script displays the name of the computer and the logged-in user. However, if the verbosity is turned up, it displays all names related to that system.

```text
 nmap -sV -v --script nbstat.nse <target IP address>
```

* [**Global Network Inventory**](http://www.magnetosoft.com)
* [**Advanced IP Scanner**](http://www.advanced-ip-scanner.com)
* [**Hyena**](https://www.systemtools.com)
* [**Nsauditor Network Security Auditor**](https://www.nsauditor.com)

### Enumeration User Accounts

Enumerating user accounts using the **PsTools** suite helps to control and manage remote systems from the command line.

| Command | Description |
| :--- | :--- |
| PsExec | executes processes remotely |
| PsFile | shows files opened remotely |
| **PsGetSid** | displays the SID of a computer or user |
| PsKill | kills processes by name or process ID |
| PsInfo | lists information about a system |
| PsList | lists detailed information about processes |
| **PsLoggedOn** | shows who is logged on locally and via resource sharing |
| PsLogList | dumps event log records |
| PsPasswd | changes account passwords |
| PsShutdown | shuts down and optionally reboots a computer |

#### PsGetSid

PsGetSid translates SIDs to their display name and vice versa. It works on built-in accounts, domain accounts, and local accounts. It also displays the SIDs of user accounts and translates an SID into the name that represents it. It works across the network to query SIDs remotely. The syntax of the PsGetSid command is as follows:

```text
psgetsid [\\computer[,computer[,...] | @file] [-u username [-p password]]] [account|SID]
```

#### PsLoggedOn

PsLoggedOn is an applet that displays both the locally logged-in users and users logged in via resources for either the local computer or a remote one. If a username is specified instead of a computer, PsLoggedOn searches the computers in the network neighborhood and reveals if the user currently logged in. PsLoggedOn defines a locally logged-in user is one that has a profile loaded into the registry. Therefore, PsLoggedOn determines who is logged in by scanning the keys under the HKEY\_USERS key. For each key that has a name or user SID, PsLoggedOn looks up the corresponding username and displays it. To determine who logged into a computer via resource shares, PsLoggedOn uses the NetSessionEnum API. The syntax of the PsLoggedOn command is as follows:

```text
psloggedon [-] [-l] [-x] [\\computername | username]
```

Identify administrator:

```text
C:\Users\ph3rx>psGetSid

PsGetSid v1.45 - Translates SIDs to names and vice versa
Copyright (C) 1999-2016 Mark Russinovich
Sysinternals - www.sysinternals.com

SID for \\MYPC:
S-1-5-21-607920660-3142744139-2158457810


C:\Users\ph3rx>psGetSid S-1-5-21-607920660-3142744139-2158457810-500

PsGetSid v1.45 - Translates SIDs to names and vice versa
Copyright (C) 1999-2016 Mark Russinovich
Sysinternals - www.sysinternals.com

Account for MYPC\S-1-5-21-607920660-3142744139-2158457810-500:
User: MYPC\Administrator
```

### Enumeration User Accounts

Net View is a command-line utility that displays a list of computers in a specified workgroup or shared resources available on a specified computer. It can be used in the following ways.

```text
net view \\<computername>
```

In the above command,  is the name or IP address of a specific computer, the resources of which are to be displayed.

```text
net view \\<computername> /ALL
```

The above command displays all the shares on the specified remote computer, along with hidden shares.

```text
net view /domain
```

The above command displays all the shares in the domain.

```text
net view /domain:<domain name>
```

The above command displays all the shares on the specified domain.

## 3. SNMP Enumeration

* SNMP allows network administrators to manage network devices from a remote location.
* SNMP enumeration is the process of enumerating user accounts and devices on a target system using SNMP.
* SNMP holds two passwords to access and configure the SNMP agent from the management station:
  * _Read community string_: It is public by default; it allows for the viewing of the device/system configuration.
  * _Read/write community string_: It is private by default; it allows remote editing of configuration.
* Attackers use these default community strings to extract information about a device.
* Attackers enumerate SNMP to extract information about network resources, such as hosts, routers, devices, and shares, and network information, such as ARP tables, routing tables, and traffic.
* SNMP is an application-layer protocol that runs on UDP and maintains and manages routers, hubs, and switches on an IP network.
* SNMP agents run on Windows and Unix networks on networking devices.

### Working of SNMP

SNMP uses a disturbed architecture comprising SNMP managers, SNMP agents, and several related components. The following are some commands associated with SNMP.

* **GetRequest**: Used by the SNMP manager to request information from an SNMP agent 
* **GetNextRequest**: Used by the SNMP manager continuously to retrieve all the data stored in an array or table
* **GetResponse**: Used by an SNMP agent to satisfy a request made by the SNMP manager 
* **SetRequest**: Used by the SNMP manager to modify the value of a parameter within an SNMP agent’s management information base \(MIB\)
* **Trap**: Used by an SNMP agent to inform the pre-configured SNMP manager of a certain event

The communication process between an SNMP manager and SNMP agent is as follows:

1. The SNMP manager \(Host X, 10.10.2.1\) uses the GetRequest command to send a request for the number of active sessions to the SNMP agent \(Host Y, 10.10.2.15\). To perform this step, the SNMP manager uses an SNMP service library such as the Microsoft SNMP Management API library \(Mgmtapi.dll\) or Microsoft WinSNMP API library \(Wsnmp32.dll\).
2. The SNMP agent \(Host Y\) receives the message and verifies if the community string \(Compinfo\) is present on its MIB, checks the request against its list of access permissions for that community, and verifies the source IP address.
3. If the SNMP agent does not find the community string or access permission in Host Y’s MIB database and the SNMP service is set to send an authentication trap, it sends an authentication failure trap to the specified trap destination, Host Z.
4. The master agent component of the SNMP agent calls the appropriate extension agent to retrieve the requested session information from the MIB.
5. Using the session information retrieved from the extension agent, the SNMP service forms a return SNMP message that contains the number of active sessions and the destination IP address \(10.10.2.1\) of the SNMP manager, Host X.
6. Host Y sends the response to Host X.

If the communnity string does not match the string stored in the MIB database, then `host Y` will send a community string to a pre-configured SNMP manager indicating the error.

![](../../.gitbook/assets/image%20%2849%29.png)

#### MIB

* MIB is a virtual database containing a formal description of all the network objects that can be managed using SNMP.
* The MIB database is hierarchical, and each managed object in a MIB is addressed through Object Identifiers \(OIDs\).
* Two types of managed objects exist:
  * Scalar objects that define a single object instance
  * Tabular objects that define multiple related object instances and are grouped in MIB tables
* OID includes the type of MIB object, such as counter, string, or address; access level, such as not-accessible, accessible-for-notify, read-only, or read-write; size restrictions; and range information.
* SNMP uses the MIB’s hierarchical namespace containing OIDs to translate the OID numbers into a human-readable display.

The major MIBs are:

* **DHCP.MIB**: Monitors network traffic between DHCP servers and remote hosts.
* **HOSTMIB.MIB**: Monitors and manages host resources.
* **LNMIB2.MIB**: Contains object types for workstation and server services.
* **MIB\_II.MIB**: Manages TCP/IP-based Internet using a simple architecture and system.
* **WINS.MIB**: For the Windows Internet Name Service \(WINS\).

### SNMP enumeration tools

* [OpUtils](https://www.manageengine.com) and [Network Performance Monitor](https://www.solarwinds.com).
* [Snmpcheck \(snmp\_enum Module\)](http://www.nothink.org): Attackers use this tool to gather information about the target, such as contact, description, write access, devices, domain, hardware and storage information, hostname, Internet Information Services \(IIS\) statistics, IP forwarding, listening UDP ports, location, mountpoints, network interfaces, network services, routing information, software components, system uptime, TCP connections, total memory, uptime, and user accounts.
* [SoftPerfect Network Scanner](https://www.softperfect.com): Attackers uses this tool to gather information about a shared folder and network devices.
* [PRTG Network Monitor](https://www.paessler.com)
* [Engineer’s Toolset](https://www.solarwinds.com)

## 4. LDAP Enumeration

* Lightweight directory access protocol \(LDAP\) is an Internet protocol for accessing distributed directory services.
* Directory services may provide any organized set of records, often in a hierarchical and logical structure, such as a corporate email directory.
* A client starts a LDAP session by connecting to a **directory system agent** \(DSA\) on TCP **port 389** and then sends an operation request to the DSA.
* Information is transmitted between the client and server using basic encoding rules \(BER\).
* Attackers query the LDAP service to gather information, such as valid usernames, addresses, and departmental details, which can be further used to perform attacks.

### LDAP Enumeration Tools

* [Softerra LDAP Administrator](https://www.ldapadministrator.com)
* [LDAP Admin Tool](https://www.ldapsoft.com)
* [LDAP Account Manager](https://www.ldap-account-manager.org)
* [LDAP Search](https://securityxploded.com)
* [JXplorer](http://www.jxplorer.org)
* [Active Directory Explorer](https://docs.microsoft.com)

## 5. NTP Enumeration

* Administrators often overlook the Network Time Protocol \(NTP\) server when considering security.
* However, if queried properly, it can provide valuable network information to an attacker. 
* Network Time Protocol \(NTP\) is designed to synchronize the clocks of networked computers.
* It uses _UDP port 123_ as its primary means of communication.
* NTP can maintain time to within 10 milliseconds \(1/100 second\) over the public Internet.
* It can achieve accuracies of 200 microseconds or better in local area networks under ideal conditions.

Attackers query the NTP server to gather valuable information, such as:

* List of connected hosts.
* Clients IP addresses in a network, their system names, and OSs.
* Internal IPs can also be obtained if the NTP server is in the demilitarized zone \(DMZ\).

### NTP Enumeration Commands

NTP enumeration commands such as `ntpdate`, `ntptrace`, `ntpdc`, and `ntpq` are used to query an NTP server for valuable information.

#### `ntptrace`

Traces a chain of NTP servers back to the primary source:

```text
ntptrace [-n] [-m maxhosts] [servername/IP_address]
```

#### `ntpdc`

* This command queries the ntpd daemon about its current state and requests changes in that state. 
* Attackers use this command to retrieve the state and statistics of each NTP server connected to the target network.

Monitors operation of the NTP daemon, ntpd:

```text
ntpdc [-ilnps] [-c command] [host] [...]
```

#### `ntpq`

Monitors NTP daemon \(ntpd\) operations and determines performance:

```text
ntpq [-inp] [-c command] [host] [...]
```

### NTP Enumeration Tools

* [PRTG Network Monitor](https://www.paessler.com): attackers use PRTG Network Monitor to retrieve SNTP server details such as the response time from the server, active sensors with the server, and synchronization time.
* [Nmap](https://nmap.org)
* [Wireshark](https://www.wireshark.org)
* [udp-proto-scanner](https://labs.portcullis.co.uk)
* [NTP Server Scanner](http://www.bytefusion.com)

## 6. NFS Enumeration

NFS is a type of file system that enables users to access, view, store, and update files over a remote server. These remote data can be accessed by the client in the same way it is accessed on the local system. Depending on the privileges assigned to the clients, they can either only read or both read and write the data. An NFS system is generally implemented on a computer network in which the centralization of data is required for critical resources. The _remote procedure call \(RPC\)_ is used to route and process the request between clients and servers.

To accomplish the task of sharing files and directories over the network, the “exporting” process is used. However, the client first attempts to make the file available for sharing by using the “mounting” process. The /etc/exports location on the NFS server contains a list of clients allowed to share files on the server. In this approach, to access the server, _the only credential used is the client’s IP address_. NFS versions before version 4 run on the same security specification.

The attackers can spoof their IP addresses to gain full access to the shared files on the server.

### `rpcinfo`

An attacker runs the following rpcinfo command to scan the target IP address for an open NFS port \(port 2049\) and the NFS services running on it:

```text
rpcinfo -p 10.10.10.16
```

### `showmount`

An attacker runs the following command to view the list of shared files and directories:

```text
showmount -e 10.10.10.16
```

### NFS Enumeration Tools

NFS enumeration tools scan a network within a given range of IP addresses or a single IP address to identify the NFS services running on it. These tools also assist in obtaining a list of RPC services using portmap, a list of NFS shares, and a list of directories accessible through NFS; further, they allow downloading a file shared through the NFS server.

#### [RPCScan](https://github.com/hegusung/RPCScan)

Communicates with RPC services and checks misconfigurations on NFS shares. As shown in the screenshot, an attacker runs the following command to enumerate a target IP address for active NFS services:

```text
Python3 rpc-scan.py 10.10.10.19 --rpc
```

### SuperEnum

SuperEnum includes a script that performs the basic enumeration of any open port. As shown in the screenshot, an attacker uses the ./superenum script and then enters a text file name “Target.txt” having a target IP address or a list of IP addresses for enumeration.

After scanning a target IP address, the script displays all the open ports.

## 7. SMTP Enumeration

* Mail systems commonly use SMTP with POP3 and IMAP, which enable users to save messages in the server mailbox and download them from the server when necessary. 
* SMTP uses mail exchange \(MX\) servers to direct mail via DNS. 
* It runs on TCP port 25, 2525, or 587.

SMTP provides 3 built-in-commands:

* `VRFY` - Validates users 
* `EXPN` - Shows the actual delivery addresses of aliases and mailing lists 
* `RCPT TO` - Defines the recipients of a message

Also:

* SMTP servers respond differently to VRFY, EXPN, and RCPT TO commands for valid and invalid users, based on which we can determine valid users on the SMTP server.
* Attackers can directly interact with SMTP via the telnet prompt and collect a list of valid users on the SMTP server.
* SMTP servers respond differently to VRFY, EXPN, and RCPT TO commands for valid and invalid users; therefore, valid users on the SMTP server can be determined. 

### SMTP Enumeration Tools

Administrators and pen testers can perform SMTP enumeration using command-line utilities such as Telnet and netcat or by using tools such as Metasploit, Nmap, NetScanTools Pro, and smtp-user-enum to collect a list of valid users, delivery addresses, message recipients, etc.

* [NetScanTools Pro](https://www.netscantools.com)
* [smtp-user-enum](http://pentestmonkey.net)

## 8. DNS Enumeration

### Using Zone Transfer

* DNS zone transfer is the process of transferring a copy of the DNS zone file from the primary DNS server to a secondary DNS server. 
* If the target DNS server allows zone transfers, then attackers use this technique to obtain DNS server names, hostnames, machine names, usernames, IP addresses, aliases, etc. assigned within a target domain.
* In most cases, the primary DNS server maintains a backup or secondary server for redundancy, which holds all the information stored in the primary server.
* The DNS server uses zone transfer to distribute changes made to the main server to the secondary server\(s\).
* An attacker performs DNS zone transfer enumeration to locate the DNS server and access records of the target organization.
* Attackers perform DNS zone transfer using tools, such as nslookup, dig, and DNSRecon; if DNS transfer setting is enabled on the target name server, it will provide DNS information, or else it will return an error saying it has failed or refuses the zone transfer.
* If the DNS server of the target organization allows zone transfers, then attackers can perform DNS zone transfer to obtain DNS server names, hostnames, machine names, usernames, IP addresses, aliases, etc. assigned within a target domain.

To perform a DNS zone transfer, the attacker sends a zone-transfer request to the DNS server pretending to be a client; the DNS server then sends a portion of its database as a zone to the attacker. This zone may contain a large amount of information about the DNS zone network.

#### dig

Attackers use the dig command on Linux-based systems to query the DNS name servers and retrieve information about the target host addresses, name servers, mail exchanges, etc.

```text
dig ns <target domain
```

The above command retrieves all the DNS name servers of the target domain. Next, attackers use one of the name servers from the output of the above command to test whether the target DNS allows zone transfers. They use the following command for this purpose:

```text
dig @<domain of name server> <target domain> axfr
```

#### nslookup

Attackers use the nslookup command on Windows-based systems to query the DNS name servers and retrieve information about the target host addresses, name servers, mail exchanges, etc. As shown in the screenshot, attackers use the following command to perform DNS zone transfer:

```text
nslookup 
set querytype=soa 
<target domain>
```

The above command sets the query type to the Start of Authority \(SOA\) record to retrieve administrative information about the DNS zone of the target domain.

#### \[DNSRecon\]

```text
dnsrecon -t axfr -d <target domain>
```

In the above command, the -t option specifies the type of enumeration to be performed, axfr is the type of enumeration in which all NS servers are tested for a zone transfer, and the -d option specifies the target domain.

### DNS Cache Snooping

> DNS cache snooping is a DNS enumeration technique whereby an attacker queries the DNS server for a specific cached DNS record.

DNS cache snooping is a type of DNS enumeration technique in which an attacker queries the DNS server for a specific cached DNS record. By using this cached record, the attacker can determine the sites recently visited by the user. This information can further reveal important information such as the name of the owner of the DNS server, its service provider, the name of its vendor, and bank details. By using this information, the attacker can perform a social engineering attack on the target user. Attackers perform DNS cache snooping using various tools such as the dig command, DNS Snoop Dogg, and DNSRecon.

#### Non-recursive Method

> Attackers send a non-recursive query by setting the Recursion Desired \(RD\) bit in the query header to zero.

In this method, to snoop on a DNS server, attackers send a non-recursive query by setting the Recursion Desired \(RD\) bit in the query header to zero. Attackers query the DNS cache for a specific DNS record such as A, CNAME, PTR, CERT, SRV, and MX.

If the queried record is present in the DNS cache, the DNS server responds with the information indicating that some user on the system has visited a specific domain.

Otherwise, the DNS server responds with the information about another DNS server that can return an answer to the query, or it replies with the `root.hints` file containing information about all root DNS servers.

Attackers use the dig command followed by the name/IP address of the DNS server, domain name, and type of DNS record file. The +norecurse option is used to set the query to non-recursive.

```text
dig @<IP of DNS server> <Target domain> A +norecurse
```

#### Recursive Method

> Attackers send a recursive query to determine the time the DNS record resides in the cache.

In this method, to snoop on the DNS server, attackers send a recursive query by setting the +recurse option instead of the +norecurse option.

Similar to the non-recursive method, the attackers query the DNS cache for a specific DNS record such as A, CNAME, PTR, CERT, SRV, and MX.

In this method, the time-to-live \(TTL\) field is examined to determine the duration for which the DNS record remains in the cache. Here, the TTL value obtained from the result is compared with the TTL that was initially set in the TTL field.

If the TTL value in the result is less than the initial TTL value, the record is cached, indicating that someone on the system has visited that site. However, if the queried record were not present in the cache, it will be added to the cache after the first query is sent.

Attackers use the same dig command as in the non-recursive method but with the `+recurse` option instead of the `+norecurse` option

```text
dig @<IP of DNS server> <Target domain> A +recurse
```

### DNSSEC Zone Walking

Domain Name System Security Extensions \(DNSSEC\) zone walking is a type of DNS enumeration technique in which an attacker attempts to obtain internal records if the DNS zone is not properly configured.

The enumerated zone information can assist the attacker in building a host network map. Organizations use DNSSEC to add security features to the DNS data and provide protection against known threats to the DNS. This security feature uses digital signatures based on public-key cryptography to strengthen authentication in DNS. These digital signatures are stored in the DNS name servers along with common records such as MX, A, AAAA, and CNAME. While DNSSEC provides Internet security, it is also susceptible to a vulnerability called zone enumeration or zone walking.

By exploiting this vulnerability, attackers can obtain network information of a target domain, based on which they may launch Internet-based attacks. To overcome the zone enumeration vulnerability, a new version of DNSSEC that uses Next Secure version 3 \(NSEC3\) is used. The NSEC3 record provides the same functionality as NSEC records, except that it provides cryptographically hashed record names that are designed to prevent the enumeration of record names present in the zone. To perform zone enumeration, attackers can use various DNSSEC zone enumerators such as LDNS, DNSRecon, nsec3map, nsec3walker, and DNSwalk.

#### DNSSEC Zone Walking Tools

DNSSEC zone walking tools are used to enumerate the target domain’s DNS record files.

These tools can also perform zone enumeration on NSEC and NSEC3 record files and further use the gathered information to launch attacks such as denial-of-service \(DoS\) attacks and phishing attacks.

**LDNS**

Attackers use the following query to enumerate a target domain iana.org using the DNS server 8.8.8.8 to obtain DNS record files:

```text
ldns-walk @<IP of DNS Server> <Target domain>
```

**\[DNSRecon\]**

DNSRecon is a zone enumeration tool that assists users in enumerating DNS records such as A, AAAA, and CNAME. It also performs NSEC zone enumeration to obtain DNS record files of a target domain.

```text
dnsrecon -d <target domain> -z
```

## 9. Other Enumeration Techniques

### IPsec Enumeration

* IPsec uses Encapsulation Security Payload \(ESP\), Authentication Header \(AH\), and Internet Key Exchange \(IKE\) to secure communication between virtual private network \(VPN\) end points.
* Most IPsec based VPNs use Internet Security Association and Key Management Protocol \(ISAKMP\), a part of IKE, to establish, negotiate, modify, and delete Security Associations \(SA\) and cryptographic keys in a VPN environment.
* A simple scanning for ISAKMP at UDP port 500 can indicate the presence of a VPN gateway.
* Attackers can probe further using a tool, such as ike-scan, to enumerate sensitive information, including encryption and hashing algorithm, authentication type, key distribution algorithm, and SA LifeDuration.

```text
nmap –sU –p 500 <target IP address>
```

Attackers can probe further using fingerprinting tools such as ike-scan to enumerate sensitive information, including the encryption and hashing algorithm, authentication type, key distribution algorithm, and SA LifeDuration. In this type of scan, specially crafted IKE packets with an ISAKMP header are sent to the target gateway, and the responses are recorded. The following command is used for initial IPsec VPN discovery with ike-scan tool:

```text
ike-scan –M <target gateway IP address>
```

> ike-scan discovers IKE hosts and can fingerprint them using the retransmission backoff pattern.

### VoIP Enumeration

VoIP is an advanced technology that has replaced the conventional public switched telephone network \(PSTN\) in both corporate and home environments. VoIP uses internet infrastructure to establish connections for voice calls; data are also transmitted on the same network. However, VoIP is vulnerable to TCP/IP attack vectors. Session Initiation Protocol \(SIP\) is one of the protocols used by VoIP for performing voice calls, video calls, etc. over an IP network. This SIP service generally uses UDP/TCP ports 2000, 2001, 5050, and 5061.

Attackers use `Svmap` and `Metasploit` tools to perform VoIP enumeration.

Through VoIP enumeration, attackers can gather sensitive information such as VoIP gateway/servers, IP-private branch exchange \(PBX\) systems, and User-Agent IP addresses and user extensions of client software \(softphones\) or VoIP phones. This information can be used to launch various VoIP attacks such as DoS attacks, session hijacking, caller ID spoofing, eavesdropping, spam over Internet telephony \(SPIT\), and VoIP phishing \(Vishing\).

#### Svmap

Svmap is an open-source scanner that identifies SIP devices and PBX servers on a target network. It can be helpful for system administrators when used as a network inventory tool.

Attackers use Svmap to perform the following:

* Identify SIP devices and PBX servers on default and non-default ports.
* Scan large ranges of networks.
* Scan one host on different ports for an SIP service on that host or multiple hosts on multiple ports.
* Ring all the phones on a network simultaneously using the INVITE method.

Below screenshot shows an example for the enumeration of SIP device details using the Svmap tool through the following command:

```text
svmap <target network range>
```

#### Metasploit’s SIP Username Enumerator

```text
use auxiliary/scanner/sip/enumerator
```

### RCP Enumeration

* Remote Procedure Call \(RPC\) allows clients and servers to communicate in distributed client/server programs.
* Enumerating RPC endpoints enables attackers to identify any vulnerable services on these service ports.

The portmapper service listens on TCP and UDP port 111 to detect the endpoints and present clients, along with details of listening RPC services. Enumerating RPC endpoints enables attackers to identify any vulnerable services on these service ports. In networks protected by firewalls and other security establishments, this portmapper is often filtered. Therefore, attackers scan wide port ranges to identify RPC services that are open to direct attack.

Attackers use the following Nmap scan commands to identify the RPC service running on the network:

```text
nmap -sR <target IP/network> 
nmap -T4 –A <target IP/network>
```

Additionally, attackers use tools such as NetScanTools Pro to capture the RPC information of the target network. The NetScanTools Pro RPC Info tool helps attackers detect and access the portmapper daemon/service that typically runs on port 111 of Unix or Linux machines.

### Unix/Linux User Enumeration

Unix/Linux user enumeration provides a list of users along with details such as the username, host name, and start date and time of each session.

#### `rusers`

`rusers` displays a list of users who are logged in to remote machines or machines on the local network. It displays an output similar to the who command, but for the hosts/systems on the local network. Its syntax is as follows:

```text
/usr/bin/rusers [-a] [-l] [-u| -h| -i] [Host ...]
```

#### `rwho`

`rwho` displays a list of users who are logged in to hosts on the local network. Its output is similar to that of the who command and contains information about the username, host name, and start date and time of each session for all machines on the local network running the rwho daemon. Its syntax is as follows:

```text
rwho [ -a]
```

#### `finger`

`finger` displays information about system users such as the user’s login name, real name, terminal name, idle time, login time, office location, and office phone numbers. Its syntax is as follows:

```text
finger [-l] [-m] [-p] [-s] [user ...] [user@host ...]
```

### Telnet Enumeration

Attackers can further use the following script to enumerate information from remote Microsoft Telnet services with New Technology LAN Manager \(NTLM\) authentication enabled:

```text
nmap -p 23 --script telnet-ntlm-info <target IP>
```

Once the information about the target server is obtained, the attackers can use the following script to perform a brute-force attack against the Telnet server:

```text
nmap -p 23 –script telnet-brute.nse –script-args userdb=/root/Desktop/user.txt,passdb=/root/Desktop/pass.txt <target IP>
```

### SMB Enumeration

The SMB service also allows application users to read, write, and modify the files on the remote server. A network running this service is highly vulnerable to SMB enumeration, which provides a good amount of information about the target.

In SMB enumeration, attackers generally perform banner grabbing to obtain information such as OS details and versions of services running. By using this information, attackers can perform various attacks such as SMB relay attacks and brute-force attacks. Attackers can also use SMB enumeration tools such as `Nmap`, `SMBMap`, `enum4linux`, `nullinux`, and `NetScanTool Pro` to perform a directed scan on the SMB service running on port 445.

```text
nmap -p 445 -A <target IP>
```

In the above command, the option -p specifies a port to scan \(445 in this case\), and option -A is used for OS detection, version detection, script scanning, and traceroute information.

The STATE of PORT 445/tcp is OPEN, which indicates that port 445 is open and that the SMB service is running. By using this command, attackers can also obtain details on the OS and traceroute of the specified target.

### FTP Enumeration

The implementation of FTP in an organization’s network makes the data accessible to external sources. Attackers can scan and enumerate open port 21 running FTP services and further use this information to launch various attacks such as FTP bounce, FTP brute force, and packet sniffing.

Attackers also use Metasploit to enumerate FTP services running on remote hosts. The following commands can be used to detect the FTP version of the target server:

```text
use auxiliary/scanner/ftp/ftp_version 
msf auxiliary(scanner/ftp/ftp_version) > set RHOSTS <target IP> 
msf auxiliary(scanner/ftp/ftp_version) > exploit
```

### TFTP Enumeration

By default, TFTP servers listen on UDP port 69. This protocol is used when directory visibility and user authentication are not required; therefore, it provides no security features.

By using the enumerated information, attackers can further gain unauthorized access to the target system, steal important files, and upload malicious scripts to launch further attacks. Furthermore, this information enables attackers to perform various attacks such as DNS amplification attacks, TFTP reflection attacks, and DDoS attacks.

#### PortQry

The PortQry utility reports the port status of TCP and UDP ports on a selected target. Attackers can use the PortQry tool to perform TFTP enumeration. This utility reports the port status of target TCP and UDP ports on a local or remote computer.

```text
portqry -n <target domain> -e 69 -p udp
```

#### Nmap

Attackers can use the Nmap tool to perform simple direct scanning for TFTP port 69. As shown in the screenshot, the following Nmap command is used by attackers to enumerate the TFTP service running on the target domain:

```text
nmap -p 69 <target domain>
```

### IPv6 Enumeration

* IPv6 is an addressing protocol that provides identification to computer systems, including their location information and further assists in routing traffic from one system to the other across the network.
* Attackers perform IPv6 enumeration using various tools, such as Enyx and IPv6 Hackit, on target hosts to obtain their IPv6 addresses and further scan the enumerated IP addresses to detect various security problems.

Attackers perform IPv6 enumeration on target hosts to obtain their IPv6 addresses and further scan the enumerated IP addresses to detect various security problems such as access to routing structure, exposure of sensitive content, and users’ access control lists. By using this information, attackers can launch various attacks such as SYN flood attacks, DNS amplification attacks, and DDoS attacks. Attackers can scan and enumerate the IPv6 address of a target machine in the network by using various tools such as Enyx and IPv6 Hackit.

#### Enyx

Enyx is an enumeration tool that fetches the IPv6 address of a machine through SNMP.

```text
Python enyx.py 2c public <target IP>
```

#### IPv6 Hackit

Hackit is a scanning tool that provides a list of active IPv6 hosts. It can perform TCP port scanning and identify AAAA IPv6 host records.

Attackers can specify the target machine and run a scan to enumerate the IPv6 information.

### BGP Enumeration

* The Border Gateway Protocol \(BGP\) is a routing protocol used to exchange routing and reachability information between different autonomous systems \(AS\) on the Internet. Because this protocol is used to connect one AS to other ASs, it is also called external BGP \(eBGP\). BGP finds the shortest path to route traffic from one IP address to another efficiently. BGP creates its TCP session on port 179.
* Attackers perform BGP enumeration on the target using tools such as Nmap and BGP Toolkit to discover the IPv4 prefixes indicated by the AS number and the routing path followed by the target. Attackers use this information to launch various attacks against the target, such as man-in-the-middle attacks, BGP hijacking attacks, and DoS attacks.

```text
nmap -p 179 <target IP>
```

## 10. Enumeration Countermeasures

### SNMP

* Remove the SNMP agent or turn off the SNMP service.
* If shutting off SNMP is not an option, then change the default community string names.
* Upgrade to SNMP3, which encrypts passwords and messages.
* Implement the Group Policy security option called “Additional restrictions for anonymous connections”.
* Ensure that the access to null session pipes, null session shares, and IPSec filtering is restricted.
* Do not misconfigure SNMP service with read-write authorization.

### DNS

* Disable the DNS zone transfers to the untrusted hosts.
* Ensure that the private hosts and their IP addresses are not published in DNS zone files of public DNS servers.
* Use premium DNS registration services that hide sensitive information, such as host information \(HINFO\) from the public.
* Use standard network admin contacts for DNS registrations to avoid social engineering attacks.

### SMTP

Configure SMTP servers to:

* Ignore email messages to unknown recipients.
* Exclude sensitive mail server and local host information in mail responses.
* Disable open relay feature.
* Limit the number of accepted connections from a source to prevent brute-force attacks.

### LDAP

* By default, LDAP traffic is transmitted unsecured; use SSL or STARTTLS technology to encrypt the traffic.
* Select a username different from your email address and enable account lockout.
* Use NTLM or any basic authentication mechanism to limit access to legitimate users only.

### SMB

Common sharing services or other unused services may provide doorways for attackers to break into a network’s security. A network running SMB is at a high risk of enumeration. Since web and DNS servers do not require this protocol, it is advisable to disable it on them. The SMB protocol can be disabled by disabling the properties Client for Microsoft Networks and File and Printer Sharing for Microsoft Networks in Network and Dial-up Connections. On servers that are accessible from the Internet, also known as bastion hosts, SMB can be disabled by disabling the same two properties of the TCP/IP properties dialog box. Another method of disabling the SMB protocol on bastion hosts, without explicitly disabling it, is by blocking the ports used by the SMB service. These are TCP ports 139 and 445. Because disabling SMB services is not always a feasible option, other countermeasures against SMB enumeration may be required. Windows Registry can be configured to limit anonymous access from the Internet to a specified set of files. These files and folders are specified in the settings Network access: Named pipes that can be accessed anonymously and Network access: Shares that can be accessed anonymously. This configuration involves adding the RestrictNullSessAccess parameter to the registry key: HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters The RestrictNullSessAccess parameter takes binary values, with 1 denoting enabled and 0 denoting disabled. Setting this parameter to 1 or enabled restricts the access of anonymous users to the files specified in the Network access settings.

* Ensure that Windows Firewall or similar endpoint protection systems are enabled on the system.
* Install the latest security patches for Windows and third-party software. 
* Implement a proper authentication mechanism with a strong password policy. 
* Implement strong permissions to keep the stored information safe. 
* Perform a regular audit of system logs. 
* Perform active system monitoring to monitor the systems for any malicious incide
* Disable SMB protocol on Web and DNS Servers.
* Disable SMB protocol on Internet facing servers.
* Disable ports TCP 139 and TCP 445 used by the SMB protocol.
* Restrict anonymous access through RestrictNullSessAccess parameter from the Windows Registry.

### NFS

* Implement proper permissions \(read/write must be restricted to specific users\) on exported file systems.
* Implement firewall rules to block NFS port 2049.
* Ensure proper configuration of files, such as /etc/smb.conf, /etc/exports and etc/hosts.allow, to protect the data stored in servers.
* Log requests to access system files on the NFS server.
* Keep the root\_squash option in /etc/exports file turned ON, so that no requests made as root on the client are trusted.

### FTP

* FTP secure \(FTPS, which uses SSL\) to encrypt the FTP traffic over the network.
* Implement strong passwords or a certification-based authentication policy.
* Ensure that unrestricted uploading of files on the FTP server is not allowed.
* Disable anonymous FTP accounts; if not feasible, regularly monitor anonymous FTP accounts.
* Restrict access by IP or domain name to the FTP server.

## Module Summary

In this module, we have discussed the following:

* Enumeration concepts along with techniques, services, and ports used for enumeration
* How attackers perform enumeration using different techniques \(NetBIOS, SNMP, LDAP, NTP, NFS, SMTP, DNS, IPsec, VoIP, RPC, Linux/Unix, Telnet, FTP, TFTP, SMB, IPv6, and BGP enumeration\) to gather more information about a target
* How organizations can defend against enumeration activities

In the next module, we will discuss in detail how attackers, as well as ethical hackers and pen testers, perform vulnerability analysis to identify security loopholes in the target organization’s network, communication infrastructure, and end systems

This finishes active information gathering.

\[DNSRecon\]: [https://github.com/darkoperator/dnsrecon](https://github.com/darkoperator/dnsrecon) "Attackers use DNSRecon to check all NS records of the target domain for zone transfers. As shown in the screenshot, attackers use the following command for DNS zone transfer"

