# Module 03: Scanning Networks

{% hint style="info" %}
**Objectives**

* Understanding Network Scanning Concepts 
* Understanding various Scanning Tools 
* Understanding various Host Discovery and Port Scanning Techniques 
* Understanding OS Discovery 
* Understanding various Techniques to Scan Beyond IDS and Firewall 
* Drawing Network Diagrams
{% endhint %}

## 1. Network Scanning Concepts

* Network scanning refers to a set of procedures used for identifying hosts, ports, and services in a network.
* Network scanning is one of the components of intelligence gathering which can be used by an attacker to create a profile of the target organization

Objectives of Network Scanning:

* To discover live hosts, IP address, and open ports of live hosts 
* To discover operating systems and system architecture 
* To discover services running on hosts 
* To discover vulnerabilities in live hosts

![](../../.gitbook/assets/image%20%2852%29.png)

### TCP Communication Flags

The TCP header contains various flags that control the transmission of data across a TCP connection. Six TCP control flags manage the connection between hosts and give instructions to the system. Four of these flags \(SYN, ACK, FIN, and RST\) govern the establishment, maintenance, and termination of a connection. The other two flags \(PSH and URG\) provide instructions to the system. The size of each flag is 1 bit. As there are six flags in the TCP Flags section, the size of this section is 6 bits. When a flag value is set to “1,” that flag is automatically turned on.

| Flag | Meaning | Description |
| :--- | :--- | :--- |
| URG | Urgent | Data contained in the packet should be processed immediately.  When it is set to “1,” it indicates that the sender has raised the push operation to the receiver; this implies that the remote system should inform the receiving application about the buffered data coming from the sender. The system raises the PSH flag at the start and end of data transfer and sets it on the last segment of a file to prevent buffer deadlocks. |
| PSH | Push | Sends all buffered data immediately.   When it is set to “1,” it indicates that the sender has raised the push operation to the receiver; this implies that the remote system should inform the receiving application about the buffered data coming from the sender. The system raises the PSH flag at the start and end of data transfer and sets it on the last segment of a file to prevent buffer deadlocks. |
| FIN | Finish | There will be no further transmissions. It confirms the receipt of the transmission and identifies the next expected sequence number. When the system successfully receives a packet, it sets the value of its flag to “1,” thus implying that the receiver should pay attention to it. |
| ACK | Acknowledgement | Acknowledges the receipt of a packet. It confirms the receipt of the transmission and identifies the next expected sequence number. When the system successfully receives a packet, it sets the value of its flag to “1,” thus implying that the receiver should pay attention to it. |
| RST | Reset | Resets a connection. It confirms the receipt of the transmission and identifies the next expected sequence number. When the system successfully receives a packet, it sets the value of its flag to “1,” thus implying that the receiver should pay attention to it. |
| SYN | Synchronize | Initiates a connection between hosts. It confirms the receipt of the transmission and identifies the next expected sequence number. When the system successfully receives a packet, it sets the value of its flag to “1,” thus implying that the receiver should pay attention to it. |

![](../../.gitbook/assets/image%20%2846%29.png)

> SYN scanning mainly deals with three flags: SYN, ACK, and RST. You can use these three flags for gathering illegal information from servers during enumeration.

### TCP Communication

TCP is connection oriented, i.e., it prioritizes connection establishment before data transfer between applications. This connection between protocols is possible through the three-way handshake.

#### TCP Session Establishment

![](../../.gitbook/assets/image%20%2871%29.png)

A TCP session initiates using a three-way handshake mechanism:

* To launch a TCP connection, the source \(10.0.0.2:21\) sends a SYN packet to the destination \(10.0.0.3:21\).
* On receiving the SYN packet, the destination responds by sending a SYN/ACK packet back to the source.
* The ACK packet confirms the arrival of the first SYN packet to the source. 
* Finally, the source sends an ACK packet for the ACK/SYN packet transmitted by the destination.
* This triggers an "OPEN" connection, thereby allowing communication between the source and destination, which continues until one of them issues a "FIN" or "RST" packet to close the connection.

The TCP protocol maintains stateful connections for all connection-oriented protocols throughout the Internet and works similarly to ordinary telephone communication, in which one picks up a telephone receiver, hears a dial tone, and dials a number that triggers ringing at the other end until someone picks up the receiver and says, "Hello."

#### TCP Session Termination

After completing all the data transfers through the established TCP connection, the sender sends the connection termination request to the receiver through a FIN or RST packet. Upon receiving the connection termination request, the receiver acknowledges the termination request by sending an ACK packet to the sender and finally sends its own FIN packet. Then, the system terminates the established connection.

![](../../.gitbook/assets/image%20%2860%29.png)

## 2. Scanning Tools

### Nmap

* Network administrators can use Nmap for inventorying a network, managing service upgrade schedules, and monitoring host or service uptime 
* Attackers use Nmap to extract information such as live hosts on the network, open ports, services \(application name and version\), types of packet filters/ firewalls, as well as operating systems and versions used.

```text
nmap <options> <Target IP address>
```

### Hping2/Hping3

* Command line network scanning and packet crafting tool for the TCP/IP protocol.
* It can be used for network security auditing, firewall testing, manual path MTU discovery, advanced traceroute, remote OS fingerprinting, remote uptime guessing, TCP/IP stacks auditing, etc. 
* It can send custom TCP/IP packets and display target replies similarly to a ping program with ICMP replies. It handles fragmentation as well as arbitrary packet body and size, and it can be used to transfer encapsulated files under the supported protocols. It also supports idle host scanning.
* IP spoofing and network/host scanning can be used to perform an anonymous probe for services. Hping2/Hping3 also has a Traceroute mode, which enables attackers to send files between covert channels
* It also determines whether the host is up even when the host blocks ICMP packets. 
* Its firewalk-like usage allows the discovery of open ports behind firewalls. It performs manual path MTU discovery and enables attackers to perform remote OS fingerprinting.
* Using Hping, an attacker can study the behavior of an idle host and gain information about the target, such as the services that the host offers, the ports supporting the services, and the OS of the target. This type of scan is a predecessor to either heavier probing or outright attacks.

```text
# ICMP Ping: Hping performs an ICMP ping scan by specifying the argument -1 in the command line. You may use --ICMP or -1 as the argument in the command line. By issuing the above command, hping sends an ICMP echo request to 10.0.0.25 and receives an ICMP reply similarly to a ping utility.
hping3 -1 10.0.0.25 

# ACK scan on port 80: Hping can be configured to perform an ACK scan by specifying the argument -A in the command line. Here, you set the ACK flag in the probe packets and perform the scan. You perform this scan when a host does not respond to a ping request. By issuing this command, Hping checks if a host is alive on a network. If it finds a live host and an open port, it returns an RST response.
hping3 –A 10.0.0.25 –p 80 

# UDP scan on port 80:  Hping uses TCP as its default protocol. Using the argument -2 in the command line
specifies that Hping operates in the UDP mode. You may use either --udp or -2 as the argument in the command line.
hping3 -2 10.0.0.25 –p 80 

# Collecting Initial Sequence Number: Using the argument -Q in the command line, Hping collects all the TCP sequence numbers generated by the target host (192.168.1.103).
hping3 192.168.1.103 -Q -p 139 -s

# Firewalls and Timestamps: Many firewalls drop those TCP packets that do not have the TCP Timestamp option set. By adding the --tcp-timestamp argument in the command line, you can enable the TCP timestamp option in Hping and try to guess the timestamp update frequency and uptime of the target host (72.14.207.99).
hping3 -S 72.14.207.99 -p 80 --tcp-timestamp

# SYN scan on port 50-60: Using the argument -8 or --scan in the command line, you are operating Hping in the scan mode to scan a range of ports on the target host. Adding the argument -S allows you to perform a SYN scan. Therefore, the above command performs a SYN scan on ports 50–60 on the target host.
hping3 -8 50-60 –S 10.0.0.25 -V

# FIN, PUSH and URG scan on port 80: By adding the arguments –F, –P, and –U in the command line, you are setting FIN, PUSH, and URG packets in the probe packets. By issuing this command, you are performing FIN, PUSH, and URG scans on port 80 on the target host (10.0.0.25). If port 80 is open, you will not receive a response. If the port is closed, Hping will return an RST response.
hping3 –F –P –U 10.0.0.25 –p 80

# Scan entire subnet for live host: By issuing this command, Hping performs an ICMP ping scan on the entire subnet 10.0.1.x; in other words, it sends an ICMP echo request randomly (--rand-dest) to all the hosts from 10.0.1.0 to 10.0.1.255 that are connected to the interface eth0. The hosts whose ports are open will respond with an ICMP reply. In this case, you have not set a port; hence, Hping sends packets to port 0 on all IP addresses by default.
hping3 -1 10.0.1.x --rand-dest –I eth0

# Intercept all traffic containing HTTP signature: The argument -9 will set the Hping to the listen mode. Hence, by issuing the command -9 HTTP, Hping starts listening on port 0 (of all the devices connected in the network to interface eth0), intercepts all the packets containing the HTTP signature, and dumps from the signature end to the packet's end. For example, on issuing the command hping2 -9 HTTP, if Hping reads a packet that contains data 234-09sdflkjs45-HTTPhello_world, it will display the result as hello_world.
hping3 -9 HTTP –I eth0 

# SYN flooding a victim: The attacker employs TCP SYN flooding techniques using spoofed IP addresses to perform a DoS attack.
hping3 -S 192.168.1.1 -a 192.168.1.254 -p 22 --flood
```

### Metasploit

