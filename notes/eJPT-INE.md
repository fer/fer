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
#### (4/7) HTTP(s) Traffic Sniffing - Video

There are **2** websites using **HTTP** and **HTTPS** respectively.

###############################################################################################
###############################################################################################
######################################   W  I  P  #############################################
###############################################################################################
###############################################################################################
#### (5/7) Connecting to your first lab

###############################################################################################
###############################################################################################
######################################   W  I  P  #############################################
###############################################################################################
###############################################################################################

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

- 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F.

`0x3a1` = `3a1h` = `929d`

|:-----------|:-----------|:-----------|
| 3 = 3      |  3 * 16^2  | 768        |
| a = 10     |  10 * 16^1 | 160        |
| 1 = 1      |  1 * 16^0  | 1          |

##### Converting decimal to hexadecimal

`1019d` = `0x3FB`

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



















#### (3/12) Routing - Study Guide
#### (4/12) Link Layer Devices & Protocols - Study Guide
#### (5/12) TCP & UDP - Study Guide
#### (6/12) Firewall & Defense - Study Guide
#### (7/12) Find the Secret Server
#### (8/12) DNS - Study Guide
#### (9/12) Wireshark - Study Guide
#### (10/12) Using Wireshark
#### (11/12) Full Stack Analysis with Wireshark
#### (12/12) Data Exfiltration

### Web Applications (11 items)

#### (1/11) Web Application Introduction - Study Guide
#### (2/11) HTTP Protocol Basics - Study Guide
#### (3/11) HTTP(s) Protocol Basics
#### (4/11) HTTP Cookies - Study Guide
#### (5/11) Sessions - Study Guide
#### (6/11) HTTP(s) Cookies and Sessions
#### (7/11) Same Origin Policy - Study Guide
#### (8/11) Burp Suite - Study Guide
#### (9/11) Burpsuite
#### (10/11) Burp Suite Basics
#### (11/11) Burp Suite















### Penetration Testing (2 items)

#### (1/2) Penetration Testing Introduction - Study Guide
#### (2/2) Lifecycle of a Penetration Tester - Study Guide

## (2/3) Penetration Testing: Preliminary Skills & Programming

### Introduction to Programming (4 items)

#### (1/4) What is Programming - Study Guide
#### (2/4) Low and High-Level Languages - Study Guide
#### (3/4) Programming and Scripting - Study Guide
#### (4/4) Basic Concepts - Study Guide

### C++ (10 items)

#### (1/10) C++ IDE - Study Guide
#### (2/10) Structure of C++ Programs - Study Guide
#### (3/10) Variables and Types - Study Guide
#### (4/10) Input / Output - Study Guide
#### (5/10) Operators - Study Guide
#### (6/10) Iteration and Conditional Structures - Study Guide
#### (7/10) Pointers - Study Guide
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