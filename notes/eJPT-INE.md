# Learning Path - Penetration Testing Student

## (1/3) Penetration Testing Prerequisites

### Introduction (7 items)

#### (1/7) The Information Security Field - Study Guide

The term 'hacker' was born in the 60s (MIT Community):

- Hacker: curious, highly intelligent, starving for knowledge.
- Lifestyle, telephone lines, people and software development.
- [Hacker Manifesto](http://phrack.org/issues/7/3.html)

Career opportunities:

- Need of protecting sensitive information.
- Wide range of cyber-threats.
- IT Security is a difficult game.
- Pentesters (or **Pen**entration **testers**), simulate hacks against a network, computer system, webapp or organization using the same techniques as malicious criminals.
- Demand is in growth.

Domain language:

- White hat hacker
- Black hat hacker
  -  Crackers
- User
- Malicious user
- Root/Administrator
- Privileges: identify actions a user is allowed to do
- Security through Obscurity: secrecy of design to provide security
- Attack
- Privilege Escalation
- DoS: Denial of Service
- Remote Code Execution: malicious user manages to execute some attacker-controlled code on a victim remote machine
- ShellCode: piece of custom code which provides the attacker a shell on the victim machine

#### (2/7) Cryptography & VPNs - Study Guide

> Goal #1: knowing how to protect traffic, understanding computer network communications & be able to choose the right protocol.
> Goal #2: know the difference between clear text and cryptographic protocols.

Clear-text:

- Easy to intercept, eavesdrop & mangle
- Use clear-text only on trusted networks

Cryptographic Protocols:

- Protocol encrypts information transmitted to protect the communication
- Prevents eavesdropping
- Need to transmit clear-text anyways? Wrap your communication into a **tunnel**
- Protocol for Tunneling = VPN

VPN:

- A VPN uses cryptography to extend a private network over a public one
- Protected connection a to a a private network
- A VPN connection is needed for using the course Labs

#### (3/7) Wireshark Introduction - Study Guide

Network sniffer tool. Download Wireshark and OpenVPN (both shipped with Kali Linux).
#### <span style="color: red">VIDEO - (4/7) HTTP(s) Traffic Sniffing</span>

There are **2** websites using **HTTP** and **HTTPS** respectively.

#### <span style="color: red">LAB - (5/7) Connecting to your first lab</span>

#### (6/7) HTTP(S) Traffic Sniffing
#### (7/7) Binary Arithmetic Basics - Study Guide

> Goals: Understand Network addressing / Computer logic operation

- `1 + 1 = 10`
- `111 + 1 = 1000`
- `1101b` = `13d`

##### Converting from and to Binary

divide by 2 and keep a not of the remainder iterating the same operation until the dividend is zero.

`13d` is `1011b`:

1. 13 / 2 = 6  --> remainder: 1
2. 6 / 2 = 3 --> remainder: 0
3. 2 / 2 = 1 --> remainder: 1
4. 1 / 2 = 0 --> remainder: 1

`Logical NOT`:
- `1101` --> `0010`

`Logical AND`: if (both bits in the comparing position are ones) -> 1; else 0
- `1001 AND 1100` = `1000`

`Logical OR`: if (at least one of the bits is one) -> 1; else 0
- `1001 OR 1100` = `1101`

`Logical XOR`: if (**just one** of the bits is one) -> 1; else 0
 - `1001 XOR 1100` = `0101`

##### Hexadecimal arithmetic

> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F.

`0x3a1` = `3a1h` = `929d`

|            |            |            |
|:-----------|:-----------|:-----------|
| 3 = 3      |  3 * 16^2  | 768        |
| a = 10     |  10 * 16^1 | 160        |
| 1 = 1      |  1 * 16^0  | 1          |

##### Converting decimal to hexadecimal

`1019d` = `0x3FB`

|            |            |                     |
|:-----------|:-----------|:--------------------|
| 1019 / 16  | 63.6875    | 0.6875 * 16 = 11 (B)|
| 63 / 16    | 3.9375     | 0.9375 * 16 = 15 (F)|
| 3 / 16     | 0.1875     | 0.1875 * 16 = 3     |
| 0 / 16     | --         |                     |

### Networking (12 items)

#### (1/12) Protocols - Study Guide

- Packet: stream of bits running as electric signals on physical media used for data transmission (wire/LAN, WiFi)
- Every packet has a:
  - Header: ensures receiver can interpret payload and handle the communication
  - Payload: actual information
- TCP/IP protocol header is 160bits (20Bytes)
  - First 4 bits: IP version
  - Source Address: 32 bits (starting at position 96)
  - Destination Address: just right after

Protocol Layers:
- Application
- Transport
- Network
- Physical

ISO/OSI (1984):
- Application
- Presentation
- Session
- Transport
- Network
- Link
- Physical

During **encapsulation**, every protocol adds its own header to the packet, treating it as a payload.

The receiving host does the same operation in reverse order. Using this method, the application does not need to worry about how the transport, network and link layers work. It just hands in the packet to the transport layer.

#### (2/12) Internet Protocols (IP) - Study Guide

- Internet Protocol is the protocol that runs on the Internet layer of the Internet Protocol Suite, also known as TCP/IP.
- IP delivers datagrams (IP packets) to rest of hosts, using IP addresses to identify them.
- IPv4 addresses = 4 bytes

##### Reserved IPv4 addresses

More details [here](https://datatracker.ietf.org/doc/html/rfc5735):

|                                |                   |
|:-------------------------------|:------------------|
| 0.0.0.0 - 0.255.255.255        | This network      |
| 127.0.0.0 - 127.255.255.255    | Local host        |
| 192.168.0.0 - 192.168.255.255  | Private Networks  |

##### IP/Mask

To fully identify a host, you also need to know its network

To find the network part you have to perform a bitwise AND operation between the netmask and the IP address.

> IP address + Subnet Mask

| IP Address                          | Mask                                | Network                             | CIDR Notation
|:------------------------------------|:------------------------------------|:------------------------------------|:------------------------------------|
| 192.168.33.12                       | 255.255.224.0                       | 192.168.32.0                        | 192.168.32.0/19                     |
| 11000000.10101000.00100001.00001100 | 11111111.11111111.11100000.00000000 | 11000000.10101000.00100000.00000000 |                                     |

Invert the netmask by performing a **bitwise NOT**:

11111111.11111111.11100000.00000000 -> 00000000.00000000.00011111.11111111

Perform the final **bitwise AND**:

|       |                                     |
|:------|:------------------------------------|
| IP    | 11000000.10101000.00100001.00001100 |
| !Mask | 00000000.00000000.00011111.11111111 |
| Host  | 00000000.00000000.00000001.00001100 |

0.0.1.12 => 13 bits to represent hosts => 2^13 = 8192 different addresses

##### Network & Broadcast Addresses

8192 - 2 addresses

- **Network**: one with the host part made by all zeros
- **Broadcast**: another with the host part made by all ones

More info [here](https://datatracker.ietf.org/doc/html/rfc1878).

- [CDIR Calculator](https://www.subnet-calculator.com/cidr.php)
##### IPv6

- 16bit hexadecimal numbers separated by a colon (:)
- Regular Form: 2001:0db8:0020:130F:0000:0000:097C:130B
- Compressed Form: FF01:0:0:0:0:0:0:43 => FF01::43
- IPv4-compatible: 0:0:0:0:0:0:13.1.68.3 => ::13.1.68.3

Reserved addresses (more info [here](https://datatracker.ietf.org/doc/html/rfc3513)):
- Loopback: `::1/128`
- IPv4 mapped addresses: `::FFFF:0:0/96`
-
##### IPv6 Structure

IPv6 addresses can be split in half (64bits/each part)
- Network part
  - Last 16 bits can be used only for specifying a subnet
- Device part (or Interface ID)

##### IPv6 Scope

- *Global Unicast Address*: scope internet - routed on internet
- *Unique Local*: scope internal network or VPN - internally routable but not routed on Internet
- *Link Local*: scope network link - not routed internally nor externally

##### IPv6 Subnetting

- First 48bits: Internet Global Addressing
- 16bits: Subnets
- Last 64: Device/Interface ID

This is:

- Prefix: First 64 bits
- Host: Last 64 bits

#### (3/12) Routing - Study Guide

- **Routers** are devices connected to different networks at the same time, forwarding IP datagrams from one network to another
- Routing protocols are used to determine the best path to reach a network. They behave like a postman who tries to use the shortest path possible to deliver a letter
- A router inspects the destination address of every incoming packet and then forwards it through one of its interfaces

Routing Table:
- To choose the right forwarding interface, a router performs a lookup in the routing table, where it finds an IP-to-interface binding
- The table can also contain an entry with the default address (0.0.0.0). This entry is used when the router receives a packet whose destination is an *unknown network*

Metrics:
- Routing protocols also assign a metric to each link
- This ensures that, if two paths have the same number of hops, the fastest route is selected
- The metric is selected according to the channel's estimated bandwidth and congestion

Checking the routing table:
- `ip route` (Linux)
- `route print` (Windows)
- `netstat -r` (Mac OS X)

#### (4/12) Link Layer Devices & Protocols - Study Guide

> Goals: Mac spoofing, test switches security, sniffing techniques, MITM attacks.

##### Link Layer
- Packet forwarding happens here
- Link layer protocols and devices only deal with the next hop

Link Layer devices:
- Hubs/Switches are network devices that forward frames on a local network
- They work with link layer network addresses: **MAC addresses**

##### MAC addresses
- Uniquely identify a network card on the Layer 2
- It's also known as physical address
- 48 bits = 6 bytes, expressed in hexadecimal
- Every host has a MAC and an IP address

Discovery of MAC addresses:
- `ipconfig /all` (Windows)
- `ipconfig` (*nix/Mac OS X)
- `ip addr` (Linux)

Communication between Workstation A and Workstation B via a router:
- Workstation A will create a packet with:
  - Destination IP addr of WS#B in the datagram header
  - Destination MAC addr of the router in the link layer header of the frame
  - Source IP add of WS#A
  - Source MAC addr of WS#A

- Router takes the packet and forward it to WS#B, rewriting the packet's MAC addresses
  - Destination MAC addr will be WS#B
  - Source MAC addr will be router's
  - The router will not change the source and destination IP addresses

- When a device sends a packet:
  - Destination MAC address is the MAC address of the next hop
    - This ensures the network knows where to forward the packet
  - Destination IP addr is the Destination Host addr
    - This is global info and remains the same along the packet trip

- Broadcast MAC address
  - FF:FF:FF:FF:FF:FF
  - A frame with this address is delivered to all the hosts in the local network

##### Switches
- Routers work with IP addresses
  - But Switches work with MAC addresses
  - They have multiple interfaces
  - CAM Table / Forwarding table: binds one or more MAC addresses to an interface
- Smallest home switches are usually integrated into the DSL router
- Corporate switches may have up to 64 ports
- They all differ in the delivered speed (from 10Mbps to 10Gbps, being 1Gbps the standard)

Forwarding Table:
- Binds MAC addresses to interfaces
- Stored in the device's RAM
- Contains: MAC address, Interface & TTL

Example:
| MAC            | Interface      | TTL         |
|:---------------|:---------------|:------------|
| MAC#1          | 1              | 30          |
| MAC#2          | 2              | 5           |
| MAC#3          | 2              | 5           |
| MAC#4          | 3              | 7           |

- A single host is attached to Interface 1 and 3 respectively
- Two hosts are attached to Interface 2, probably via another switch
- There might be multiple hosts on the same interface and interfaces without any host attached
- Interface 4 has no hosts attached
- TTL determines how long an entry will stay in the table, CAM table has a finite size
- As soon as an entry expires it is removed from the table
- CAM Table Population
  - Switches learn new MAC addresses dynamically, inspecting the header of every packet they receive, thus identifying new hosts
  - While routers use complex routing protocols to update their routing rules, switches just use the source MAC addr of the packets they process to decide which interface to use when forwarding a packet
  - The source MAC addr is compared to the CAM table
    - If the MAC addr **is not** in the table, the switch will add a new *MAC-interface* binding to the table
    - If the *MAC-Interface* is already in the table, its TTL gets updated
    - If the Mac is in the table but bound to another interface, the switch will update the table

##### Forwarding

To forward a packet...
- The switch reads the destination MAC addr of the frame
- Performs a look-up in the CAM table
- It forwards the packet to the corresponding interface
- If there's no entry for that MAC addr, the switch will forward the frame to all its interfaces

##### ARP
- Host#A sends a packet Host#B: Host#A needs to know IP/MAC addresses of Host#B
- If Host#A knows Host#B's IP but not MAC:
  - Host#A can build the correct IP-MAC address binding
    - Host#A builds an ARP request containing the Host#B's IP and FF:FF:FF:FF:FF:FF as destination MAC addr
    - Every host will receive the request
    - Only Host#B will ARP reply to it, telling A its MAC addr
    - Host#A will save the IP-MAC binding in its ARP cache
  - A host discards an entry at the power off or when the entry's TTL expires
- `arp -a` (Windows)
- `arp` (*nix OS)
- `ip neighbour` (Linux)

##### Hubs
- Predecessor of switches, same purpose, different functionality
- Repeaters and do not check any header
- They simply forward packets by repeating same electric signals on every port
- Every host receives the same packets

#### (5/12) TCP & UDP - Study Guide

> Goal#1: Transport Layer, how the application layer uses its services to identify server and client processes
> Goal#2: TCP session attacks, Advanced DoS attacks, Network scanning

##### TCP: Transmission Control Protocol
- Guarantees packet delivery
- Connection oriented
- Vast majority of applications use it
- Lower throughput than UDP

##### UDP: User Datagram Protocol
- Does not guarantee packet delivery
- It's connectionless
- Faster that TCP, better throughput
- Multimedia applications

##### Ports

> `<IP>`:`<Port>`: identify a single network process on a machine

- Well-known: 0-1023

|            |                  |                 |       |
|:-----------|:-----------------|:----------------|:------|
| SMTP       | 25               | SFTP            | 115   |
| SSH        | 22               | Telnet          | 23    |
| POP3       | 110              | FTP             | 21    |
| IMAP       | 143              | RDP             | 3389  |
| HTTP       | 80               | MySQL           | 3306  |
| HTTPS      | 443              | MS SQL Server   | 1433  |
| NetBIOS    | 137, 138, 139    |                 |       |

Server and Clients know what port to use as it's expressed in the source/destination ports in the TCP/UDP header.

Check *listening ports* and *current TCP connections* as information about the processes listening on the machine and processes connecting to remote servers:
- `netstat -ano` (Windows)
- `netstat -tunp` (Linux)
- `netstat -p tcp -p udp` together with `lsof -n -i4TCP -i4UDP`
- TCPView from Sysinternals

##### TCP 3-way handshake

TCP is connection oriented. The header fields involved in the handshake are:
- Sequence number
- Acknowledgement numbers
- SYN & ACK flags

1. Host -> SYN -> Server
   -  SYN flag enabled
   -  Random sequence number
2. Host <- SYN-ACK <- Server
   - SYN & ACK flags enabled
   - Random sequence number
3. Host -> ACK -> Server
   -  Client completes the synchronization by sending an ACK packet

#### (6/12) Firewall & Defense - Study Guide

> Goals: evading FW advanced stealth scanning, filtering evasion.

FWs:
- Filter packets coming in and out of a network
- Access Control to network resources and services
- Can work on different layers of the OSI model

##### Packet Filtering FW

- Usual on home DSL routers
- Headers are inspected, but they don't give any information on the actual packet content
- Admin can crate rules according to certain characteristics
  - Source IP / Destination IP
  - Source Port / Destination Port
  - Protocol
- Packet inspection actions
  - Allow
  - Drop
  - Deny: same as drop but notifying the source host
- Packet filtering isn't enough to stop layer 7 attacks (application layer, as XSS, BoF, SQL injection or much more)

##### Application Layer Firewalls

- Content of packets is inspected, not just headers
- They filter unwanted traffic inspecting content

##### IDS / Intrusion Detection Systems

- They inspect the application payload trying to detect any potential attack
- They detect ongoing intrusions, attack vectors, ping sweeps, port scans, SQL injections, BoFs, etc.
- Can also identify traffic generated by a virus or worm by means of **signatures**
- IDS cannot detect something if it doesn't already know before hand
- False positive: legit traffic is flagged as malicious
- Detection is performed by a multitude of sensors
- IDS Manager: sw in charge of maintaining policies and providing a management console to the sysadmin
- **not a** FW substitute

2 categories:
- NIDS: network
  - Inspects network traffic with sensors
  - Usually placed on a router or in a network with high intrusion risk (as DMZ)
- HIDS: host
  - Monitors app logs, file-system changes or OS changes

##### IPS

- IDS can detect, activity is logged but the activity isn't blocked
- IPS drops malicious requests when a threat has a risk classification above a pre-define threshold

##### Spot on Obstacle

When an environmental constraint (FW/IDS/other device) is in place:
- TCP SYN are sent, but there's no TCP SYN/ACK reply
- TCP SYN are sent, but a TCP RST/ACK is received

##### NAT (Network Address Translation) and IP Masquerading

These are both two techniques to provide access to a network form another network.

The NAT device rewrites source IP addresses of every packet, masquerading the original client's IP address.

#### <span style="color:red">LAB - (7/12) Find the Secret Server</span>

#### (8/12) DNS - Study Guide

> **Goal#1**: SSL/TLS certifications validation relies on DNS.

> **Goal#2**: Mounting Spoofing attacks & Performing information gathering.

- DNS is an application layer protocol
- Structure/Hierarchy of a DNS Name (www.sub.domain.com)
  - Top level domain (TLD) (.com)
  - Domain Part (domain)
  - Subdomain part (sub)
  - Host part (www)
- Resolvers are DNS servers provided by your ISP or publicly available
  - They convert a DNS name into an IP address
- DNS Resolution Algorithm
  - Firstly, the resolver contacts one of the root name servers, these serves contain information about the top-level domains
  - Then, it asks the TLD name server what's the name server that can give information (authoritative name server) about the domain the resolver is looking for
  - If there are one or more subdomains, step 2 is performed again on the authoritative DNS server for every subdomain
  - Finally, the resolver asks for the name resolution of the host part
- Resolvers and Root servers
  - IP addresses of the root servers are hardcoded in the configuration of the resolver
  - Sysadmins keep the list updated, otherwise, the resolver would not be able to contact a root server
- Reverse DNS Resolution
  - DNS can perform the inverse operation: convert an IP into a DNS name
  - the admin of a domain must enable this feature for a domain to make it work
  - `ping` utility performs a reverse DNS query after receiving every response from the target

#### (9/12) Wireshark - Study Guide

- Can capture all the traffic seen by the network card of the computer running it
- NIC (Network Interface Cards) need to work in promiscuous or monitor mode
  - Instead of discarding any packet addressed to another NIC, in promiscuous mode a network card will accept and process **any** packet
  - Just like it would happen in a hub network
  - In switched networks, you have to perform an attack such as ARP poisoning or MAC flooding in order to do that
  - WiFi medium is broadcast by nature


- https://wiki.wireshark.org/SampleCaptures
- https://www.wireshark.org/docs/wsug_html_chunked/

#### <span style="color: red">VIDEO - (10/12) Using Wireshark</span>

#### <span style="color: red">VIDEO - (11/12) Full Stack Analysis with Wireshark</span>
#### <span style="color: red">LAB - (12/12) Data Exfiltration</span>

### Web Applications (11 items)

#### (1/11) Web Application Introduction - Study Guide

The web app world is extremely heterogeneous. Every web application is different from others because developers have many ways to accomplish the same task.

Having flexibility in web app development also means having flexibility in creating insecure code.

Fundamental aspects:
- HTTP protocol basics
- Cookies
- Sessions
- Same Origin Policy

#### (2/11) HTTP Protocol Basics - Study Guide

HTTP works on top of TCP protocol, so when the connection is established, the client sends a request and waits for the answer. The server processes the request and sends back its answer, along with status code and data:
- Client -> HTTP req -> Server
- Client <- HTTP res <- Server

HTTP Protocol Basics

- Client -> SYN -> Server
- Client <- SYN/ACK <- Server
- Client -> ACK + GET /html -> Server
- Client <- HTML resp + Close connetion <- Server

The format of an HTTP message is:

```
Headers\r\n
\r\n
Message Body\r\n
```

where:

```
\r # carriage return
\n newline
```


Verbs: PUT, TRACE, HEAD, POST.

Some status codes:

| Status code               | Meaning                                                       |
|:--------------------------|:--------------------------------------------------------------|
| 200 OK                    | the resource is found                                         |
| 301 Moved Permanently     | the requested resource has been assigned a new permanent URI  |
| 302 Found                 | the resource is temporarily under another URI                 |
| 403 Forbidden             | the client doesn't have enough privileges, server refuses req.|
| 404 Not Found             | the server cannot find the resource matching the request      |
| 500 Internal Server Error | the server does not support the functionality required        |
##### HTTP Request

```
GET / HTTP/1.1                                    # VERB path protocol version
Host: www.elarnsecurity.com                       # Specifies the internet hostname and port number, obtained from the URI of the resource
User-Agent: Mozilla/5.0 (X11; Linux x86_64 ...)   # Tells the server what client software is issuing the request
Accept: text/html                                 # Specifies which document type is expected in the response
Accept-Language: en-US,en;q=0.5                   # Browser can as for a specific human language in the response
Accept-Encoding: gzip, deflate                    # Restricts the content encoding
Connection: keep-alive                            # Future communications with the server will reuse the current connection
\r\n\r\n
< PAGE CONTENT > ...
```

##### HTTP Response

```
HTTP/1.1 200 OK                                   # Status-Line: protocol version + status code + textual meaning
Date: Wed, 19 Nov 2020 10:10:10 GNT               # Time at which the message was originated
Cache-Control: private, max-age=0                 # Using cached content saves bandwidth
Content-Type: text/html; charset=UTF=8            # Lets the client know how to interpret the body of the message
Content-Encoding: gzip                            # The message body is compressed with gzip
Server: Apache/2.2.15 (CentOS)                    # (optional) header of the server that generated the content
Content-Length: 99043                             # length in bytes of the message body


< PAGE CONTENT > ...
```

##### HTTPS: How to protect HTTP using an encryption layer

- HTTPS: HTTP over SSL/TLS is a method to run HTTP which is a clear-text protocol over SSL/TLS, a cryptographic protocol
- Provides: Confidentiality, Integrity Protection and Authentication to the HTTP protocol
- An attacker cannot sniff the application layer communication
- An attacker cannot alter the application layer data
- The client can tell the real identity of the server and, sometimes, vice-versa
- Traffic can be sniffed, but any adjacent user will not know req/resp headers, req/resp body, req target domain
- When inspecting HTTPS, one cannot know what domain is contacted and what data is exchanged
- HTTPS does not protect against web application flaws
- All the attacks against an application happen regardless of SSL/TLS
  - Such as XSS and SQL injection will still work

#### <span style="color:red"> VIDEO (3/11) HTTP(s) Protocol Basics</span>

#### (4/11) HTTP Cookies (1994 - Netscape) - Study Guide
- HTTP is a stateless protocol
- HTTP cannot keep the state of a visit across different HTTP requests
- HTTP requests are unrelated to the preceding and following ones
- Often exploits rely on stealing cookies
- Cookies / Cookie jar, just textual information installed by a website into a web browser


A server can set a cookie via `Set-Cookie` HTTP header field in a response message.

```
HTTP/1.1 200 OK
Date: Wed, 19 Nov 2020 10:10:10 GNT
Cache-Control: private, max-age=0
Content-Type: text/html; charset=UTF=8
Content-Encoding: gzip
Server: Apache/2.2.15 (CentOS)
Set-Cookie: ID=Value; expires=Thu, 21-May-2015 15:25:20 GMT; path=/; domain=.example.site; Http
Content-Length: 99043


< PAGE CONTENT > ...
```

A cookie contains the following attributes:
- The actual content
- An expiration date
- A path
- The domain
- Optional flags
  - Http only flag
  - Secure flag

##### Cookie format
|||
|:--------------------------|:-----------------------------------------|
| Cookie Content            | ID=Value;                                |
| Expiration Date           | expires=Thu, 21-May-2015 15:25:20 GMT;   |
| Path                      | path=/;                                  |
| Domain                    | domain=.example.site                     |
| Flag-setting Attribute    | HttpOnly                                 |

- Browsers use domain, path, expires and flags attributes to choose whether or not to send a cookie in request.
- Cookies are sent only to the valid domain/path when they are not expired and according totheir flags.
- The domain field and the path field set the scope of the cookie.
- The browser sends the cookie only if the request is for the right domain.
- When a web server installs a cookie, it sets the domain field.
- Then the browser will use the cookie for every request sent to that domain and *all its subdomains*.
- If the server does not specify the domain attribute, the browser will automatically set the domain as the server domain and set the cookie 'host-only' flag,meaning that this cookie will be sent only to that precise hostname.
- Respectively, when a cookie has the path attribute set, the browser will send the cookie to the right domain and to the resolurces in that path *and not any other*
- A browser will not send an expired cookie tothe server, session cookies will expire with the HTTP session.
- `http-only` flag is a mechanism that prevents JavaScript or any other non-HTML technology from reading the cookie (preventing a XSS robbery)
- `Secure` flag creates secure cookies that will only be sent over an HTTPS connection

#### (5/11) Sessions - Study Guide

- Sometimes the web developer prefers to store some information on the server side
- This avoids the back and forth data transmission and hides the application logic
- Sessions are a mechanism that lets the website store variables specific for a given visit on the server side
- Each session is identified by a session id
- The client presents this ID for each subsequent request
- With that ID, the server is able to retrieve the state of the client

##### Session cookies

Session cookies allow to install a session ID on a web browser

```
SESSION=0mwerj234w
PHPSESSID=1992maiwr2H     # PHP
JSESSIONID=W8234mSfsw3    # JSP
```

- The browser then uses the cookie in subsequent requests.
- A session could contain multiple variables, so sending a small cookie keeps the bandwidth usage low.
- The browser will send back the cookie according to the cookie protocol,thus sending the session ID.
- Session IDs can also be transmitted via GET requests.

#### <span style="color: red">VIDEO - (6/11) HTTP(s) Cookies and Sessions</span>

#### (7/11) Same Origin Policy - Study Guide

- SOP / Same Origin Policy is a critical point of web application security.
- Prevents JavaScript code from getting/setting properties on a resource coming from a different origin.
- To determine if JS can access a resource, hostname, port and protocol *must match*.
- SOP only applies to the actual code of a script.
- It is still possible to include external resources by using HTML, like IMG, script, iFrame...
- If a script on Domain A was able to read content on Domain B, it would be possible to steal clients' information and mount a number of dangerous attacks.

#### (8/11) Burp Suite - Study Guide

- Any web application contains many objects like scripts, images, stylesheets, client and server-side intelligence.
- Having tools that help inthe study and analysis of web application behavior is critical.
- An *intercepting proxy* is a tool that lets you analyze and modify any request and any response exchanged between an HTTP client and a server.
- Intercepting proxy != web proxy (as Squid)

BurpSuite will let you:
- Intercept request/responses between your browser and web server.
- Build requests manually.
- Crawl a website by automatically visiting every page in a website.
- Fuzz webapps by sending them patterns of a valid and invalid inputs to test their behavior.
- You can modify the header and the body of a message by hand or automatically.

> Learn how to configure your browser's proxy to work with Burp Suite

- Burp Repeater lets you manually build raw HTTP requests.
- Same can be achieved with `nc` or `telnet`.

#### <span style="color: red">VIDEO - (9/11) Burpsuite</span>
#### <span style="color: red">LAB - (10/11) Burp Suite Basics</span>
#### <span style="color: red">LAB - (11/11) Burp Suite</span>

### Penetration Testing (2 items)

#### (1/2) Penetration Testing Introduction - Study Guide

- A penetration tester performs a deep investigation of a remote system's security flaws.
- Penetration testers must test for any and all vulnerabilities, not just the ones that may grant them root access.
- Penetration testing is not about getting `root`!
- Penetration testers cannot destroy their client's infrastructure, professional pentesting requires a thorough understanding of attack vectors and their potential

#### (2/2) Lifecycle of a Penetration Tester - Study Guide

- Pentester activity must guarantee that the least impact possible on the production systems and services.
- Avoid overloading client's systems and networks.
- Communicate to client what steps to take, just in case anything goes wrong during the pentest.
- Pentesting is a process that ensures that every potential vulnerability or security weakness gets tested with the lowest possible overhead.

##### Engagement

Details about the pentest are established during the Engagement phase.

Quotation:
- Fee establishment for the job to be accomplished.
- Fee will vary according to:
  - Type of engagement: black box, gray box, etc.
  - How time-consuming the engagement is.
  - The complexity of the applications and services in scope.
  - The number of targets (IP addresses, domains, etc.)
- Evaluation and quoting these aspects requires experience.
- If you are not able to quantify the amount of work required by an engagement, you can provide an hourly fee.

Proposal Submittal:
- The best way to win a job is by providing a sound and targeted proposal.
- You should write the proposal keeping in mind the client's needs and infrastructure.
- Must include:
  - Your understanding of the customer's requirements.
  - Approach & Methodology
    - Automated scanning tools
    - Manual testing
    - Onsite testing
    - Any other
  - Value the pentest will bring to business
  - Risks & Benefits
    - Business continuity
    - Improved confidentiality
    - Avoidance of money and reputation loss
  - Estimate of the time / price
  - Type:
    - Penetration test
    - Vulnerability assessment
    - Remote / Onsite
  - Scope
    - IP addresses
    - Network blocks
    - Domain names
    - Etc.

Scope:

- Make sure that the target of your engagement is the property of your client.
- Shared hosting: You must not conduct an assessment on targets unless you are given written permission from the hosting provider.
- Check country laws

Incident Handling:

- Unplanned and unwanted situation that affects the client's environment and disrupts its services.
- Even when sticking to best practices,there's a possibility to damage the tested assets.
- Aim not to damage the target.
- In case of planning some insensitive or risk test, communicate with the customer.
- Have a 'Incident Handling Procedure':
  - Set of instructions that need to be executed by both you and your customer on how to proceed when a incident occurs.
  - Have an emergency contact.
  - Add an statement to the rules of engagement.

Legal work:

- Sometimes you will need to involve a lawyer as information security laws vary a lot from country to country
- Sometimes a professional insurance is required
- NDA can be signed. Keep data private and encrypted on your PC.
- Outline what you can and you cannot do.
- Rules of engagement is another document that will define the scope of engagement and will put on paper what you are entitled to do and when, this includes the time window for your tests and your contacts in the client's organizations

##### Information Gathering

- Fundamental stage for a successful penetration test.
- Starts once the legal paperwork is complete, and not before.
- You investigate and harvest info about the client's company

Extremely useful information if Social Engineering is allowed by the rules of the engagement:
  - Emails and addresses
    - Board of directors
    - Investors
    - Managers and employees
  - Branch location and addresses

- Identify risks in the client's critical infrastructure.
- Having an understanding of the business is a key aspect in understanding what is important for your client.
- Understanding the business allows us to rate the risks associated with a successful attack.

Infrastructure Information Gathering:

- After understanding the business
- Transform the IP addresses or the domains in scope into actionable information about servers, OSs, etc.
- If the scope is defined as a list of IP addresses, you can move on to the next step.
- If the scope is the whole company or some of their domains, you will have to harvest the relevant IP blocks by using `WHOIS` and other *DNS information*.
- Give meaning to every IP address in scope, determining the following in order to focus your efforts/attacks and select the riht tools for the exploitation phase:
  - if there's a live host or server using it
  - if there are one or more websites using that IP address
  - What OS is running on the host or the server

Web Applications:

- Harvest Domains
- Harvest subdomains
- Harvest Pages (website crawling)
- Harvest Technologies in use, like PHP, Java, .NET
- Harvest Frameworks and CMS in use
- Treat webapps as completely separate entities

##### Footprinting and Scanning

Here you deepen your knowledge of the in-scope servers and services.

Fingerprinting the OS:

- Gives you info about the OS
- Helps to narrow down the number of potential vulnerabilities
- Some tools use exploits to some singularities you can find the network stack implementation

Port Scanning:

- Once you know the live hosts, you can determine which ports are open on a remote system
- Any mistake made here will impact next steps
- `nmap` uses different scanning techniques to reveal open, closed and filtered ports


Detecting Services:

- Act of knowing what service which service is listening on that port.
- Knowing the port number isn't enough, there's the need to discover the service that is running behind.
- `nmap` can be used to fingerprint ports.

By knowing the services running, we can know:

- OS
- Purpose of a particular IP address (server/client)
- Relevance of the host in the infrastructure

##### Vulnerability Assessment

- Aims to build a list of the present vulnerabilities on the target systems.
- The pentester will carry out a vulnerability assessment on each target discovered in the previous steps
- The bigger the list, the more chances we'll have when exploiting the systems in scope.

Vulnerability assessments can be carried out:
- Manually
- Using automated tools, as scanners that will send probes to the target systems to detect whether a host has some well-known vulnerabilities
  - Extremely important to properly configure them, you might crash targets if not
  - Their output is a report that the pentester can use in the exploitation phase

##### Exploitation

- Phase where we verify the vulnerabilities really exist.
- During this phase, a pentester checks and validates a vulnerability and also widens and increases the privileges on the target systems and networks.
- A penetration test is a cyclic process:
- The process finishes when there are no more systems and services in-scope to exploit.

> Information Gathering -> Scanning -> Vulnerability Assessment -> Exploiting

##### Reporting

- This step is as important as the rest of the phases, as it delivers the results to executives, IT staff and development team.
- This report must address:
  - Techniques used
  - Vulnerabilities found
  - Exploits used
  - Impact and risk analysis for each vulnerability
  - Remediation tips (of real value for the client, as they can be used to resolve their security issues)

Consultancy:

- Pentester are often asked to provide some hours of consultancy after delivering the report.
- The initial engagement is closed and the pentester must keep the report encrypted in a safe place, or even destroy it.

## (2/3) Penetration Testing: Preliminary Skills & Programming

### Introduction to Programming (4 items)

#### (1/4) What is Programming - Study Guide

Set of instructions that a computer may follow. It can be used to automate tasks, leaving specific things to be done by a machine instead of a human.

Syntax and usage requirements are specific per language, but purpose keeps on being the same.

#### (2/4) Low and High-Level Languages - Study Guide

Level can tell how close these languages are to the hardware.

Low level:

- More complicated, more prone to create vulnerabilities
- Can do anything with them, as they are so closed to the machine
- Deep understanding is required
- Assembly

High level:

- Ease of development
- Less flexible
- Writing custom functionality from scratch can be difficult
- Java, Python
- They can't run on a bare OS, will need some kind of software already running

#### (3/4) Programming and Scripting - Study Guide

Programming and Scripting Languages are both high-level languages.

Programming Languages:

- Programming languages require a compiler.
- A compiler will convert your plain-text program file into something readable by the language environment.

Scripting Languages:

- Interpreted
- Software environment install on your computer can read a plain-text program file

#### (4/4) Basic Concepts - Study Guide

- Each programming language has its own syntax, which may require some instructions to use certain characters at the end of each statement while in another language this may not be needed.
- Variables might have different types depending on the programming language.
- Functions are normally allowed to be created. These are pieces of code responsible for some repeatable tasks. Might use arguments and return a value.
- Conditional statements are part of a programming language syntax.
- Loops are a set of instructions that need to be executed numerous times.

### C++ (10 items)

#### (1/10) C++ IDE - Study Guide

> Skipped

#### (2/10) Structure of C++ Programs - Study Guide

`Hello World` example where we make use of:
- Comments
- Directives
- Namespaces
- Terminators (;)
- `main` function + body

```
// This is my first program in C++
#include <iostream>
using namespace std;

int main() {
  cout << "Hello World";

  // system("PAUSE");
  // cin.ignore();

  return 0;  // program has completed its execution without any errors
}
```

#### (3/10) Variables and Types - Study Guide

Variables can be 'global' or 'local'.

```
int a = 0;
int b = 2;
int sum = a + b;
```

| | |
|:--------|:----------|
| short / short int | short integer (2 bytes) |
| int | integer (4 bytes) |
| long / long int | long integer (4 bytes) |
| bool | boolean (1 byte) |
| float | floating point number (4 bytes) |
| double | double precision floating point number (8 bytes) |
| char | Character (1 byte) |

#### (4/10) Input / Output - Study Guide

```
int uservalue;
cout << "The value of variable sum is " << sum << endl;
cin >> uservalue;
```

#### (5/10) Operators - Study Guide

In C++ there are four main classes of operators:

- Arithmetic
- Relational
- Logical
- Bitwise

```
variable_name = expression;
```

Also:

```
x++;
x--;
```

Relational Operators:

They define a relationship between two values:

```
>, >=, <, <=, ==, !=
```

Logical Operators:

They define how previous relationships must be connected.

```
&&, ||, !
```

- Expressions that use relational or logical operators return 0 or false and 1 for true.
- 0 value converts to false
- non-zero values automatically converts to true

Bitwise operators:

Refer to testing, setting or shifting the actual bits in a byte or word.

```
&, |, ^, ~, >>, <<
```

#### (6/10) Iteration and Conditional Structures - Study Guide

- Useful to instruct the program to execute or to repeat a specific operation when some condition is matched.

| Selection | Iteration | Jump       |
|:----------|:----------|:-----------|
| if        | while     | break      |
| switch    | for       | continue   |
|           | do-while  | goto       |
|           |           | return     |

```
if (expression)
  statement;
else
  statement;
```

```
switch(expression) {
 case constant1:
  statement sequence
  break;
 case constant2:
  statement sequence
  break;
 default
 statement sequence
}
```

```
for(initialization;condition;increment) {
  statement
}

for ( ; ; ) {

}
```

```
while (condition) {
  statement;
}

do {

} while (condition);
```

```
goto label;
...
...
label:
```

#### (7/10) Pointers - Study Guide

- A pointer is a variable that holds a memory address. This address is the location of another object in memory.
- If a variable is a pointer, it must be declared in a different way.
- `type` defines the type of variable the pointer can point to.
- `*` is the complement of `&`. It returns the value located at the address of the following operator.

```
type *name;

x = &y; // places the value in memory pointed by y into x. So if y contains the memory address of another variable, x will have the same of that 3rd variable
```




#### (8/10) Arrays - Study Guide
#### (9/10) Functions Study Guide
#### (10/10) C++-assisted exploitation

### Python (10 items)

#### (1/10) About Python - Study Guide
#### (2/10) Variables and Types - Study Guide
#### (3/10) Input / Output - Study Guide
#### (4/10) Control Flow - Study Guide
#### (5/10) Lists - Study Guide
#### (6/10) Dictionaries - Study Guide
#### (7/10) Functions - Study Guide
#### (8/10) Modules - Study Guide
#### (9/10) Pentester Scripting - Study Guide
#### (10/10) Python-assisted exploitation

### Command Line Scripting (12 items)

#### (1/12) Bash Shell - Study Guide
#### (2/12) Bash Environment - Study Guide
#### (3/12) Bash Commands and Programs - Study Guide
#### (4/12) Bash Output Redirectors and Special Characters - Study Guide
#### (5/12) Bash Conditional Statements and Loops - Study Guide
#### (6/12) Bash Scripting Part 1
#### (7/12) Bash Scripting Part 2
#### (8/12) Windows Command Line - Study Guide
#### (9/12) Windows Environment - Study Guide
#### (10/12) Windows Commands and Programs - Study Guide
#### (11/12) Windows Output Redirectors and Special Characters - Study Guide
#### (12/12) Windows Conditional Statements and Loops - Study Guide

## (3/3) Penetration Testing Basics

### Information Gathering (5 items)

#### (1/5) Introduction - Study Guide
#### (2/5) Open-Source Intelligence - Study Guide
#### (3/5) Subdomain Enumeration - Study Guide
#### (4/5) Subdomain Enumeration
#### (5/5) The Importance of Information Gathering - Study Guide

### Footprinting & Scanning (7 items)

#### (1/7) Disclaimer - Study Guide
#### (2/7) Mapping a Network - Study Guide
#### (3/7) NMAP OS Fingerprinting
#### (4/7) Port Scanning - Study Guide
#### (5/7) NMAP Port Scanning
#### (6/7) Basic Masscan Usage
#### (7/7) Scanning and OS Fingerprinting

### Vulnerability Assessment (4 items)

#### (1/4) Vulnerability Assessment - Study Guide
#### (2/4) Nessus - Study Guide
#### (3/4) Nessus
#### (4/4) Nessus - Lab

### Web Attacks (16 items)

#### (1/16) Introduction - Study Guide
#### (2/16) Web Server Fingerprinting - Study Guide
#### (3/16) HTTP Verbs - Study Guide
#### (4/16) Netcat
#### (5/16) Directories and Files Enumeration - Study Guide
#### (6/16) Dirbuster
#### (7/16) Dirb
#### (8/16) Dirbuster
#### (9/16) Google Hacking - Study Guide
#### (10/16) Cross Site Scripting - Study Guide
#### (11/16) XSS
#### (12/16) Cross site scripting
#### (13/16) SQL Injections - Study Guide
#### (14/16) SQL Injection
#### (15/16) Sqlmap
#### (16/16) SQL Injection

### System Attacks (6 items)

#### (1/6) Malware - Study Guide
#### (2/6) Backdoor
#### (3/6) Password Attacks - Study Guide
#### (4/6) John the Ripper
#### (5/6) Hashcat
#### (6/6) Buffer Overflow Attacks - Study Guide

### Network Attacks (17 items)

#### (1/17) Authentication Cracking - Study Guide
#### (2/17) Hydra: Authentication Cracking
#### (3/17) Bruteforce and Password cracking
#### (4/17) Windows Shares - Study Guide
#### (5/17) Null Sessions - Study Guide
#### (6/17) Null Session
#### (7/17) Null Session
#### (8/17) ARP Poisoning - Study Guide
#### (9/17) ARP Spoofing
#### (10/17) ARP Poisoning
#### (11/17) Metasploit - Study Guide
#### (12/17) Metasploit
#### (13/17) Metasploit
#### (14/17) Meterpreter - Study Guide
#### (15/17) Meterpreter
#### (16/17) Beyond Remote Code Execution
#### (17/17) Shells

### Next Steps (6 items)

#### (1/6) What to do Next - Study Guide
#### (2/6) Black-box Penetration Test 1
#### (3/6) Black-box Penetration Test 2
#### (4/6) Black-box Penetration Test 3
#### (5/6) Penetration Testing Approach - Study Guide
#### (6/6) Career Paths - Study Guide

## References

- https://kentosec.com/2019/08/04/how-to-pass-the-ejpt/