* [Metasploit](https://www.metasploit.com) is an open-source project that provides the infrastructure, content, and tools to perform penetration tests and extensive security auditing. It provides information about security vulnerabilities and aids in penetration testing and IDS signature development. It facilitates the tasks of attackers, exploits writers, and payload writers. A major advantage of the framework is the modular approach, i.e., allowing the combination of any exploit with any payload. 
* It enables you to automate the process of discovery and exploitation and provides you with the necessary tools to perform the manual testing phase of a penetration test. You can use Metasploit Pro to scan for open ports and services, exploit vulnerabilities, pivot further into a network, collect evidence, and create a report of the test results.

### NetScanTools Pro

NetScanTools Pro is an investigation tool that allows you to troubleshoot, monitor, discover, and detect devices on your network. Using this tool, you can easily gather information about the local LAN as well as Internet users, IP addresses, ports, and so on. Attackers can find vulnerabilities and exposed ports in the target system. It helps the attackers to list IPv4/IPv6 addresses, hostnames, domain names, email addresses, and URLs automatically or manually \(using manual tools\). NetScanTools Pro combines many network tools and utilities categorized by their functions, such as active, passive, DNS, and local computer.

### Other Tools

* [Unicornscan](https://sourceforge.net)
* [SolarWinds Port Scanner](https://www.solarwinds.com)
* [PRTG Network Monitor](https://www.paessler.com)
* [OmniPeek Network Protocol Analyzer](https://www.savvius.com)

#### For Mobile

* [IP Scanner](https://10base-t.com)
* [Fing](https://www.fing.io)
* [Network Scanner](https://play.google.com)

## 3. Host Discovery

* **Scanning** is the process of gathering information about **systems that are “alive” and responding on the network**.
* Host discovery is considered as the primary task in the network scanning process.
* Host discovery provides an accurate status of the systems in the network, which enables an attacker to avoid scanning every port on every system in a sea of IP addresses to identify whether the target host is up.

### Host Discovery Techniques

Host discovery techniques are used to identify the active/live systems in the network.

* ARP Ping Scan 
* UDP Ping Scan 
* ICMP Ping Scan 
  * ICMP ECHO Ping 
    * ICMP ECHO Ping Sweep
  * ICMP Timestamp Ping
  * ICMP Address Mask Ping
* TCP Ping Scan
  * TCP SYN Ping
  * TCP ACK Ping
* IP Protocol Scan

#### ARP Ping Scan

* Attackers send _ARP request probes_ to target hosts, and an _ARP_ response indicates that the _host is active_.
* Most reliable, but requires to be in the same subnet.
* In the ARP ping scan, the ARP packets are sent for discovering all active devices in the IPv4 range even though the presence of such devices is hidden by restrictive firewalls.
* In most networks, many IP addresses are unused at any given time, specifically in the private address ranges of the LAN. Hence, when the attackers try to send IP packets such as ICMP echo request to the target host, the OS must determine the hardware destination address \(ARP\) corresponding to the target IP for addressing the ethernet frame correctly.
* ARP scan is used to show the MAC address of the network interface on the device, and it can also show the MAC addresses of all devices sharing the same IPv4 address on the LAN.
* If the host IP with the respective hardware destination address is active, then the ARP response will be generated by the host; otherwise, after a certain number of ping attempts, the original OS gives up on the host.
* In other words, when attackers send ARP request probes to the target host, if they receive any ARP response, then the host is active.
* In case the destination host is found to be unresponsive, the source host adds an incomplete entry to the destination IP in its kernel ARP table.

Attackers use the Nmap tool to perform ARP ping scan for discovering live hosts in the network. In Zenmap, the -PR option is used to perform ARP ping scan.

> _Note_: -sn is the Nmap command to disable the port scan. Since Nmap uses ARP ping scan as the default ping scan, to disable it and perform other desired ping scans, you can use --disable-arp-ping.

![](../../.gitbook/assets/image%20%2875%29.png)

```text
nmap -sn -PR <HOST_IP>
```

Advantages:

* ARP ping scan is considered to be more efficient and accurate than other host discovery techniques.
* ARP ping scan automatically handles ARP requests, retransmission, and timeout at its own discretion.
* ARP ping scan is useful for system discovery, where you may need to scan large address spaces.
* ARP ping scan can display the response time or latency of a device to an ARP packet.

#### UDP Ping Scan

* Attackers send _UDP packets_ to the target host, and a _UDP response_ means that the target _host is active_.
* UDP ping scan is similar to TCP ping scan; however, in the UDP ping scan, Nmap sends UDP packets to the target host.
* The default port number used by Nmap for the UDP ping scan is 40,125.
  * This highly uncommon port is used as the default for sending UDP packets to the target.
  * This default port number can be configured using DEFAULT\_UDP\_PROBE\_PORT\_SPEC during compile time in Nmap.  
* If the target host is offline or unreachable, various error messages such as host/network unreachable or TTL exceeded could be returned. 
* Basically: port is reachable \(which doesn't mean the host is alive, the port can be also closed\).

![](../../.gitbook/assets/image%20%2851%29.png)

```text
nmap -sn -PU <HOST_IP>
```

Advantages:

* UDP ping scans have the advantage of detecting systems behind firewalls with strict TCP filtering, leaving the UDP traffic forgotten.

#### ICMP ECHO Ping

* Attackers use the ICMP ping scan to send ICMP packets to the destination system to gather all necessary information about it.
* This is because ICMP does not include port abstraction, and it is different from port scanning. 
* However, it is useful to determine what hosts in a network are running by pinging them all.
* ICMP ECHO ping scan involves sending ICMP ECHO requests to a host.
* If the host is alive, it will return an ICMP ECHO reply.

![](../../.gitbook/assets/image%20%2872%29.png)

```text
nmap -sn -PE <HOST_IP>
```

Advantages:

* This scan is useful for locating active devices or determining if ICMP is passing through a firewall.
* UNIX/Linux and BSD-based machines use ICMP echo scanning
  * The TCP/IP stack implementations in these OSs respond to the ICMP echo requests to the broadcast addresses. 

Disadvantage:

* This technique does not work on Windows-based networks, as their TCP/IP stack implementation does not reply to ICMP probes directed at the broadcast address.

**ICMP ECHO Ping Sweep**

Ping sweeps are among the oldest and slowest methods used to scan a network. This utility is distributed across nearly all platforms, and it acts as a roll call for systems; a system that is active on the network answers the ping query that another system sends out.

Although a single ping will tell the user whether a specified host computer exists on the network, a ping sweep consists of ICMP ECHO requests sent to multiple hosts.

* Ping sweep is used to determine the live hosts from a range of IP addresses by sending ICMP ECHO requests to multiple hosts. If a host is alive, it will return an ICMP ECHO reply.
* Attackers calculate subnet masks by using a Subnet Mask Calculator to identify the number of hosts that are present in the subnet
* Attackers subsequently use a ping sweep to create an inventory of live systems in the subnet.

ICMP echo scanning pings all the machines in the target network to discover live machines. Attackers send ICMP probes to the broadcast or network address, which relays to all the host addresses in the subnet. The live systems will send the ICMP echo reply message to the source of the ICMP echo probe.

When a system pings, it sends a single packet across the network to a specific IP address. This packet contains 64 bytes \(56 data bytes and 8 bytes of protocol header information\). The sender then waits or listens for a return packet from the target system.

![](../../.gitbook/assets/image%20%2835%29.png)

```text
nmap -sn -PE <IP_RANGE>
```

Disadvantages:

* Ping sweeps are among the oldest and slowest methods used to scan a network.

**Ping Sweep Tools**

* [Angry IP Scanner](https://www.angryip.org)
* [SolarWinds Engineer’s Toolset](https://www.solarwinds.com)
* [NetScanTools Pro](https://www.netscantools.com)
* [Colasoft Ping Tool](https://www.colasoft.com)
* [Visual Ping Tester](http://www.pingtester.net)
* [OpUtils](https://www.manageengine.com)

**Ping Sweep Countermeasures**

Some countermeasures for avoiding ping sweep are as follows:

* Configure the firewall to detect and prevent ping sweep attempts instantaneously.
* Use intrusion detection systems and intrusion prevention systems such as [Snort](https://www.snort.org) to detect and prevent ping sweep attempts.
* Carefully evaluate the type of ICMP traffic flowing through the enterprise networks.
* Terminate the connection with any host that is performing more than 10 ICMP ECHO requests.
* Use DMZ and allow only commands such as ICMP ECHO\_REPLY, HOST UNREACHABLE, and TIME EXCEEDED in DMZ Zone.
* Limit the ICMP traffic with Access Control Lists \(ACLs\) to your ISP’s specific IP addresses.

#### ICMP Timestamp Ping Scan

Besides the traditional ICMP ECHO ping, there are some other types of ICMP pinging techniques such as ICMP timestamp ping scan and ICMP address mask ping scan, which an attacker can adopt in specific conditions.

* These techniques are alternatives for the traditional ICMP ECHO ping scan and are used to determine whether the target host is live, specifically when the administrators block ICMP ECHO pings.
* ICMP timestamp ping is an optional and additional type of ICMP ping whereby the attackers query a timestamp message to acquire the information related to the current time from the target host machine. 
* The target machine responds with a timestamp reply to each timestamp query that is received.
* This ICMP timestamp pinging is generally used for time synchronization.

```text
nmap –sn –PP <target IP address>
```

Disadvantage:

* The response from the destination host is conditional, and it may or may not respond with the time value depending on its configuration by the administrator at the target’s end.

#### ICMP Timestamp Address Mask Ping Scan

* Like ICMP Timestamp Ping Scan, these techniques are alternatives for the traditional ICMP ECHO ping scan and are used to determine whether the target host is live, specifically when the administrators block ICMP ECHO pings.
* ICMP address mask ping is another alternative to the traditional ICMP ECHO ping, where the attackers send an ICMP address mask query to the target host to acquire information related to the subnet mask.

```text
nmap –sn –PM <target IP address>
```

Disadvantage:

* The address mask response from the destination host is conditional, and it may or may not respond with the appropriate subnet value depending on its configuration by the administrator at the target’s end. 

#### TCP SYN Ping Scan

* TCP SYN ping is a host discovery technique for probing different ports to determine if the port is online and to check if it encounters any firewall rule sets.
* In this type of host discovery technique, an attacker uses the Nmap tool to initiate the three-way handshake by sending the empty TCP SYN flag to the target host.
* After receiving SYN, the target host acknowledges the receipt with an ACK flag.
* After reception of the ACK flag, the attacker confirms that the target host is active and terminates the connection by sending an RST flag to the target host machine \(since his/her objective of host discovery is accomplished\).
* Port 80 is used as the default destination port. 
* A range of ports can also be specified in this type of pinging format without inserting a space between -PS and the port number \(e.g., PS22-25,80,113,1050,35000\), where the probe will be performed against each port parallelly.

![](../../.gitbook/assets/image%20%2870%29.png)

```text
nmap –sn –PS <target IP address>
```

Advantages:

* As the machines can be scanned parallelly, the scan never gets the time-out error while waiting for the response.
* TCP SYN ping can be used to determine if the host is active without creating any connection. Hence, the logs are not recorded at the system or network level, enabling the attacker to leave no traces for detection.

#### TCP ACK Ping Scan

* TCP ACK ping is similar to TCP SYN ping, albeit with minor variations. 
* TCP ACK ping also uses the default port 80. 
* In the TCP ACK ping technique, the attackers send an empty TCP ACK packet to the target host directly.
* Since there is no prior connection between the attacker and the target host, after receiving the ACK packet, the target host responds with an RST flag to terminate the request.
* The reception of this RST packet at the attacker’s end indicates that the host inactive.

![](../../.gitbook/assets/image%20%2838%29.png)

```text
nmap -sn -PA <target IP address>
```

Advantages:

* Both the SYN and the ACK packet can be used to maximize the chances of bypassing the firewall. However, firewalls are mostly configured to block the SYN ping packets, as they are the most common pinging technique. In such cases, the ACK probe can be effectively used to bypass these firewall rule sets easily.

#### IP Protocol Ping Scan

IP protocol ping is the latest host discovery option that sends IP ping packets with the IP header of any specified protocol number. It has the same format as the TCP and UDP ping. This technique tries to send different packets using different IP protocols, hoping to get a response indicating that a host is online.

* Multiple IP packets for ICMP \(protocol 1\), IGMP \(protocol 2\), and IP-in-IP \(protocol 4\) are sent by default when no protocols are specified. 
* For configuring the default protocols, change DEFAULT\_PROTO\_PROBE\_PORT\_SPEC in nmap.h during compile time. 
* For specific protocols such as ICMP, IGMP, TCP \(protocol 6\), and UDP \(protocol 17\), the packets are to be sent with proper protocol headers, and for the remaining protocols, only the IP header data is to be sent with the packets.
* In a nutshell, attackers send different probe packets of different IP protocols to the target host.
* Any response from any probe indicates that a host is online.

![](../../.gitbook/assets/image%20%2862%29.png)

```text
nmap -sn -PO <target IP address>
```

## 4. Port and Service Discovery

The next step in the network scanning process involves checking the open ports and services in live systems. After performing a ping scan, once attackers detect the live systems in the target network, they try to find open ports and services in the discovered live systems. This discovery of open ports and services can be performed via various port scanning techniques. Administrators often use port scanning techniques to verify the security policies of their networks, whereas attackers use them to identify open ports and running services on a host with the intent of compromising the network. Moreover, sometimes, users unknowingly keep unnecessary open ports on their systems. An attacker takes advantage of such open ports to launch attacks.

Port scanning techniques are further categorized as described below. This categorization is based on the type of protocol used for communication in the network.

**TCP Scanning:**

* Open TCP Scanning Methods 
  * TCP Connect/Full Open Scan
* Stealth TCP Scanning Methods 
  * Half-open Scan 
  * Inverse TCP Flag Scan
    * Xmas Scan 
    * FIN Scan 
    * NULL Scan 
    * Maimon Scan
* ACK Flag Probe Scan
  * TTL-Based Scan 
  * Window Scan
* Third Party and Spoofed TCP Scanning Methods
  * IDLE/IP ID Header Scan

**UDP Scanning:**

* UDP Scanning

**SCTP Scanning:**

* SCTP INIT Scanning 
* SCTP COOKIE/ECHO Scanning

**SSDP Scanning:**

* SSDP and List Scanning

**IPv6 Scanning:**

* IPv6 Scanning

### TCP Connect/Full Open Scan

* TCP Connect scan detects when a port is open after _completing the three-way handshake_.
* TCP Connect scan establishes a full connection and then closes the connection by sending an RST packet.
* In the TCP three-way handshake, the client sends a SYN packet, which the recipient acknowledges with a SYN+ACK packet.
* Then, the client acknowledges the SYN+ACK packet with an ACK packet to complete the connection. Once the handshake is completed, the scanner sends an RST packet to end the connection.

![](../../.gitbook/assets/image%20%2856%29.png)

```text
nmap -sT -v <target IP address>
```

Advantages:

* It does not require _superuser privileges_.
* Using non-blocking, I/O allows the attacker to set a short time-out period and watch all the sockets simultaneously. 

Disadvange:

* Making a separate connect\(\) call for every targeted port in a linear manner would take a long time over a slow connection. The attacker can accelerate the scan using many sockets in parallel.
* The drawback of this type of scan is that it is easily detectable and filterable.
* The logs in the target system will disclose the connection.

### Stealth Scan \(Half-open scan\)

* The stealth scan involves resetting the TCP connection between the client and the server abruptly before completion of the three-way handshake signals.
* This type of scan sends a single frame with the expectation of a single response. 
* The stealth scan is also called a “SYN scan,” because it only sends the SYN packet.
* TCP SYN or half-open scanning is a stealth method of port scanning. 

Process:

* The client sends a single SYN packet to the server on the appropriate port. 
* If the port is open, the server subsequently responds with a SYN/ACK packet. 
* If the server responds with an RST packet, then the remote port is in the "closed” state. 
* The client sends the RST packet to close the initiation before a connection can be established.

![](../../.gitbook/assets/image%20%2843%29.png)

```text
nmap -sS -v <target IP address>
```

Advantage:

* This prevents the service from notifying the incoming connection.
* Attackers use stealth scanning techniques to bypass firewall rules as well as logging mechanisms, and hide themselves under the appearance of regular network traffic.
* An inverted technique involves probing a target using a half-open SYN flag because the closed ports can only send the response back.

### Inverse TCP Flag Scan

* Attackers send _TCP probe packets with a TCP flag \(FIN, URG, PSH\) set or with no flags_, where **no response implies that the port is open**, whereas an RST response means that the port is closed.
* _According to RFC 793_, an RST/ACK packet is sent for connection reset when the host closes a port. Attackers take advantage of this feature to send TCP probe packets to each port of the target host with various TCP flags set.
* Common flag configurations used for a probe packet include:
  * A FIN probe with the FIN TCP flag set
  * An Xmas probe with the FIN, URG, and PUSH TCP flags set
  * A NULL probe with no TCP flags set
  * A SYN/ACK probe

![](../../.gitbook/assets/image%20%2830%29.png)

> **Note**: Inverse TCP flag scanning is known as FIN, URG, and PSH scanning based on the flag set in the probe packet. If there is no flag set, it is known as NULL scanning. If only the FIN flag is set, it is known as FIN scanning, and if all of FIN, URG, and PSH are set, it is known as Xmas scannin

Advantages:

* Avoids many IDS and logging systems; highly stealthy
* Security mechanisms such as firewalls and IDS detect the SYN packets sent to the sensitive ports of the targeted hosts. Programs such as Synlogger and Courtney are available to log half-open SYN flag scan attempts. At times, the probe packets enabled with TCP flags can pass through filters undetected, depending on the security mechanisms installed.

Disadvantages:

* Needs raw access to network sockets, thus requiring super-user privileges.
* Mostly effective against hosts using a BSD-derived TCP/IP stack \(not effective against **Microsoft Windows hosts**, in particular\).

#### Xmas Scan

* Using the Xmas scan, attackers send a TCP frame to a remote device with FIN, URG, and PUSH flags set.
* FIN scanning works only with OSes that use an RFC 793-based TCP/IP implementation.
* Attackers use the TCP Xmas scan to determine if ports are closed on the target machine via the RST packet. 

![](../../.gitbook/assets/image%20%2848%29.png)

```text
nmap -sX -v <target IP address>
```

**BSD Networking Code**: This method relies on the BSD networking code. Thus, you can use this only for UNIX hosts; it does not support Windows NT. If the user scans any Microsoft system, it will show that all the ports on the host are open. **Transmitting Packets**: You can initialize all the flags when transmitting the packet to a remote host. If the target system accepts the packet and does not send any response, it means that the port is open. If the target system sends an RST flag, then it implies that the port is close

Advantages:

* You can use this port scanning technique to scan large networks and find which host is up and what services it is offering.
* It avoids IDS and TCP three-way handshake.

Disadvantages:

* It works on the UNIX platform only.
* The Xmas scan will not work against any current version of Microsoft Windows.
* When all flags are set, some systems hang hence the flags are often set in the nonsense pattern URG-PSH-FIN.
* This scan only works when systems are compliant with RFC 793-based TCP/IP implementation. It will not work against any current version of Microsoft Windows.

#### TCP Maimon Scan

* This scan technique is very similar to NULL, FIN, and Xmas scan, but the probe used here is FIN/ACK.
* Attackers send FIN/ACK probes, and if there is no response, then the port is Open\|Filtered, but if an RST packet is sent in response, then the port is closed.
* Nmap interprets a port as open\|filtered when there is no response from the Maimon scan probe even after many retransmissions. 
* The port is closed if the probe gets a response as an RST packet.

![](../../.gitbook/assets/image%20%2841%29.png)

```text
nmap -sM -v <target IP address>
```

### ACK Flag Probe Scan

* Attackers send TCP probe packets set with an ACK flag to a remote device, **and then analyze the header information \(TTL and WINDOW field\) of received RST packets to determine if the port is open or closed**.
* If the **TTL value of the RST packet on a particular port is less than the boundary value of 64**, then that **port is open**.
* If the **window value of the RST packet** on a particular port **has a non-zero value**, then that **port is open**.
* ACK flag probe scanning can also be used to check the filtering system of a target.
* Attackers send an ACK probe packet with a random sequence number, and no response implies that the port is filtered \(stateful firewall is present\), whereas an RST response means that the port is not filtered
* When the returned RST value is zero, then the port is closed. 
* The ACK flag probe scan exploits the vulnerabilities within the BSD-derived TCP/IP stack.
* Thus, such scanning is effective only on those OSs and platforms on which the BSD derives TCP/IP stacks.

![](../../.gitbook/assets/image%20%2840%29.png)

Categories of ACK flag probe scanning include:

* **TTL-based ACK Flag Probe scanning**: 
  * In this scanning technique, you will first need to send ACK probe packets \(several thousands\) to different TCP ports and then analyze the **TTL field value** of the RST packets received. 
  * If the TTL value of the RST packet on a particular port is less than the boundary value of 64, then that port is open.

```text
nmap –ttl [time] [target]
```

* **Window-based ACK Flag Probe scanning**:
  * In this scanning technique, you will first need to send ACK probe packets \(several thousands\) to different TCP ports and then analyze the **window field value** of the received RST packets. 
  * * If the window value of the RST packet on a particular port is non-zero, then that port is open.
  * When the returned RST value is zero, then the port is closed. If there is no response even after many retransmissions and an ICMP unreachable error \(type 3, code 1, 2, 3, 9, 10, or 13\) is returned, then the port is inferred to be a filtered port.

![](../../.gitbook/assets/image%20%2850%29.png)

Advantages:

* This type of scan can evade IDS in most cases. 

Disadvantages:

* It is extremely slow and can exploit only older OSs with vulnerable BSD-derived TCP/IP stacks.

```text
nmap -sW [target]
```

**Checking the Filtering Systems of Target Networks**:

* The ACK flag probe scanning technique also helps in checking the filtering systems of target networks. The attacker sends an ACK probe packet to check the filtering mechanism \(firewalls\) of packets employed by the target network.
* Sending an ACK probe packet with a random sequence number and getting no response from the target means that the port is filtered \(stateful firewall is present\); an RST response from the target means that the port is not filtered \(no firewall is present\).

![](../../.gitbook/assets/image%20%2874%29.png)

**ACK Flag Probe Scanning using Nmap**:

```text
nmap -sA <target IP address>
```

### IDLE/IP ID Header Scan

The IDLE/IPID Header scan is a TCP port scan method that you can use to send a spoofed source address to a computer to find out what services are available. It offers complete blind scanning of a remote host. Most network servers listen on TCP ports, such as web servers on port 80 and mail servers on port 25. A port is considered “open” if an application is listening on the port. One way to determine whether a port is open is to send a "SYN" \(session establishment\) packet to the port. The target machine will send back a "SYN\|ACK" \(session request acknowledgement\) packet if the port is open or an "RST" \(Reset\) packet if the port is closed. A machine that receives an unsolicited SYN\|ACK packet will respond with an RST. An unsolicited RST will be ignored. Every IP packet on the Internet has a "fragment identification" number \(IPID\). The OS increases the IPID for each packet sent; thus, probing an IPID gives an attacker the number of packets sent since the last probe.

* Every IP packet on the Internet has a fragment identification number \(IPID\); an OS increases the IPID for each packet sent, thus, probing an IPID gives an attacker the number of packets sent after the last probe.
* A machine that receives an **unsolicited SYN\|ACK packet** will respond with an RST. An unsolicited RST will be ignored

Process: 1. Send SYN + ACK packet to the zombie machine to probe its IPID number. 2. A zombie machine not expecting an SYN + ACK packet will send an RST packet, disclosing the IPID. Analyse the RST packet from the zombie machine to extract the IPID. 3. Send a SYN packet to the target machine \(port 80\) to spoof the IP address of the “zombie”. 4. If the port is open, the target will send a SYN+ACK packet to the zombie, and the zombie will send an RST to the target in response. 5. If the port is closed, the target will send an RST to the zombie, but the zombie will not send anything back. 6. Probe the zombie IPID again. An IPID increased by 2 will indicate an open port, whereas an IPID increased by 1 will indicate a closed port.

The attacker performs this scan by impersonating another computer via spoofing. The attacker does not send a packet from her/his IP address; instead, he/she uses another host, often called a “zombie,” to scan the remote host and identify any open ports.

![](../../.gitbook/assets/image%20%2861%29.png)

```text
nmap -sI ... # todo: complete, no example
```

### UDP Scanning

* UDP port scanners use the UDP protocol instead of TCP.
* There is no three-way handshake for the UDP scan.
* If you send a UDP packet to a port without an application bound to it, the IP stack will return an ICMP port unreachable packet.
* If any port returns an ICMP error, it will be closed, leaving the ports that did not answer if they are open or filtered through the firewall.
* This happens because open ports do not have to send an acknowledgement in response to a probe, and closed ports are not even required to send an error packet. 

UDP Port Open:

* There is no three-way TCP handshake for UDP scanning.
* The system does not respond with a message when the port is open.

UDP Port Closed:

* If a UDP packet is sent to a closed port, the system will respond with an ICMP port unreachable message.
* Spywares, Trojan horses, and other malicious applications use UDP ports.

![](../../.gitbook/assets/image%20%2839%29.png)

```text
nmap -sU -v <target IP address>
```

Advantages:

* The UDP scan is less informal with regard to an open port because there is no overhead of a TCP handshake.
* Microsoft-based OSs do not usually implement any ICMP rate limiting; hence, this scan operates very efficiently on Windows-based devices.

Disadvantages:

* The UDP protocol can be more challenging to use than TCP scanning because you can send a packet but you cannot determine whether the host is alive, dead, or filtered.
* This scanning technique is slow because it limits the ICMP error message rate as a form of compensation to machines that apply RFC 1812 section 4.3.2.8. 
* A remote host will require access to the raw ICMP socket to distinguish closed ports from unreachable ports.
* If ICMP is responding to each unavailable port, the total number of frames can exceed that from a TCP scan.
* The UDP scan provides port information only. If additional information of the version is needed, the scan must be supplemented with a version detection scan \(-sV\) or the OS fingerprinting option \(-O\). 
* The UDP scan requires privileged access; hence, this scan option is only available on systems with the appropriate user permissions.
* Most networks have massive amounts of TCP traffic; as a result, the efficiency of the UDP scan is low. 
* The UDP scan will locate open ports and provide the security manager with valuable information for identifying successful attacker invasions on open UDP ports owing to spyware applications, Trojan horses, and other malicious software.

### SCTP Scanning

* Stream Control Transport Protocol \(SCTP\) is a reliable message-oriented transport layer protocol. It is used as an alternative to the TCP and UDP protocols, as its characteristics are similar to those of TCP and UDP. 
* SCTP is specifically used to perform multi-homing and multi-streaming activities.
* Some SCTP applications include discovering VoIP, IP telephony, and Signaling System 7/SIGnaling TRANsport \(SS7/SIGTRAN\)-related services. 
* SCTP association comprises a four-way handshake method, as shown in the screenshot below.

![](../../.gitbook/assets/image%20%2869%29.png)

#### SCTP INIT Scanning

* The INIT scan is performed quickly by scanning thousands of ports per second on a fast network not obstructed by a firewall offering a stronger sense of security.
* The SCTP INIT scan is very similar to the TCP SYN scan.
* It is also stealthy and unobtrusive, as it cannot complete SCTP associations, hence making the connection half-open.
* Attackers send INIT chunk to the target host. If the port is listening or open, it sends an acknowledgement as an INIT+ACK chunk.
* If the target is inactive and it is not listening, then it sends an acknowledgement as an ABORT chunk.
* After several retransmissions, if there is no response, then the port is indicated as a filtered port.
* The port is also indicated as a filtered port if the target server responds with an ICMP unreachable exception \(type 3, code 0, 1, 2, 3, 9, 10, or 13\).

![](../../.gitbook/assets/image%20%2842%29.png)

```text
nmap -sY <target IP address>
```

Advantages:

* INIT scan can clearly differentiate between various ports such as open, closed, and filtered states

#### SCTP ECHO Scanning

* SCTP COOKIE ECHO scan is a more advanced type of scan.
* In this type of scan, attackers send the COOKIE ECHO chunk to the target, and if the target port is open, it will silently drop the packets onto the port and you will not receive any response from the target.
* If the target sends back the ABORT chunk response, then the port is considered as a closed port. 
* The COOKIE ECHO chunk is not blocked by non-stateful firewall rule sets as in the INIT scan.

![](../../.gitbook/assets/image%20%2863%29.png)

```text
nmap -sZ <target IP address>
```

Advantages:

* Only an advanced IDS can detect the SCTP COOKIE ECHO scan.
* The port scan is not as conspicuous as the INIT scan.

Disadvantages:

* SCTP COOKIE ECHO scan cannot differentiate clearly between open and filtered ports, and it shows the output as open\|filtered in both cases.

### SSDP Scanning

* Simple Service Discovery Protocol \(SSDP\) is a network protocol that generally communicates with machines when querying them with routable IPv4 or IPv6 multicast addresses. 
* The SSDP service controls communication for the Universal Plug and Play \(UPnP\) feature. 
* It generally works when the machine is not firewalled.
* However, it can sometimes work through a firewall.
* The SSDP service will respond to a query sent over IPv4 or IPv6 broadcast addresses.
* This response includes information about the UPnP feature associated with it. 
* The attacker uses SSDP scanning to detect UPnP vulnerabilities that may allow him/her to launch buffer overflow or DoS attacks.

#### SSDP and List Scanning

* The Simple Service Discovery Protocol \(SSDP\) is a network protocol that works in conjunction with the UPnP to detect plug and play devices. 
* Vulnerabilities in UPnP may allow attackers to launch Buffer overflow or DoS attacks.
* Attacker may use the UPnP SSDP M-SEARCH informationdiscovery tool to check if the machine is vulnerable to UPnP exploits or not.
* This type of scan simply generates and prints a list of IPs/Names without actually pinging them.
* A reverse DNS resolution is performed to identify the host names.

In a list scan, the discovery of the active network host is indirect. A list scan simply generates and prints a list of IPs/Names without actually pinging or scanning the hosts. As a result, the list scan shows all IP addresses as “not scanned” \(0 hosts up\).

```text
nmap -sL <target IP address>
```

Advantages:

* A list scan can perform a good sanity check.
* The list scan detects incorrectly defined IP addresses in the command line or in an option file. It primarily repairs the detected errors to run any “active” scan.

### IPv6 Scanning

* IPv6 increases the IP address size from 32 bits to 128 bits to support more levels of address hierarchy.
* Attackers need to harvest IPv6 addresses from network traffic, recorded logs, or Received from: header lines in archived emails.
* Additionally, a number of scanning tools do not support ping sweeps on IPv6 networks.

```text
nmap -6 <target address>
```

Disadvantage:

* Scanning an IPv6 network provides a large number of hosts in a subnet; if an attacker can compromise one subnet host, he/she can probe the "all hosts" link local multicast address if the hosts numbers are sequential or use any regular scheme. An attacker needs to analyze 2^64 addresses to verify if a particular open service is running on a host in that subnet.
* At a conservative rate of one probe per second, such a scan would take about 5 billion years to complete.

### Service Version Discovery

* Also called Banner Grabbing.
* Service version detection helps attackers to obtain information about running services and their versions on a target system.
* Obtaining an accurate service version number allows attackers to determine the vulnerability of target system to particular exploits.
* For example, when an attacker detects SMBv1 protocol as a running service on a target Windows-based machine, then the attacker can easily perform the WannaCry ransomware attack with the help of the eternalblue and doublepulsar backdoor combination in Metasploit.

```text
nmap -sV <target IP address>
```

The version detection technique is nothing but examination of the TCP and UDP ports.

The probes from the Nmap service-probes database are used for querying various services and matching expressions for recognizing and parsing responses.

### Nmap Scan Time Reduction Techniques

In Nmap, performance and accuracy can be achieved by reducing the scan timing. Scan Time Reduction Techniques:

1. Omit Non-critical Tests 
   * Avoiding an intense scan if only a minimal amount of information is required.
   * The number of ports scanned can be limited using specific commands.
   * The port scan \(-sn\) can be skipped if and only if one has to check whether the hosts are online or not.
   * Advanced scan types \(-sC, -sV, -O, --traceroute, and -A\) can be avoided.
   * The DNS resolution should be turned on only when it is necessary
2. Optimize Timing 
   * To control the scan activity, Nmap provides the -T option for scanning ranging from high-level to low-level timing aggressiveness. This can be extremely useful for scanning highly filtered networks.
3. Parameters Separate and Optimize UDP Scans
   * As many vulnerable services use the UDP protocol, scanning the UDP protocol is vital, and it should be scanned separately, as TCP scans have different performance requirements and timing characteristics.
   * Moreover, the UDP scan is more affected by the ICMP error rate-limiting compared to the TCP scan.
4. Upgrade Nmap 
   * It is always advisable to use the upgraded version of Nmap as it contains many bug fixes, important algorithmic enhancements, and high-performance features such as local network ARP scanning.
5. Execute Concurrent Nmap Instances
   * Running Nmap against the whole network usually makes the system slower and less efficient.
   * Nmap supports parallelization and it can also be customized according to specific needs. 
   * It becomes very efficient by getting an idea of the network reliability while scanning a larger group.
   * The overall speed of the scan can be improved by dividing it into many groups and running them simultaneously.
6. Scan from a Favorable Network Location
   * It is always advisable to run Nmap from the host’s local network to the target while in the internal network, as it offers defense-in-depth security. 
   * External scanning is obligatory when performing firewall testing or when the network should be monitored from the external attacker’s viewpoint. 
7. Increase Available Bandwidth and CPU Time 
   * By increasing the available bandwidth or CPU power, the Nmap scan time can be reduced. 
   * This can be done by installing a new data line or stopping any running applications.
   * Nmap is controlled by its own congestion control algorithms, so that network flooding can be prevented. This improves its accuracy.
   * The Nmap bandwidth usage can be tested by running it in the verbose mode -v.

### Port Scanning Countermeasures

As discussed previously, port scanning provides a large amount of useful information to the attacker, such as IP addresses, host names, open ports, and services running on ports. Open ports specifically offer an easy means for the attacker to break into the network. However, there is no cause for concern, provided that you secure your system or network against port scanning by adopting the following countermeasures.

1. Configure firewall and IDS rules to detect and block probes.
2. Run port scanning tools against hosts on the network to determine whether the firewall properly detects port scanning activity.
3. Ensure that the mechanisms used for routing by routers and for filtering by firewalls cannot be bypassed using particular source ports or source-routing methods.
4. Ensure that the router, IDS, and firewall firmware are updated to their latest releases/versions.
5. Use a custom rule set to lock down the network and block unwanted ports at the firewall.
6. Filter all ICMP messages \(i.e., inbound ICMP message types and outbound ICMP type 3 unreachable messages\) at the firewalls and routers.
7. Perform TCP and UDP scanning along with ICMP probes against your organization’s IP address space to check the network configuration and its available ports.
8. Ensure that anti-scanning and anti-spoofing rules are properly configured.
9. Configure commercial firewalls to protect your network against fast port scans and SYN floods. You can run tools such as port entry to detect and stop port scan attempts on Linux/UNIX systems.
10. Hackers use tools such as Nmap and perform OS detection to sniff the details of a remote OS. Thus, it is important to employ intrusion detection systems in such cases. Snort \([https://www.snort.org](https://www.snort.org)\) is an intrusion detection and prevention technology that is very useful, mainly because signatures are frequently available from the public authors.
11. Keep as few ports open as possible and filter the rest, as the intruder will try to enter through any open port. Use a custom rule set to lock down the network, block unwanted ports at the firewall, and filter the following ports: 135–159, 256–258, 389, 445, 1080, 1745, and 3268.
12. Block unwanted services running on the ports and update the service versions.
13. Ensure that the versions of services running on the ports are non-vulnerable.
14. Attackers try to perform source routing and send packets to the targets \(which may not be reachable via the Internet\) using an intermediate host that can interact with the target. Hence, it is necessary to ensure that your firewall and router can block such source-routing techniques.
15. Ensure that the mechanism used for routing and filtering at the routers and firewalls, respectively, cannot be bypassed using a particular source port or source-routing methods.
16. Test your IP address space using TCP and UDP port scans as well as ICMP probes to determine the network configuration and accessible po
17. If a commercial firewall is in use, then ensure that:
    * It is patched with the latest update.
    * It has correctly defined antispoofing rules.
    * Its fastmode services are unusable in Check Point Firewall-1 environments

## 5. OS Discovery \(Banner Grabbing / OS Fingerprinting\)

* An attacker uses OS discovery or banner grabbing techniques to identify network hosts running application and OS versions with known exploits. 
* Identifying the OS used on the target host allows an attacker to figure out the vulnerabilities possessed by the system and the exploits that might work on a system to further carry out additional attack.
* An attacker uses banner grabbing to identify the OS used on the target host and thus determine the system vulnerabilities and exploits that might work on that system to carry out further attacks.

**Active Banner Grabbing**

* Specially crafted packets are sent to the remote OS and the responses are noted.
* The responses are then compared with a database to determine the OS.
* Responses from different OSes vary due to differences in the TCP/IP stack implementation.
* Active banner grabbing applies the principle that an OS’s IP stack has a unique way of responding to specially crafted TCP packets.
* This happens because of different interpretations that vendors apply while implementing the TCP/IP stack on a particular OS.
* In active banner grabbing, the attacker sends a variety of malformed packets to the remote host, and the responses are compared with a database.
* Responses from different OS vary because of differences in TCP/IP stack implementation.
* For instance, the scanning utility Nmap uses a series of nine tests to determine an OS fingerprint or banner grabbing. The tests listed below provide some insights into an active banner grabbing attack, as described at www.packetwatch.net: 
  * Test 1: A TCP packet with the SYN and ECN-Echo flags enabled is sent to an open TCP port.
  * Test 2: A TCP packet with no flags enabled is sent to an open TCP port. This type of packet is a NULL packet.
  * Test 3: A TCP packet with the URG, PSH, SYN, and FIN flags enabled is sent to an open TCP port.
  * Test 4: A TCP packet with the ACK flag enabled is sent to an open TCP port. 
  * Test 5: A TCP packet with the SYN flag enabled is sent to a closed TCP port. 
  * Test 6: A TCP packet with the ACK flag enabled is sent to a closed TCP port. 
  * Test 7: A TCP packet with the URG, PSH, and FIN flags enabled is sent to a closed TCP port.
  * Test 8 PU \(Port Unreachable\): A UDP packet is sent to a closed UDP port. The objective is to extract an “ICMP port unreachable” message from the target machine.
  * Test 9 TSeq \(TCP Sequence ability test\): This test tries to determine the sequence generation patterns of the TCP initial sequence numbers \(also known as TCP ISN sampling\), the IP identification numbers \(also known as IPID sampling\), and the TCP timestamp numbers. It sends six TCP packets with the SYN flag enabled to an open TCP port.

The objective of these tests is to find patterns in the initial sequence of numbers that the TCP implementations chose while responding to a connection request. They can be categorized into groups, such as traditional 64K \(many old UNIX boxes\), random increments \(newer versions of Solaris, IRIX, FreeBSD, Digital UNIX, Cray, and many others\), or true random \(Linux 2.0.\*, OpenVMS, newer AIX, etc.\). Windows boxes use a "time-dependent" model in which the ISN is incremented by a fixed amount for each occurrence.

**Passive Banner Grabbing**

Instead of relying on scanning the target host, passive fingerprinting captures packets from the target host via sniffing to study telltale signs that can reveal an OS.

* Banner grabbing from error messages: Error messages provide information such as the type of server, type of OS, and SSL tool used by the target remote system.
* Sniffing the network traffic: Capturing and analyzing packets from the target enables an attacker to determine the OS used by the remote system. 
* Banner grabbing from page extensions: Looking for an extension in the URL may assist in determining the application’s version.

The four areas that typically determine the OS are given below:

* TTL \(time to live\) of the packets: What does the OS sets as the Time To Live on the outbound packet?
* Window Size: What is the Window size set by the OS? 
* Whether the DF \(Don’t Fragment\) bit is set: Does the OS set the DF bit? 
* TOS \(Type of Service\): Does the OS set the TOS, and if so, what setting is it?

Passive fingerprinting is neither fully accurate nor limited to these four signatures. However, one can improve its accuracy by looking at several signatures and combining the information.

### How to Identify Target System OS

* Attackers can identify the OS running on the target machine by looking at the Time To Live \(TTL\) and TCP window size in the IP header of the first packet in a TCP session.
* Sniff/capture the response generated from the target machine using packet-sniffing tools like Wireshark and observe the TTL and TCP window size fields.
* The TTL field determines the maximum time that a packet can remain in a network, and the TCP window size determines the length of the packet reported. 

| Operating System | Time To Live | TCP Window Size |
| :--- | :--- | :--- |
| Linux \(Kernel 2.4 and 2.6\) | 64 | 5840 |
| Google Linux | 64 | 5720 |
| FreeBSD | 64 | 65535 |
| OpenBSD | 64 | 16384 |
| Windows 95 | 32 | 8192 |
| Windows 2000 | 128 | 16384 |
| Windows XP | 128 | 65535 |
| Windows 98, Vista, and 7 \(Server 2008\) | 128 | 8192 |
| iOS 12.4 \(Cisco Routers\) | 255 | 4128 |
| Solaris 7 | 255 | 8760 |
| AIX 4.3 | 64 | 16384 |

Attackers can use various tools to perform OS discovery on the target machine, including Wireshark, Nmap, Unicornscan, and Nmap Script Engine. Attackers can also adopt the IPv6 fingerprinting method to grab the target OS details.

#### OS Discovery using Wireshark

* To identify the target OS, sniff/capture the response generated from the target machine to the request-originated machine using packet-sniffing tools such as Wireshark, etc., and observe the TTL and TCP window size fields in the first captured TCP packet. 
* By comparing these values with those in the above table, you can determine the target OS that has generated the response.

#### OS Discovery using Nmap

```text
nmap -O <target IP address>
```

#### OS Discovery using Unicornscan

In Unicornscan, the OS of the target machine can be identified by observing the TTL values in the acquired scan result.

```text
#unicornscan <target IP address>
```

Example: The ttl value acquired after the scan is 128; hence, the OS is possibly Microsoft Windows \(Windows 7/8/8.1/10 or Windows Server 2008/12/16\).

#### OS Discovery using Nmap Script Engine

* Nmap script engine \(NSE\) can be used to automate a wide variety of networking tasks by allowing the users to write and share scripts
* Attackers use various scripts in the Nmap Script Engine to perform OS discovery on the target machine.
* For example, in Nmap, smb-os-discovery is an inbuilt script that can be used for collecting OS information on the target machine through the SMB protocol.
* In Zenmap, the -sC option or –script option is used to activate the NSE scripts

```text
nmap --script smb-os-discovery.nse <target IP address>
```

#### OS Discovery using IPv6 Fingerprinting

* IPv6 Fingerprinting is another technique used to identify the OS running on the target machine. 
* It has the same functionality as IPv4, such as sending probes, waiting and collecting the responses, and matching them with the database of fingerprints.
* The difference between IPv6 and IPv4 fingerprinting is that IPv6 uses several additional advanced IPv6-specific probes along with a separate IPv6-specifc OS detection engine.

```text
nmap -6 -O <target IP address>
```

#### Banner Grabbing Countermeasures

**Disabling or Changing Banner**

Whenever a port is open, it implies that a service/banner is running on it. When attackers connect to the open port using banner grabbing techniques, the system presents a banner containing sensitive information such as OS, server type, and version. Using the information gathered, the attacker identifies specific vulnerabilities to exploit and then launches attacks. The countermeasures against banner grabbing attacks are as follows:

* Display false banners to mislead or deceive attackers. o Turn off unnecessary services on the network host to limit information disclosure. o Use ServerMask \([https://www.port80software.com](https://www.port80software.com)\) tools to disable or change banner information.
* ServerMask removes unnecessary HTTP header and response data and camouflages the server by providing false signatures. It also provides you with the option of eliminating file extensions such as .asp or .aspx, and it clearly indicates that a site is running on a Microsoft server.
* Apache 2.x with mod\_headers module: use a directive in the httpd.conf file to change the banner information header and set the server as "New Server Name”.
* Alternatively, change the ServerSignature line to ServerSignatureOff in the httpd.conf file.
* The details of the vendor and version in the banners should be disabled. 

**Hiding File Extensions from Web Pages**

* File extensions reveal information about the underlying server technology that an attacker can use to launch attacks. The countermeasures against such banner grabbing attacks are as follows:
* Hide file extensions to mask the web technology. 
* Replace application mappings such as .asp with .htm or .foo, etc., to disguise the identity of the servers.
* Apache users can use mod\_negotiation directives. 
* IIS users can use tools such as PageXchanger to manage the file extensions.

Note: It would be better if the file extensions are not used at all.

## 6. Scanning Beyond IDS and Firewall

Intrusion detection systems \(IDS\) and firewalls are security mechanisms intended to prevent an attacker from accessing a network. However, even IDS and firewalls have some security limitations. Attackers try to launch attacks to exploit these limitations. This section highlights various IDS/firewall evasion techniques such as packet fragmentation, source routing, IP address spoofing, etc.

### IDS/Firewall Evasion Techniques

Although firewalls and IDS can prevent malicious traffic \(packets\) from entering a network, attackers can send intended packets to the target that evade the IDS/firewall by implementing the following techniques:

1. **Packet Fragmentation**: The attacker sends fragmented probe packets to the intended target, which reassembles the fragments after receiving all of them.
2. **Source Routing**: The attacker specifies the routing path for the malformed packet to reach the intended target.
3. **Source Port Manipulation**: The attacker manipulates the actual source port with the common source port to evade the IDS/firewall.
4. **IP Address Decoy**: The attacker generates or manually specifies IP addresses of decoys so that the IDS/firewall cannot determine the actual IP address.
5. **IP Address Spoofing**: The attacker changes the source IP addresses so that the attack appears to be coming from someone else.
6. **Creating Custom Packets**: The attacker sends custom packets to scan the intended target beyond the firewalls.
7. **Randomizing Host Order**: The attacker scans the number of hosts in the target network in a random order to scan the intended target that lies beyond the firewall.
8. **Sending Bad Checksums**: The attacker sends packets with bad or bogus TCP/UPD checksums to the intended target.
9. **Proxy Servers**: The attacker uses a chain of proxy servers to hide the actual source of a scan and evade certain IDS/firewall restrictions.
10. **Anonymizers**: The attacker uses anonymizers, which allows them to bypass Internet censors and evade certain IDS and firewall rules.

#### 1. Packet Fragmentation

* Packet fragmentation refers to the splitting of a probe packet into several smaller packets \(fragments\) while sending it to a network.
* The TCP header is split into several packets so that the packet filters are not able to detect what the packets are intended to do.
* When these packets reach a host, the IDS and firewalls behind the host generally queue all of them and process them one by one. 
* Since this method of processing involves greater CPU and network resource consumption, the configuration of most IDS cause them to skip fragmented packets during port scans.
* Attackers use packet fragmentation tools such as Nmap and fragroute to split the probe packet into smaller packets that circumvent the port-scanning techniques employed by IDS.
* Once these fragments reach the destined host, they are reassembled to form a single packet.

**SYN/FIN Scanning Using IP Fragments**:

* SYN/FIN scanning using IP fragments is not a new scanning method but a modification of previous techniques. 
* This process of scanning was developed to avoid false positives generated by other scans because of a packet filtering device on the target system. 
* The initialized flags in the next packet allow the remote host to reassemble the packets upon receipt via an Internet protocol module that detects the fragmented data packets using field-equivalent values of the source, destination, protocol, and identification.
* The system splits the TCP header into several fragments and transmits them over the network.
* IP reassembly on the server side may result in unpredictable and abnormal results, such as fragmentation of the IP header data.

![](../../.gitbook/assets/image%20%2845%29.png)

SYN/FIN scan using the Nmap tool:

```text
nmap -sS -T4 -A -f -v <target IP address>
```

Advantages:

* Since many IDS use signature-based methods to indicate scanning attempts on IP and/or TCP headers, the use of fragmentation will often evade this type of packet filtering and detection, resulting in a high probability of causing problems on the target network. 
* Attackers use the SYN/FIN scanning method with IP fragmentation to evade this type of filtering and detection. 

Disadvanges:

* Some hosts may fail to parse and reassemble the fragmented packets, which may lead to crashes, reboots, or even network device monitoring dumps.
* Some firewalls might have rule sets that block IP fragmentation queues in the kernel \(e.g., CONFIG\_IP\_ALWAYS\_DEFRAG option in the Linux kernel\), although this is not widely implemented because of its adverse effects on performance.

#### 2. Source Routing

* You are listing yourself as a router, although you are spoofing another IP in the netowrk. In the way back, as you werew listed as a router, response from destination will need to go through you.
* An IP datagram contains various fields, including the IP options field, which stores source routing information and includes a list of IP addresses through which the packet travels to its destination.
* As the packet travels through the nodes in the network, each router examines the destination IP address and chooses the next hop to direct the packet to the destination.
* When attackers send malformed packets to a target, these packets hop through various routers and gateways to reach the destination.
* In some cases, the routers in the path might include configured firewalls and IDS that block such packets.
* To avoid them, attackers enforce a loose or strict source routing mechanism, in which they manipulate the IP address path in the IP options field so that the packet takes the attacker-defined path \(without firewall-/IDS-configured routers\) to reach the destination, thereby evading firewalls and IDS.

This figure shows source routing, where the originator dictates the eventual route of the traffic:

![](../../.gitbook/assets/image%20%2855%29.png)

#### 3. Source Port Manipulation

* Source port manipulation is a technique used for bypassing the IDS/firewall, where the actual port numbers are manipulated with common port numbers for evading certain IDS and firewall rules. 
* The main security misconfigurations occur because of blindly trusting the source port number. 
* The administrator mostly configures the firewall by allowing the incoming traffic from well-known ports such as HTTP, DNS, FTP, etc. The firewall can simply allow the incoming traffic from the packets sent by the attackers using such common ports.
* Although the firewalls can be made secure using application-level proxies or protocol-parsing firewall elements, this technique helps the attacker to bypass the firewall rules easily.
* The attacker tries to manipulate the original port number with the common port numbers, which can easily bypass the IDS/firewall.

![](../../.gitbook/assets/image%20%2859%29.png)

```text
# Nmap uses the -g or --source-port options to perform source port manipulation
nmap -g <port> <target IP address>
```

#### 4. IP Address Decoy

* To create confussion about where the packet is coming from.
* The IP address decoy technique refers to generating or manually specifying IP addresses of the decoys to evade IDS/firewalls. 
* It appears to the target that the decoys as well as the host\(s\) are scanning the network. 
* This technique makes it difficult for the IDS/firewall to determine which IP address is actually scanning the network and which IP addresses are decoys.   
* The Nmap scanning tool comes with a built-in scan function called a decoy scan, which cloaks a scan with decoys. 
* This technique generates multiple IP addresses to perform a scan, thus making it difficult for the target security mechanisms such as IDS, firewalls, etc., to identify the original source from the registered logs. 
* The target IDS might report scanning from 5–0 IP addresses; however, it cannot differentiate between the actual scanning IP address and the innocuous decoy IPs.

Using this command, Nmap automatically generates a random number of decoys for the scan and randomly positions the real IP address between the decoy IPs:

```text
nmap -D RND:10 [target]
```

Using this command, you can manually specify the IP addresses of the decoys to scan the victim’s network. Here, you have to separate each decoy IP with a comma \(,\) and you can optionally use the ME command to position your real IP in the decoy list. If you place ME in the 4th position of the command, your real IP will be positioned at the 4th position accordingly. This is an optional command, and if you do not mention ME in your scan command, then Nmap will automatically place your real IP in any random position:

```text
nmap -D decoy1,decoy2,decoy3,...,ME,... [target]
```

* These decoys can be generated in both initial ping scans such as ICMP, SYN, ACK, etc., and during the actual port scanning phase.
* IP address decoy is a useful technique for hiding your IP address. 
* However, it will not be successful if the target employs active mechanisms such as router path tracing, response dropping, etc. 
* Moreover, using many decoys can slow down the scanning process and affect the accuracy of the scan.

#### 5. IP Address Spoofing

Most firewalls filter packets based on the source IP address. These firewalls examine the source IP address and determine whether the packet is coming from a legitimate source or an illegitimate source. The IDS filters packets from illegitimate sources. Attackers use IP spoofing technique to bypass such IDS/firewalls.

IP address spoofing is a hijacking technique in which an attacker obtains a computer’s IP address, alters the packet headers, and sends request packets to a target machine, pretending to be a legitimate host. The packets appear to be sent from a legitimate machine but are actually sent from the attacker’s machine, while his/her machine's IP address is concealed. When the victim replies to the address, it goes back to the spoofed address and not to the attacker’s real address. Attackers mostly use IP address spoofing to perform DoS attacks.

When the attacker sends a connection request to the target host, the target host replies to the spoofed IP address. When spoofing a nonexistent address, the target replies to a nonexistent system and then hangs until the session times out, thus consuming a significant amount of its own resources.

* IP spoofing refers to changing the source IP addresses so that the attack appears to be coming from someone else.
* When the victim replies to the address, it goes back to the spoofed address rather than the attacker’s real address.
* Attackers modify the address information in the IP packet header and the source address bits field in order to bypass the IDS or firewall.

IP spoofing using Hping3:

```text
Hping3 www.certifiedhacker.com -a 7.7.7.7
```

![](../../.gitbook/assets/image%20%2867%29.png)

Disadvantage:

* Note: You will not be able to complete the three-way handshake and open a successful TCP connection with spoofed IP addresses

**3 IP Spoofing Detection Techniques**

**\(1/3\) Direct TTL Probes**

In this technique, you initially send a packet \(ping request\) to the legitimate host and wait for a reply. Check whether the TTL value in the reply matches with that of the packet you are checking. Both will have the same TTL if they are using the same protocol. Although the initial TTL values vary according to the protocol used, a few initial TTL values are commonly used. For TCP/UDP, the values are 64 and 128; for ICMP, they are 128 and 255.

![](../../.gitbook/assets/image%20%2854%29.png)

If the reply is from a different protocol, then you should check the actual hop count to detect the spoofed packets. Deduct the TTL value in the reply from the initial TTL value to determine the hop count. The packet is a spoofed packet if the reply TTL does not match the TTL of the packet. It will be very easy to launch an attack if the attacker knows the hop count between the source and the host. In this case, the test result is a false negative.

> Note: Normal traffic from one host can contrast TTLs depending on traffic patterns.

**\(2/3\) IP Identification Number**

Users can identify spoofed packets by monitoring the IP identification \(IPID\) number in the IP packet headers. The IPID increases incrementally each time a system sends a packet. Every IP packet on the network has a "fragment identification" number, which is increased by one for every packet transmission. To identify whether a packet is spoofed, send a probe packet to the source IP address of the packet and observe the IPID number in the reply. The IPID value in the response packet must be close to but slightly greater than the IPID value of the probe packet. The source address of the IP packet is spoofed if the IPID of the response packet is not close to that of the probe packet.

![](../../.gitbook/assets/image%20%2853%29.png)

> Note: This method is effective even when both the attacker and the target are on the same subnet.

**\(3/3\) TCP Flow Control Method**

Attackers still send packets even after the window size has been exhausted.

The TCP can optimize the flow control on both the sender’s and the receiver’s end with its algorithm. The algorithm accomplishes flow control using the sliding window principle. The user can control the flow of IP packets by the window size field in the TCP header. This field represents the maximum amount of data that the recipient can receive and the maximum amount of data that the sender can transmit without acknowledgement. Thus, this field helps to control data flow. The sender should stop sending data whenever the window size is set to zero. In general flow control, the sender should stop sending data once the initial window size is exhausted. The attacker, who is unaware of the ACK packet containing window size information, might continue to send data to the victim. If the victim receives data packets beyond the window size, they are spoofed packets. For effective flow control and early detection of spoofing, the initial window size must be very small. Most spoofing attacks occur during the handshake, as it is challenging to build multiple spoofing replies with the correct sequence number. Therefore, apply the flow control spoofed packet detection method to the handshake. In a TCP handshake, the host sending the initial SYN packet waits for SYN-ACK before sending the ACK packet. To check whether you are getting the SYN request from a genuine client or a spoofed one, set SYN-ACK to zero. If the sender sends an ACK with any data, it means that the sender is a spoofed one. This is because when SYN-ACK is set to zero, the sender must respond to it only with the ACK packet, without additional data.

![](../../.gitbook/assets/image%20%2873%29.png)

Attackers sending spoofed TCP packets will not receive the target's SYN-ACK packets. Attackers cannot respond to changes in the congestion window size. When the received traffic continues after a window size is exhausted, the packets are most likely spoofed.

**IP Spoofing Countermeasures**

1. Avoid trust relationships: Do not rely on IP-based authentication. Attackers may spoof themselves as trusted hosts and send malicious packets to you. If you accept these packets under the assumption that they are “clean” because they are from your trusted host, the malicious code will infect your system. Therefore, it is advisable to test all packets, even when they come from one of your trusted hosts. You can avoid this problem by implementing password authentication along with trust-relationship-based authentication.
2. Use firewalls and filtering mechanisms: As stated above, you should filter all the incoming and outgoing packets to avoid attacks and sensitive information loss. A firewall can restrict malicious packets from entering your private network and prevent severe data loss. You can use access control lists \(ACLs\) to block unauthorized access. At the same time, there is a possibility of an insider attack. Inside attackers can send sensitive information about your business to your competitors, which could lead to monetary loss and other issues. Another risk of outgoing packets is that an attacker will succeed in installing a malicious sniffing program running in a hidden mode on your network. These programs gather and send all your network information to the attacker without any notification after filtering the outgoing packets. Therefore, you should assign the same importance to the scanning of outgoing packets as you would to that of incoming packets.
3. Use random initial sequence numbers: Most devices choose their ISN based on timed counters. This makes the ISNs predictable, as it is easy for an attacker to determine the concept of generating the ISN. The attacker can determine the ISN of the next TCP connection by analyzing the ISN of the current session or connection. If the attacker can predict the ISN, then he/she can establish a malicious connection to the server and sniff out your network traffic. To avoid this risk, use random initial sequence numbers.
4. Ingress filtering: Ingress filtering prevents spoofed traffic from entering the Internet. It is applied to routers because it enhances the functionality of the routers and blocks spoofed traffic. Configuring and using ACLs that drop packets with the source address outside the defined range is one method of implementing ingress filtering.
5. Egress filtering: Egress filtering refers to a practice that aims to prevent IP spoofing by blocking outgoing packets with a source address that is not inside.
6. Use encryption: If you want to attain maximum network security, then use strong encryption for all the traffic placed onto the transmission media without considering its type and location. This is the best way to prevent IP spoofing attacks. IPsec can be used to reduce the IP spoofing risk drastically, as it provides data authentication, integrity, and confidentiality. Furthermore, ACLs can be used for blocking private IP addresses at the downstream interfaces. Encryption sessions should be enabled on the router so that trusted hosts can communicate securely with local hosts. Attackers tend to focus on easy-to-compromise targets. If an attacker wants to break into the encrypted network, he or she has to decrypt a whole slew of encrypted packets, which is a difficult task. Therefore, the attacker is likely to move on and try to find another target that is easy to compromise or simply abort the attempt. Moreover, use the latest encryption algorithms that provide strong security.
7. SYN flooding countermeasures: Countermeasures against SYN flooding attacks can also help you to avoid IP spoofing attacks.

#### 6. Creating Custom Packets

The attacker creates and sends custom packets to scan the intended target beyond the IDS/firewalls.

**Creating Custom Packets by using Packet Crafting Tools**

Packet crafting tools craft and send packet streams \(custom packets\) using different protocols at different transfer rates:

* [Colasoft packet builder](https://www.colasoft.com)
* [NetScanTools Pro](https://www.netscantools.com)

**Creating Custom Packets by Appending Custom Binary Data**

Attackers send binary data \(0’s and 1’s\) as payloads in the packets sent to the target machine present behind the firewall. The option used by Nmap for appending custom binary data to the sent packets is --data . Any  is specified in the formats 0xAABBCCDDEEFF&lt;...&gt;, AABBCCDDEEFF&lt;...&gt;, or \xAA\xBB\xCC\xDD\xEE\xFF&lt;...&gt;. To perform a byte-order conversion, the specified information should be based on the receiver’s expectations. Attackers can use this technique to scan the target by manipulating the firewalls by appending custom binary or hex data to the sent packets.

```text
nmap <target IP Address> --data -0xdeadbeef
```

**Creating Custom Packets by Appending Custom String**

Attackers send regular strings as payloads in the packets sent to the target machine for scanning beyond the firewall. The option used by Nmap for appending a custom string to the sent packets is --data-string . The  can contain any string and a few characters depend on the system’s location; however, it is not guaranteed whether the same information is retrieved. The string is enclosed with double quotes \(“”\) and special characters from the shell are not used. Attackers can use this technique to scan the target by manipulating the firewalls by appending custom string data to the sent packets.

```text
nmap <target IP Address> --data-string "Ph3ar my l33t skills"
```

**Creating Custom Packets by Appending Random Data**

Attackers append a number of random data bytes to most packets sent without using any protocol-specific payloads. The option used by Nmap for appending random data to the sent packets is --data-length . For protocol-specific and no random payloads, --data-length 0 is used. The \(-O\) OS detection packets are not usually affected, as probe consistency is needed for it to be accurate. By default, a few UDP ports and IP protocols get a custom payload. Attackers can use this technique to scan the target by manipulating the firewalls by appending random data or numbers to the sent packets.

```text
nmap <target IP Address> --data-string 5
```

#### 7. Randomizing Host Order

Pattern recognition is widely used for detecting attacks. So administrator might find suspicious when they find in their sniffer that IPs are scanned sequentially.

The attacker scans the number of hosts in the target network in a random order to scan the intended target that is lying beyond the firewall. The option used by Nmap to scan with a random host order is --randomize-hosts.

```text
nmap --randomize-hosts <target IP address>
```

This technique instructs Nmap to shuffle each group of 16384 hosts before scanning with slow timing options, thus making the scan less notable to network monitoring systems and firewalls. If larger group sizes are randomized, the PING\_GROUP\_SZ should be increased in nmap.h and it should be compiled again. Another method can be followed by generating the target IP list with the list scan command -sL -n -oN  and then randomizing it with a Perl script and providing the whole list to Nmap using the -iL command.

#### 8. Sending Bad Checksums

* The attacker sends packets with bad or bogus TCP/UPD checksums to the intended target to avoid certain firewall rule sets. 
* TCP/UPD checksums are used to ensure data integrity. Sending packets with incorrect checksums can help attackers to acquire information from improperly configured systems by checking for any response. 
* If there is a response, then it is from the IDS or firewall, which did not verify the obtained checksum. If there is no response or the packets are dropped, then it can be inferred that the system is configured. 
* This technique instructs Nmap to send packets with invalid TCP, UDP, or SCTP checksums to the target host. The option used by Nmap is `--badsum`.

```text
nmap --badsum <target IP address>
```

#### 9. Proxy Servers

A proxy server is an application that can serve as an intermediary for connecting with other computers. They hide your identity.

A proxy server is used:

* As a firewall and to protect the local network from external attacks.
* As an IP address multiplexer that allows several computers to connect to the Internet when you have only one IP address \(NAT/PAT\).
* To anonymize web surfing \(to some extent\).
* To extract unwanted content, such as ads or “unsuitable” material \(using specialized proxy servers\).
* To provide some protection against hacking attacks.
* To save bandwidth.

**How does a proxy server work?**

Initially, when you use a proxy to request a particular web page on an actual server, the proxy server receives it. The proxy server then sends your request to the actual server on your behalf. It mediates between you and the actual server to transmit and respond to the request.

**Why Attackers Use Proxy Servers?**

Proxy sites help the attacker to browse the Internet anonymously and access blocked sites \(i.e., evade firewall restrictions\). Thus, the attacker can surf restricted sites anonymously without using the source IP address.

Attackers use proxy servers:

* To hide the actual source of a scan and evade certain IDS/firewall restrictions. 
* To hide the source IP address so that they can hack without any legal corollary. 
* To mask the actual source of the attack by employing a fake source address of the proxy. 
* To remotely access intranets and other website resources that are normally off limits. 
* To interrupt all the requests sent by a user and transmit them to a third destination; hence, victims will only be able to identify the proxy server address.
* To chain multiple proxy servers to avoid detection.

**Proxy Chaining**

Proxy chaining helps an attacker to increase his/her Internet anonymity. Internet anonymity depends on the number of proxies used for fetching the target application; the larger the number of proxy servers used, the greater is the attacker’s anonymity

The proxy chaining process is described below:

* The user requests a resource from the destination.
* A proxy client in the user’s system connects to a proxy server and passes the request to the proxy server.
* The proxy server strips the user’s identification information and passes the request to the next proxy server.
* This process is repeated by all the proxy servers in the chain. 
* Finally, the unencrypted request is passed to the web server.

**Proxy Tools**

Proxy tools are intended to allow users to surf the Internet anonymously by keeping their IP hidden through a chain of SOCKS or HTTP proxies. These tools can also act as HTTP, mail, FTP, SOCKS, news, telnet, and HTTPS proxy servers.

* [Proxy Switcher](http://www.proxyswitcher.com)
* [CyberGhost VPN](https://www.cyberghostvpn.com/en_US/)
* \[Burp Suite\]
* \[Tor\]
* \[CCProxy\]
* \[Hotspot Shield\]

**Proxy Tools for Mobile**

* [Shadowsocks](https://shadowsocks.org/en/index.html)
* [ProxyDroid](https://github.com/madeye/proxydroid)
* [ProxyManager](https://play.google.com/store/apps/details?id=com.evanhe.proxymanager&hl=en&gl=US)

#### 10. Anonymizers

* An anonymizer is an intermediate server placed between you as the end user and the website to access the website on your behalf and make your web surfing activities untraceable.
* Anonymizers allows you to bypass Internet censors.
* An anonymizer eliminates all the identifying information \(IP address\) from your system while you are surfing the Internet, thereby ensuring privacy. Most anonymizers can anonymize the web \(HTTP:\), file transfer protocol \(FTP:\), and gopher \(gopher:\) Internet services.

**Why Use an Anonymizer?**

The reasons for using anonymizers include:

* **Ensuring privacy**: Protect your identity by making your web navigation activities untraceable. Your privacy is maintained until and unless you disclose your personal information on the web, for example, by filling out forms.
* **Accessing government-restricted content**: Most governments prevent their citizens from accessing certain websites or content deemed inappropriate or sensitive. However, these sites can still be accessed using an anonymizer located outside the target country.
* **Protection against online attacks**: An anonymizer can protect you from all instances of online pharming attacks by routing all customer Internet traffic via its protected DNS server.
* **Bypassing IDS and firewall rules**: Firewalls are typically bypassed by employees or students accessing websites that they are not supposed to access. An anonymizer service gets around your organization’s firewall by setting up a connection between your computer and the anonymizer service. Thus, firewalls see only the connection from your computer to the anonymizer’s web address. The anonymizer will subsequently connect to any website \(e.g., Twitter\) with the help of an Internet connection and then direct the content back to you. To your organization, your system appears to be simply connected to the anonymizer’s web address but not to the actual site that you are browsing.

> Notes: In addition to protecting users' identities, anonymizers can also be used to attack a website without being traced.

**Types of Anonymizers**

An anonymizer is a service through which one can hide one’s identity when using certain Internet services. It encrypts the data from your computer to the Internet service provider. Anonymizers are of two basic types: networked anonymizers and single-point anonymizers.

**Networked Anonymizers**:

* First transfers your information through a network of Internet-connected computers before passing it on to the website.
* Advantage: Complication of the communications makes traffic analysis complex. 
* Disadvantage: Any multi-node network communication incurs some degree of risk of compromising confidentiality at each node.

**Single-Point Anonymizers**:

* Single-point anonymizers first transfer your information through a website before sending it to the target website and then pass back the information gathered from the target website to you via the website to protect your identity.
* Advantage: Arms-length communication hides the IP address and related identifying information. 
* Disadvantage: It offers less resistance to sophisticated traffic analysis.

**Censorship Circumvention Tools**

* [Alkasir](https://github.com/alkasir/alkasir)
* [Tails](https://tails.boum.org)

**Anonymizers**

An anonymizer helps you to mask your IP address so that you can visit websites without being tracked or identified while keeping your activity and identity protected. It uses various techniques such as SSH, VPN, and HTTP proxies, which allow you to access blocked or censored content on the Internet with omitted advertisements.

* [Whonix](https://www.whonix.org/)
* [Psiphon](https://psiphon.ca)

**Anonymizers for mobile**

* [Orbot](https://guardianproject.info)
* [Psiphon](https://psiphon.ca)
* OpenDoor: OpenDoor is an app designed for both iPhone and iPad; it allows attackers to browse websites smoothly and anonymously.

## 7. Draw Network Diagrams

* A network diagram helps in analyzing the complete network topology. This section highlights the

  importance of network diagrams, how to draw them, how an attacker uses them to launch an attack, and the tools used for drawing them.

* Network diagrams show logical or physical paths to a potential target

### Network Discovery and Mapping Tools

* [Network Topology Mapper](https://www.solarwinds.com)
* [OpManager](https://www.manageengine.com)
* [The Dude](https://mikrotik.com)
* [NetSurveyor](http://nutsaboutnets.com)
* [NetBrain](https://www.netbraintech.com)
* [Spiceworks Network Mapping Tool](https://www.spiceworks.co)

### Network Discovery Tools for Mobile

* [Scanny](http://happymagenta.com/scany/index.html)
* Network Analyzer \([https://play.google.com](https://play.google.com)\): Network Analyzer can diagnose various problems in the Wi-Fi network setup or Internet connectivity, and it can also detect various issues in remote servers based on its wide range of in-built tools. Attackers can use it to perform ping, traceroute, port scanning, Whois, and DNS lookup activities.
* PortDroid Network Analysis \([https://play.google.com](https://play.google.com)\): Attackers can use PortDroid Network Analysis to perform local network discovery. It is also effective in analyzing the network and performing port scanning as well as banner grabbing using certain protocols, including ssh, telnet, http, https, ftp, smb, etc.

## Module Summary

In this module, we have discussed the following:

* How attackers discover live hosts from a range of IP addresses by sending various ping scan requests to multiple hosts.
* How attackers perform different scanning techniques to determine open ports, services, service versions, etc. on the target system.
* How attackers perform banner grabbing or OS fingerprinting to determine the operating system running on a remote target system.
* Various scanning techniques that attackers can employ to bypass IDS/firewall rules and logging mechanisms, and disguise themselves as regular network traffic.
* Drawing diagrams of target networks and their significance in providing valuable information about a network and its architecture to an attacker.

In the next module, we will discuss in detail how attackers, as well as ethical hackers and pen-testers, perform enumeration to collect information about a target before an attack or audit.

