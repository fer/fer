# Learning Path - Penetration Testing Student


1. [Penetration Testing Prerequisites](eJPT/1of3-penetration-testing-prerequisites.md)
2. [Preliminary Skills and Programming](eJPT/2of3-preliminary-skills-and-programming.md)
3. [In progress - Penetration Testing Basics](eJPT/3of3-penetration-testing-basics.md)
4. [Tool Summary](eJPT/tool-summary.md)

<!--
To do:
- [ ] Make a tool list
- [ ] Link in 'notes' section (under this repo/website)
-->

> Find these documentation files under this [GitHub repo](https://github.com/fer/fer).

## References

- [Binary Fingers](https://www.mathsisfun.com/numbers/binary-count-fingers.html)
- [Binary Hex Converters](https://www.binaryhexconverter.com/)
- [CDIR Calculator](https://www.subnet-calculator.com/cidr.php)
- [Common Security](https://wiki.skullsecurity.org/Passwords)
- [DataExfiltration with PacketWhisper](https://github.com/TryCatchHCF/PacketWhisper)
- [egresscheck framework](https://github.com/stufus/egresscheck-framework)
- [Exfiltration](https://attack.mitre.org/tactics/TA0010/)
- [Exploit DB](https://www.exploit-db.com/google-hacking-database)
- [Hacker Manifesto](http://phrack.org/iss3.html)
- [ISO/OSI Model](https://docs.microsoft.com/en-US/windows-hardware/drivers/network/windows-network-architecture-and-the-osi-model)
- [OpenVPN stable release](https://build.openvpn.net/downloads/releases/latest/)
- [OWASP-XSS](https://owasp.org/www-community/attacks/xss/)
- [Special Use of IPv4 Addresses](https://datatracker.ietf.org/doc/html/rfc5735)
- [TCPView](https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview)
- [Variable Length Subnet Table For IPv4](https://datatracker.ietf.org/doc/html/rfc1878).
- [Wireshark](https://www.wireshark.org/)
- [Wireshark SampleCaptures](https://wiki.wireshark.org/SampleCaptures)
- [Wireshark User’s Guide](https://www.wireshark.org/docs/wsug_html_chunked/)

## Glossary

<!--
- White hat hacker
- Black hat hacker
  -  Crackers
- User
- Malicious user
- Root/Administrator
-->

Adware
: Annoying software that shows ads to computer users.

Bootkit
: Rootkits which circumvent OS protection mechanisms by executing during the bootstrap phase.

Bots
: Small pieces of software that get installed on millions of machines to perform DoS, and remotely commanded by a C&C server.

CAM
: Content Addressable Memory

Dialer
: Tries to dial numbers on dial-up connections in order to collect money from the victim's phone bill, nowadays targeting smartphones.

DoS
: Denial of Service.

Egress Filtering
: Practice of monitoring and potentially restricting the flow of information outbound from one network to another. Typically it is information from a private TCP/IP computer network to the Internet that is controlled.

Greyware
: Either spyware, adware or both.

Keylogger
: Special software that records every keystroke on the remote victim machine, window names and sends logs to a server controlled by the attacker. There are basically two types: *Hardware keyloggers* and *Rootkit keyloggers* (stealthy and more invisible to the victim user than software keyloggers, hijacks the OS APIs to record keystrokes, intercepting the interrupt tables from the OS).

Malware
: Any software used to misuse computer systems with the intent to cause a DoS, spy on users activity, get unauthorized control over one or more computer systems, etc.

Password Cracking
: Process of recovering clear-text passwords starting from their hash, where the attacker tries to guess the password.

Packet
: Stream of bits running as electric signals on physical media used for data transmission (wire/LAN, WiFi). Every packet has *header* (ensures receiver can interpret payload and handle the communication) and a *payload* (with the actual information).

Privileges
: Identify actions a user is allowed to do.

Ransomware
: Encrypts a computer or smartphone with a secret key and asks its victim for a ransom.

Remote Code Execution
: Malicious user manages to execute some attacker-controlled code on a victim remote machine.

Rootkit
: Designed to hide itself from users and antivirus programs in order to subvert the OS functioning, maintaining privileged access to the victim without being noticed.

Security through Obscurity
: Secrecy of design to provide security.

ShellCode
: Piece of custom code which provides the attacker a shell on the victim machine.

Spyware
: Collects info about user's activity (OS, visited websites, passwords).

Trojan Horse:
: Comes embedded in seemingly harmless file, being _backdoors_ the most common.

Virus
: Small piece of code that spreads from computer to computer without any direct action or authorization by the owners of the infected machines, normally copying themselves to special sections of the HDD or inside legitimate programs or documents, running every time an infected program or file is opened.

Worms
: Spread over the network by exploiting OS and SW vulnerabilities, exploiting credentials or misconfigurations to attack a service or a machine, usually worms are part of other software and they offer an entry point into the target system.

XSS
: XSS is a vulnerability that lets an attacker control some of the content of a web application. XSS vulnerabilities happen when a web application uses unfiltered user input to build the output content displayed to its end users, letting an attacker control the output HTML and JS code, targeting the app's users (admin is included). XSS involves injecting malicious code into the output of a webpage, this malicious code is the rendered (or executed) by the browser of the visiting users.