# Module 06: System Hacking



{% hint style="info" %}
**Objectives**

* Overview of CEH Hacking Methodology 
* Understanding Techniques to Gain Access to the System 
* Understanding Privilege Escalation Techniques 
* Understanding Techniques to Create and Maintain Remote Access to the System 
* Overview of Different Types of Rootkits 
* Overview of Steganography and Steganalysis Techniques 
* Understanding Techniques to Hide the Evidence of Compromise
* Understanding Different System Hacking Countermeasures
{% endhint %}

## 1. System Hacking Concepts

The following is an overview of these phases and the information collected so far:

* **Footprinting Module**: Footprinting is the process of accumulating data about a specific network environment. In the footprinting phase, the attacker creates a profile of the target organization and obtains information such as its IP address range, namespace, and employees. Footprinting facilitates the process of system hacking by revealing its vulnerabilities. For example, the organization’s website may provide employee bios or a personnel directory, which the hacker can use for social engineering purposes. Conducting a Whois query on the web can provide information about the associated networks and domain names related to a specific organization.
* **Scanning Module**: Scanning is a procedure used for identifying active hosts, open ports, and unnecessary services enabled on particular hosts. Attackers use different types of scanning methods for host discovery, port and service discovery, operating system \(OS\) discovery, and evading endpoint security devices such as intrusion detection systems \(IDSs\) and firewalls. These techniques help attackers identify possible vulnerabilities. Scanning procedures such as port scanning and ping sweeps return information about the services offered by the live hosts that are active on the Internet, and their IP addresses.
* **Enumeration Module**: Enumeration is a method of intrusive probing, through which attackers gather information such as network user lists, routing tables, security flaws, and Simple Network Management Protocol \(SNMP\) data. This is of significance, because the attacker ranges over the target territory to glean information about the network, and shared users, groups, applications, and banners.

  Enumeration involves making active connections to the target system or subjecting it to direct queries. Normally, an alert and secure system logs such attempts. Often, the information gathered, such as a DNS address, is publicly available; however, it is possible that the attacker might stumble upon a remote IPC share, such as IPC$ in Windows, that can be probed with a null session, thereby allowing shares and accounts to be enumerated.

* **Vulnerability Analysis Module**: Vulnerability assessment is an examination of the ability of a system or application, including its current security procedures and controls, to withstand assault. It recognizes, measures, and classifies security vulnerabilities in a computer system, network, and communication channels. Attackers perform vulnerability analysis to identify security loopholes in the target organization’s network, communication infrastructure, and end systems. The identified vulnerabilities are used by the attackers to perform further exploitation on that target network.

### CEH Hacking Methodology \(CHM\)

1. **Footprinting**
2. **Scanning**
3. **Enumeration**
4. **Vulnerability Analysis**
5. **System Hacking**
   1. **Gaining Access**: The previous phases of hacking, including footprinting and reconnaissance, scanning, enumeration, and vulnerability assessment, help attackers to identify security loopholes and vulnerabilities that exist in the target organizational IT assets. Attackers use this information to gain access to the target organizational system.
      1. **Cracking passwords**: Password cracking involves gaining access to low-privileged user accounts by cracking passwords using techniques such as brute-forcing, password guessing, and social engineering. 
      2. **Vulnerability Exploitation**:  Attackers exploit the identified vulnerabilities, such as buffer overflows, to gain root-level access to the target system.
   2. **Escalating Privileges**: attackers then escalate their privileges to administrative levels, to perform a protected operation. Attackers exploit vulnerabilities that exist in OSs and software applications to escalate privileges.
   3. **Maintaining Access**: attackers ensure that high levels of access are maintained to perform malicious activities such as executing malicious applications and stealing, hiding, or tampering with sensitive system files.
      1. **Executing Applications**: Once the attacker has administrator privileges, they can attempt to install malicious programs such as Trojans, backdoors, rootkits, and keyloggers, which grant them remote system access and enable them to remotely execute malicious codes. Installing rootkits allows the attacker to gain access at the OS level to perform malicious activities. To maintain access for later use, they may even install backdoors.
      2. **Hiding Files**: Attackers use rootkits and steganography techniques to attempt to hide the malicious files they install on the system, and thus their activities.
   4. **Clearing Logs**: To maintain future system access, attackers attempt to avoid recognition by legitimate system users. To remain undetected, attackers wipe out the entries corresponding to their activities in the system logs, thus avoiding detection by users.
      1. **Covering Tracks**: To remain undetected, it is important for the attackers to erase from the system all evidence of security compromise. To achieve this, they might modify or delete logs in the system using certain log-wiping utilities, thus removing all evidence of their presence.

### System Hacking Goals

1. **G**aining Access
2. **E**scalating Privileges
3. **E**xecuting Applications
4. **H**iding Files
5. **C**overing Tracks

## 2. Gaining Access

Compromising accounts that already exist in the system.

### Cracking Passwords

#### Microsoft Authentication

When users log in to a Windows computer, a series of steps is performed for user authentication. The Windows OS authenticates its users with the help of three mechanisms \(protocols\) provided by Microsoft.

**Security Accounts Manager \(SAM\) Database**

This would be `shadow` in Linux.

Active Directory in Windows: `ntds.dit`.

* Windows stores user passwords in SAM, or in the Active Directory database in domains. Passwords are never stored in clear text and are hashed, and the results are stored in the SAM.
* The system does not store the passwords in plaintext format but in a hashed format, to protect them from attacks.
* Windows uses the Security Accounts Manager \(SAM\) database or Active Directory Database to manage user accounts and passwords in hashed format \(a one-way hash\). 
* The system implements the SAM database as a registry file, and the Windows kernel obtains and keeps an exclusive filesystem lock on the SAM file. 
* As this file consists of a filesystem lock, this provides some measure of security for the storage of passwords.

It is not possible to copy the SAM file to another location in the case of online attacks. Because the system locks the SAM file with an exclusive filesystem lock, a user cannot copy or move it while Windows is running. The lock does not release until the system throws a blue screen exception, or the OS has shut down. However, to make the password hashes available for offline brute-force attacks, attackers can dump the on-disk contents of the SAM file using various techniques. The SAM file uses an SYSKEY function \(in Windows NT 4.0 and later versions\) to partially encrypt the password hashes.

**How Hash Passwords Are Stored in Windows SAM?**

> LM hashes have been disabled in Windows Vista and later Windows operating systems, LM will be blank in those systems.

![](../../.gitbook/assets/image%20%2864%29.png)

* Windows OSs use a Security Account Manager \(SAM\) database file to store user passwords.
* The SAM file is stored at `%SystemRoot%/system32/config/SAM` in Windows systems, and Windows mounts it in the registry under the HKLM/SAM registry hive. It stores LM or NTLM hashed passwords.
* NTLM supersedes the LM hash, which is susceptible to cracking. 

NTLM supersedes the LM hash, which is susceptible to cracking. New versions of Windows still support LM hashes for backward compatibility; however, Vista and later Windows versions disable LM hashes by default. The LM hash is blank in the newer versions of Windows. Selecting the option to remove LM hashes enables an additional check during password change operations but does not immediately clear LM hash values from the SAM. The SAM file stores a “dummy” value in its database, which bears no relationship to the user’s actual password and is the same for all user accounts. It is not possible to calculate LM hashes for passwords exceeding 14 characters in length. Thus, _the LM hash value is set to a “dummy” value when a user or administrator sets a password of more than 14 characters_.

**NTLM Authentication**

Challenge handshake based authentication \(and a protocol\).

Predecesor of Kerberos.

* The NTLM authentication protocol types are as follows: _NTLM authentication protocol_ and _LM authentication protocol_.
* These protocols store the user’s password in the _SAM database_ using different hashing methods.
* NT LAN Manager \(NTLM\) is a default authentication scheme that performs authentication using a challenge/response strategy.
* Because it does not rely on any official protocol specification, there is no guarantee that it works effectively in every situation. Furthermore, it has been used in some Windows installations, where it successfully worked.

NTLM authentication consists of two protocols: NTLM authentication protocol and LAN Manager \(LM\) authentication protocol. These protocols use different hash methodologies to store users’ passwords in the SAM database.

**NTLM Authentication Process**

![](../../.gitbook/assets/image%20%2844%29.png)

> **Note**: Microsoft has upgraded its default authentication protocol to Kerberos, which provides stronger authentication for client/server applications than NTLM.

NTLM includes three methods of challenge–response authentication: LM, NTLMv1, and NTLMv2, all of which use the same technique for authentication. The only difference between them is the level of encryption. In NTLM authentication, the client and server negotiate an authentication protocol. This is accomplished through the Microsoft-negotiated Security Support Provider \(SSP\).

The following steps demonstrate the process and the flow of client authentication to a domain controller using any NTLM protocol:

* The client types the username and password into the logon window.
* Windows runs the password through a hash algorithm and generates a hash for the password that is entered in the logon window.
* The client computer sends a login request along with a domain name to the domain controller.
* The domain controller generates a 16-byte random character string called a “nonce,” which it sends to the client computer.
* The client computer encrypts the nonce with a hash of the user password and sends it back to the domain controller.
* The domain controller retrieves the hash of the user password from the SAM and uses it to encrypt the nonce. The domain controller then compares the encrypted value with the value received from the client. A matching value authenticates the client, and the logon is successful.

**Kerberos Authentication**

* Microsoft has upgraded its default authentication protocol to Kerberos which provides a stronger authentication for client/server applications than NTLM.
* Kerberos is a network authentication protocol that provides strong authentication for client/server applications through secret-key cryptography. 
* This protocol provides mutual authentication, in that both the server and the user verify each other’s identity.
* Messages sent through Kerberos protocol are protected against replay attacks and eavesdropping.

Kerberos employs the Key Distribution Center \(KDC\), which is a trusted third party. This consists of two logically distinct parts: an authentication server \(AS\) and a ticket-granting server \(TGS\). Kerberos uses “tickets” to prove a user’s identity. Microsoft has upgraded its default authentication protocol to Kerberos, which provides a stronger authentication for client/server applications than NTLM.

**Kerberos Authentication Process**

* Kerberos is a network authentication protocol that provides strong authentication for client/server applications through secret-key cryptography, which provides mutual authentication. 
* Both the server and the user verify each other’s identity.
* Messages sent through this protocol are protected against replay attacks and eavesdropping.

![](../../.gitbook/assets/image%20%2865%29.png)

* Kerberos employs the KDC, which a trusted third party, and consists of two logically distinct parts: an AS and a TGS. 
* The authorization mechanism of Kerberos provides the user with a ticket-granting ticket \(TGT\) that serves post-authentication for later access to specific services, Single Sign-On via which the user need not re-enter the password again to access any authorized services. 
* Notably, _there is no direct communication between the application servers and the KDC_; the service tickets, even if packed by TGS, reach the service only through the client who is willing to access them.

#### Password Cracking

* Password cracking techniques are used to recover passwords from computer systems.
* Attackers use password cracking techniques to gain unauthorized access to vulnerable systems.
* Most of the password cracking techniques are successful because of weak or easily guessable passwords.

**Types of Password Attacks**

* **Non-Electronic Attacks**: The attacker does not need technical knowledge to crack the password, hence it is known as a non-technical attack.
  * Social Engineering: Convincing people to reveal passwords.
  * Shoulder Surfing: Looking at either the user’s keyboard or screen while he/she is logging in.
  * Dumpster Diving: Searching for sensitive information in the user’s trash-bins, printer trash bins, and in/on the user’s desk for sticky notes.
* **Active Online Attacks**: The attacker performs password cracking by directly communicating with the victim’s machine.
  * _Dictionary Attack_: A dictionary file is loaded into the cracking application that runs against user accounts.
    * Applicable in two situations:
      * In cryptanalysis, to discover the decryption key for obtaining the plaintext from a ciphertext.
      * In computer security, to bypass authentication and access the control mechanism of the computer by guessing passwords.
    * Methods to improve the success of a dictionary attack:
      * Use of several different dictionaries, such as technical and foreign dictionaries, which increases the number of possibilities.
      * Use of string manipulation along with the dictionary \(e.g., if the dictionary contains the word “system,” string manipulation creates anagrams like “metsys,” among others\).
  * _Brute-Force Attack_: The program tries every combination of characters until the password is broken.
    * Exhaustive key-search, or brute-force search, is the basic technique for trying every possible key in turn until the correct key is identified.
    * Cryptanalysis is a brute-force attack on encryption that employs a search of the keyspace. 
    * A brute-force attack is when someone tries to produce every single encryption key for data to detect the needed information. Even today, only those with enough processing power could successfully perform this type of attack. 
    * Some of the considerations for brute-force attacks are as follows: 
      * It is a time-consuming process.
      * All passwords will eventually be found.
  * _Rule-based Attack_: This attack is used when the attacker gets some information about the password.
    * This is a more powerful attack than dictionary and brute-force attacks because the cracker knows the password type. 
    * This technique involves brute force, a dictionary, and syllable attacks.
      * Hybrid Attack: This type of attack depends on the dictionary attack. Often, people change their passwords merely by adding some numbers to their old passwords. In this case, the program would add some numbers and symbols to the words from the dictionary to try to crack the password. For example, if the old password is “system,” then there is a chance that the person will change it to “system1” or “system2.”
      * Syllable Attack: Hackers use this cracking technique when passwords are not known words. Attackers use the dictionary and other methods to crack them, as well as all possible combinations of them.
  * _Trojan/Spyware/Keyloggers_: 
    * The attacker installs a Trojan/Spyware/Keylogger on the victim's machine to collect the victim's usernames and passwords. 
    * The Trojan/Spyware/Keylogger runs in the background and sends back all user credentials to the attacker.
  * _Hash Injection Attack/Pass-the-Hash \(PtH\)_: 
    * A hash injection/PtH attack allows an attacker to inject a compromised hash into a local session and use the hash to validate network resources.
    * The attacker finds and extracts a logged-on domain admin account hash.
    * The attacker uses the extracted hash to log on to the domain controller.
    * This type of attack is possible when the target system uses a hash function as part of the authentication process to authenticate its users. Generally, the system stores hash values of the credentials in the SAM database/file on a Windows computer. In such cases, the server computes the hash value of the user-submitted credentials or allows the user to input the hash value directly. The server then checks it against the stored hash value for authentication.
    * Different techniques are used to perform a hash injection/PtH attack:
      * The attacker tries to compromise admin privileges to capture cache values of the user’s password hashes from the local user account database or SAM. However, offline usage of these cached hashes can be restricted by the network admin. Hence, this approach may not always be feasible.
      * The attacker dumps the password hashes from the local user account database or SAM to retrieve password hashes of local users, and gains access to admin accounts to compromise other connected systems.
      * The attacker captures LM or NTLM challenge–response messages between the client and server to extract encrypted hashes through brute-forcing.
      * The attacker retrieves the credentials of local users as well as those belonging to the security domain from the Windows lsass.exe process.
    * The hacker carries out this attack by implementing the following five steps: 
      * The hacker compromises one workstation/server using a local/remote exploit. 
      * The hacker extracts stored hashes using tools such as pwdump7, Mimikatz, etc. and finds a domain admin account hash.
      * The hacker uses tools such as Mimikatz to place one of the retrieved hashes in his/her local lsass.exe process and then uses the hash to log on to any system \(domain controller\) with the same credentials.
      * The hacker extracts all the hashes from the Active Directory database and can now compromise any account in the domain.
  * _Password Guessing_: The attacker creates a list of all possible passwords from the information collected through social engineering or any other way and manually inputs them on the victim’s machine to crack the passwords.
    * 1. Find a valid user / 2. Create a list of possible passwords / 3. Rank passwords from high to low probability / 4. Key in each password, until the correct password is discovered.
    * _Manual Password-Cracking Algorithm_: In its simplest form, this algorithm can automate password guessing using a simple FOR loop. In the example that follows, an attacker creates a simple text file with usernames and passwords and iterates them using the FOR loop.
    * _Default Passwords_: 
      * A default password is a password supplied by the manufacturer with new equipment \(e.g., switches, hubs, routers\) that is password protected
      * Attackers use default passwords present in the list of words or dictionary that they use to perform password guessing attack
      * Online Tools to Search Default Passwords
        * [https://www.fortypoundhead.com](https://www.fortypoundhead.com) 
        * [https://cirt.net](https://cirt.net) 
        * [http://www.defaultpassword.us](http://www.defaultpassword.us) 
        * [http://defaultpasswords.in](http://defaultpasswords.in) 
        * [https://www.routerpasswords.com](https://www.routerpasswords.com)
        * [https://default-password.info](https://default-password.info)
  * _LLMNR/NBT-NS Poisoning_: 
    * LLMNR and NBT-NS are the two main elements of Windows operating systems that are used to perform name resolution for hosts present on the same link.
    * The attacker cracks the NTLMv2 hash obtained from the victim’s authentication process.
    * The extracted credentials are used to log on to the host system in the network.
    * When the DNS server fails to resolve name queries, the host performs an unauthenticated UDP broadcast asking all the hosts if anyone has a name that it is looking for. As the host trying to connect is following an unauthenticated and broadcast process, it becomes easy for an attacker to passively listen to a network for LLMNR \(UDP port 5355\) and NBT-NS \(UDP port 137\) broadcasts and respond to the request pretending to be a target host. After accepting a connection with a host, the attacker can utilize tools such as Responder.py or Metasploit to forward the request to a rogue server \(for instance, TCP: 137\) to perform an authentication process.
    * During the authentication process, the attacker sends an NTLMv2 hash to the rogue server, which was obtained from the host trying to authenticate itself. This hash is stored in a disk and can be cracked using offline hash-cracking tools such as hashcat or John the Ripper. Once cracked, these credentials can be used to log in and gain access to the legitimate host system.
    * [Responder](https://github.com/lgandx/Responder) is a LLMNR/NBT-NS Spoofing tool.
  * _Internal Monologue Attack_: Attackers perform an internal monologue attack using SSPI \(Security Support Provider Interface\) from a user-mode application, where a local procedure call to the NTLM authentication package is invoked to calculate the NetNTLM response in the context of the logged-on user.
    * The internal monologue attack is similar to the attack performed using Mimikatz, except that the memory area of the Local Security Authority Subsystem Service \(LSASS\) process is not dumped, thereby avoiding Windows Credential Guard and antivirus. Mimikatz is a post-exploitation tool, through which attackers can extract plaintext passwords, Kerberos tickets, and NTLM hashes from LSASS process memory. Attackers use Mimikatz to retrieve user credentials from LSASS process memory, and the acquired information helps them in performing lateral movement in the post-exploitation phase.
    * An internal monologue attack is usually performed in a secure environment where Mimikatz cannot be executed. In this attack, using the Security Support Provider Interface \(SSPI\) from a user-mode application, a local procedure call to the NTLM authentication package is invoked to calculate the NetNTLM response in the context of the logged-on user.
    * Steps to perform an internal monologue attack:
      * The attacker disables the security controls of NetNTLMv1 by modifying the values of LMCompatibilityLevel, NTLMMinClientSec, and RestrictSendingNTLMTraffic.
      * The attacker extracts all the non-network logon tokens from all the active processes to masquerade as legitimate users.
      * Now, the attacker interacts with NTLM SSP locally, for each masqueraded user to obtain a NetNTLMv1 response to the chosen challenge in the security context of that user.
      * Now, the attacker restores LMCompatibilityLevel, NTLMMinClientSec, and RestrictSendingNTLMTraffic to their actual values.
      * The attacker uses rainbow tables to crack the NTLM hash of the captured responses.
      * Finally, the attacker uses the cracked hashes to gain system-level access.
  * _Cracking Kerberos Passwords_:
    * _AS-REP Roasting \(Cracking TGT\)_: Attackers request a TGT from the KDC in the form of the an AS-REQ packet and crack the ticket to obtain the user’s password. In this attack, attackers request an authentication ticket \(TGT\) from the KDC in the form of an AS-REQ packet. If the user account exists, the KDC replies with a TGT encrypted with the account’s credentials. This allows attackers to receive an encrypted ticket, which can then be saved offline and further cracked to obtain the password. Attackers can perform this type of attack both actively and passively. In an active scenario, attackers generate an AS-REP message for the user, whereas in a passive scenario, attackers observe an AS-REP message. In Kerberos authentication, the pre-authentication mode is enabled by default and is designed to prevent offline password-guessing attacks. Therefore, to perform an AS-REP Roasting attack, attackers must identify user accounts with pre-authentication mode disabled, i.e., the user account must be set to “Do not require Kerberos authentication.” Attackers use tools such as Rubeus to perform AS-REP roasting attacks.
      * The following steps are involved in AS-REP Roasting:
        * The attacker identifies a user account with the pre-authentication option disabled.
        * On behalf of the user, the attacker requests an authentication ticket \(TGT\) from the domain controller or KDC.
        * The domain controller verifies the user account and replies with a TGT encrypted with the account’s credentials.
        * The attacker stores the TGT offline, and cracks it to extract the user account password and further access the network entity \(here, the application server\).
    * _Kerberoasting \(Cracking TGS\)_: Attackers request a TGS for the SPN of the target service account and crack the ticket to obtain the user’s password.  In this attack, attackers request a TGS for the service principal name \(SPN\) of the target service account. This request is made to the domain controller by using a valid domain user’s authentication ticket \(TGT\). The domain controller does not have any records; if the user has accessed the network resources, it just searches the SPN in the Active Directory, and further replies with an encrypted ticket using a service account linked with SPN. The type of encryption used for the requested service ticket \(ST\) is RC4\_HMAC\_MD5, which indicates that for encrypting the ST, the NTLM password hash is used. To crack the ST, attackers export the TGS tickets from memory and save them offline to the local system. Furthermore, attackers use different NTLM hashes to crack the ST and, on successfully cracking it, the service account password can be discovered. Attackers use tools such as Kerberoast to perform Kerberoasting attacks on Kerberos authentication.
      * The following steps are involved in Kerberoasting:
        * On behalf of a user, the attacker requests an authentication ticket \(TGT\) from the domain controller or KDC.
        * The domain controller verifies the user account and replies with an encrypted TGT.
        * With a valid user authentication ticket \(TGT\), the attacker requests the TGS.
        * The domain controller verifies the TGT and replies with a TGS ticket. 
        * The attacker stores the TGS ticket offline, and cracks it to extract the service account password and further access the network entity \(here, the application server\).
  * _Pass-the-ticket Attack_: 
    * Pass-the-ticket is a technique used for authenticating a user to a system that is using Kerberos tickets without providing the user’s password. Kerberos authentication allows users to access services provided by remote servers without the need to provide passwords for every requested service. To perform this attack, the attacker dumps Kerberos tickets of legitimate accounts using credential dumping tools.
    * A TGT or ST can be captured based on the level of access permitted to a client. Here, the ST permits access to specific resources, and the TGT is used to send a request to the TGS for the ST to access all the services the client has been authorized to access.
    * Silver Tickets are captured for resources that use Kerberos for the authentication process, and can be used to create tickets to call a specific service and access the system that offers the service.
    * Golden tickets are captured for the domain with the KDS KRBTGT NTLM hash that allows the creation of TGTs for any profile in the Active Directory.
    * Attackers launch pass-the-ticket attacks either by stealing the ST/TGT from an end-user machine and using it to disguise themselves as a valid user, or by stealing the ST/TGT from a compromised AS. After obtaining one of these tickets, an attacker can gain unauthorized access to the network services and search for additional permissions and critical data.
    * Attackers use tools such as [Mimikatz](%3E), Rubeus, Windows Credentials Editor, etc. to launch pass-the-ticket attacks.
  * _Combinator Attack_:
    * Attackers combine the entries of the first dictionary with those of the second dictionary to generate a new wordlist to crack the password of the target system.
    * For example, if the first dictionary contains 100 words, and the second dictionary contains 70 words, then the merged dictionary contains 100 × 70 = 7000 words.
    * Use automated tools, such as hashcat, to crack the password of the target user.
    * Attackers perform this type of password cracking in a situation where a random phrase of words is used as a default password generation procedure.
  * _Fingerprint attack_: 
    * In a fingerprint attack, the passphrase is broken down into fingerprints consisting of single-and multi-character combinations that a target user might choose as his/her password. 
    * For example, for a word ‘password’, this technique would create fingerprints “p”, “a”, ”s”, ”s”, ”w”, ”o”, ”r”, “d”, “pa” , “ss”, “wo”, “rd”, etc. Attackers usually perform this attack to crack complex passwords such as “pass-10”.
    * To perform this attack, attackers create a list of unique password hashes from a leaked password hash database, and then perform a brute-force attack to obtain a wordlist and further start the fingerprint attack.
  * _PRINCE Attack_:
    * A PRobability INfinite Chained Elements \(PRINCE\) attack is an advanced version of a combinator attack in which, instead of taking inputs from two different dictionaries, attackers use a single input dictionary to build chains of combined words.
    * This chain can have between 1 and n words from the input dictionary concatenated together to form a chain of words.
  * _Toggle-Case Attack_:
    * In a toggle-case attack, attackers try all possible upper-case and lower-case combinations of a word present in the input dictionary.
    * The success rate of this attack is low for the following reasons:
      * If users use upper-case letters, they either use it in the first place or in between the word.
      * In other cases, the users use a lower or equal number of upper-case letters than lower-case letters.
  * _Markov-Chain Attack_:
    * In Markov-chain attacks, attackers gather a password database and split each password entry into two-and three-character syllables \(2-grams and 3-grams\).
    * A new alphabet is developed, which is then matched with the existing password database.
* **Passive Online Attacks**: The attacker performs password cracking without communicating with the authorizing party.
  * _Wire Sniffing_:
    * Attackers run packet sniffer tools on the local area network \(LAN\) to access and record the raw network traffic.
    * The captured data may include sensitive information such as passwords \(FTP, rlogin sessions, etc.\) and emails.
    * As sniffers run in the background, the victim remains unaware of the sniffing.
    * As sniffers gather packets at the data link layer, they can grab all the packets on the LAN of the machine running the sniffer program. 
    * The majority of sniffer tools are ideally suited to sniff data in a hub environment.
  * _Man-in-the-Middle Attack_:
    * In an MITM attack, the attacker acquires access to the communication channels between the victim and the server to extract the information needed.
    * When two parties are communicating, a man-in-the-middle \(MITM\) attack can take place, in which a third party intercepts a communication between the two parties without their knowledge. The third party eavesdrops on the traffic and then passes it along. To do this, the “man in the middle” has to sniff from both sides of the connection simultaneously.
    * In an MITM attack, the attacker acquires access to the communication channels between the victim and server to extract the information.
    * In a replay attack, packets and authentication tokens are captured using a sniffer. After the relevant information is extracted, the tokens are placed back on the network to gain access.
      * Relatively hard to perpetrate. 
      * Must be trusted by one or both sides.
      * Can sometimes be broken by invalidating traffic.
  * _Replay Attack_:
    * In a replay attack, packets and authentication tokens are captured using a sniffer.
    * After the relevant info is extracted, the tokens are placed back on the network to gain access. 
    * The attacker uses this type of attack to replay bank transactions or similar types of data transfer, in the hope of replicating and/or altering activities, such as banking deposits or transfers.
* **Offline Attacks**: The attacker copies the target’s password file and then tries to crack passwords on his own system at a different location.
  * _Rainbow Table Attack \(Pre-Computed Hashes\)_:
    * A rainbow table attack uses the cryptanalytic time–memory trade-off technique, which requires less time than other techniques.
    * It uses already-calculated information stored in memory to crack the encryption. 
    * In the rainbow table attack, the attacker creates a table of all the possible passwords and their respective hash values, known as a rainbow table, in advance.
      * _Rainbow Table_: A rainbow table is a precomputed table that contains word lists like dictionary files and brute-force lists and their hash values. It is a lookup table specially used in recovering a plaintext password from a ciphertext. The attacker uses this table to look for the password and tries to recover it from password hashes.
      * _Computed Hashes_: An attacker computes the hash for a list of possible passwords and compares it to the pre-computed hash table \(rainbow table\). If attackers find a match, they can crack the password.
      * _Compare the Hashes_: An attacker captures the hash of a password and compares it with the precomputed hash table. If a match is found, then the password is cracked. It is easy to recover passwords by comparing captured password hashes to the pre-computed tables.
      * Tool to create rainbow tables: [rtgen](http://project-rainbowcrack.com)
  * _Distributed Network Attack_: 
    * A Distributed Network Attack \(DNA\) technique is used for recovering passwords from hashes or password-protected files using the unused processing power of machines across the network.
    * The DNA Manager is installed in a central location where machines running on DNA Client can access it over the network.
    * The DNA Manager coordinates the attack and allocates small portions of the key search to machines that are distributed over the network.
    * The DNA Client runs in the background consuming only unused processor time.
    * The program combines the processing capabilities of all the clients connected to the network and uses it to crack the password.

**Trojans/Spyware/Keyloggers**:

![](../../.gitbook/assets/image%20%2834%29.png)

**Hash Injection/Pass-the-Hash \(PtH\) Attack**:

![](../../.gitbook/assets/image%20%2847%29.png)

**LLMNR/NBT-NS Poisoning**:

![](../../.gitbook/assets/image%20%2866%29.png)

**Internal Monologue Attack**:

![](../../.gitbook/assets/image%20%2837%29.png)

**AS-REP Roasting \(Cracking TGT\)**:

![](../../.gitbook/assets/image%20%2857%29.png)

**Kerberoasting \(Cracking TGS\)**:

![](../../.gitbook/assets/image%20%2829%29.png)

### Tools: password recovery tools

* [Password Recovery Toolkit](https://accessdata.com)
* [Passware Kit Forensic](https://www.passware.com)
* [hashcat](https://hashcat.net)
* [Windows Password Recovery Tool](https://www.windowspasswordsrecovery.com)
* [PCUnlocker](https://www.top-password.com)

### Tools: Password Hashes

* [pwdump7](https://www.tarasco.org)
* Mimikatz
* Powershell Empire 
* DSInternals PowerShell 
* Ntdsxtract

> Note: The use of the above tools requires administrative privileges on the remote system.

### Tools: Password Cracking

* [L0phtCrack](https://www.l0phtcrack.com)
* [ophcrack](http://ophcrack.sourceforge.net)
* [RainbowCrack](http://project-rainbowcrack.com)
* [John the Ripper](https://www.openwall.com)
* [hashcat](https://hashcat.net)
* [THC-Hydra](https://github.com)
* [Medusa](http://foofus.net)

### Password Salting

You can kill/countermeasure rainbow attacks by adding password salt, which adds extra entropy.

* Password salting is a technique where a random string of characters are added to the password before calculating their hashes.
* Same passwords can have different hashes due to different salts.
* Advantage: Salting makes it more difficult to reverse the hashes and defeat pre-computed hash attacks.
* In cryptography, a “salt” consists of random data bits used as an input to a one-way function, the other being a password. Instead of passwords, the output of the one-way function can be stored and used to authenticate users.
* A salt combines with a password by a key derivation function to generate a key for use with a cipher or other cryptographic algorithm.
* This technique generates different hashes for the same password, which renders password cracking difficult.

### Password Cracking Countermeasures

* Use an Information security audit to monitor and track password attacks 
* Disallow use of the same password during a password change 
* Disallow password sharing 
* Disallow the use of passwords that can be found in a dictionary 
* Do not use cleartext protocols and protocols with weak encryption 
* Set the password change policy to 30 days 
* Avoid storing passwords in an unsecured location 
* Do not use any system default passwords
* Make passwords hard to guess by requiring 8-12 alphanumeric characters consisting of a combination of uppercase and lowercase letters, numbers and symbols
* Disallow the use of passwords such as date of birth, spouse, child’s, or pet’s name 
* Enable SYSKEY with a strong password to encrypt and protect the SAM database 
* Use a random string \(salt\) as a prefix or suffix to the password before encryption 
* Ensure that applications neither store passwords in memory nor write them to disks in clear text
* Monitor the server’s logs for brute force attacks on the users’ accounts 
* Lockout an account subjected to too many incorrect password guesses
* Make the system BIOS password-protected, particularly on devices that are susceptible to physical threats
* Train employees to thwart social engineering tactics such as shoulder surfing and dumpster diving, which are used to steal credentials
* Secure and control physical access to systems to prevent offline password attacks Use two-factor or multi-factor authentication, for example, - using CAPTCHA to prevent automated attacks 
* Perform password screening when new passwords are created to avoid using commonly used passwords
* Ensure that the password database files are encrypted and accessible only to system administrators 
* Mask the display of passwords on the screen to avoid shoulder surfing attacks

### Vulnerability Exploitation

Vulnerability exploitation involves the execution of multiple complex, interrelated steps to gain access to a remote system. The steps involved are as follows: 1. Identify the vulnerability 2. Determine the capability of the vulnerability 3. Determine the risk associated with the vulnerability 4. Develop the exploit 5. Generate and deliver the payload 6. Select the method for delivering – local or remote 7. Gain remote access

Some sites:

* [Exploit Database](https://www.exploit-db.com)
* [SecurityFocus](https://www.securityfocus.com)
* [VulDB](https://vuldb.com)
* [MITRE CVE Source](https://cve.mitre.org)

### Buffer Overflow

* A buffer is an area of adjacent memory locations allocated to a program or application to handle its runtime data. Buffer overflow or overrun is a common vulnerability in applications or programs that accept more data than the allocated buffer. 
* This vulnerability allows the application to exceed the buffer while writing data to the buffer and overwrite neighboring memory locations.
* This vulnerability leads to erratic system behavior, system crash, memory access errors, etc.  
* Attackers exploit a buffer overflow vulnerability to inject malicious code into the buffer to damage files, modify program data, access critical information, escalate privileges, gain shell access, and so on.

#### Why Are Programs and Applications Vulnerable to Buffer Overflows?

* Boundary checks are not performed fully, or, in most cases, entirely skipped.
* Applications that use older versions of programming languages involve several vulnerabilities.
* Programs that use unsafe and vulnerable functions fail to validate the buffer size.
* Programs and applications that do not adhere to good programming practices.
* Programmers that fail to set proper filtering and validation principles in the applications.
* Systems that execute code present in the stack segment are vulnerable to buffer overflows.
* Improper memory allocation and insufficient input sanitization in the application lead to buffer overflow attacks.
* Application programs that use pointers for accessing heap memory result in buffer overflows.

A stack is used for static memory allocation and stores the variables in “Last-in First-out” \(LIFO\) order.

There are **two stack operations**:

* **PUSH** _stores_ data onto the stack 
* **POP** _removes_ data from the stack

#### Types of Buffer Overflow

* [Windows Buffer Overflow Exploitation](https://bookshelf.vitalsource.com/#/books/9781635675337/cfi/644!/4/4@0.00:17.6)

**Stack-Based Buffer Overflow**

There are two types of buffer overflow, namely the stack-based buffer overflow and heap-based buffer overflow.

Stack memory includes five types of registers:

* EBP: Extended Base Pointer \(EBP\), also known as StackBase, stores the address of the first data element stored onto the stack
* ESP: Extended Stack Pointer \(ESP\) stores the address of the next data element to be stored onto the stack
* EIP: Extended Instruction Pointer \(EIP\) stores the address of the next instruction to be executed
* ESI: Extended Source Index \(ESI\) maintains the source index for various string operations
* EDI: Extended Destination Index \(EDI\) maintains the destination index for various string operations

A stack-based buffer overflow occurs when an application writes more data to a buffer than what is actually allocated for that buffer. To understand stack-based buffer overflow, you must focus on the EBP, EIP, and ESP registers. EIP is the most important read-only register, which stores the address of the instruction that needs to be subsequently executed.

Whenever a function starts execution, a stack frame that stores its information is pushed onto the stack and stored in the ESP register. When the function returns, the stack frame is popped out from the stack and the execution resumes from the return address stored on the EIP register. Hence, if an application or program is vulnerable to buffer overflow attack, then attackers take control of the EIP register to replace the return address of the function with malicious code that allows them to gain shell access to the target system.

**Heap-Based Buffer Overflow**

* A heap is used for dynamic memory allocation. Heap memory is dynamically allocated at run time during the execution of the program, and it stores the program data. Accessing heap memory is slower than accessing stack memory. The allocation and deallocation of heap memory is not performed automatically. Programmers must write code for the allocation \[malloc\(\)\] of heap memory, and after the execution is complete, they must deallocate the memory using functions such as free\(\).
* Heap-based overflow occurs when a block of memory is allocated to a heap and data is written without any bound checking. This vulnerability leads to overwriting links to dynamic memory allocation \(dynamic object pointers\), heap headers, heap-based data, virtual function tables, etc. Attackers exploit heap-based buffer overflow to take control of the program’s execution.
* Buffer overflows commonly occur in the heap memory space, and exploitation of these bugs is different from that of stack-based buffer overflows. Heap overflows have been prominently discovered as software security bugs. Unlike stack overflows, heap overflows are inconsistent and have varying exploitation techniques.

**Defending against Buffer Overflows**

* Develop programs by following secure coding practices and guidelines 
* Use the address space layout randomization \(ASLR\) technique, which randomly moves around the address space locations of the data region
* Validate arguments and minimize code that requires root privileges 
* Perform code review at the source-code level using static and dynamic code analyzers 
* Allow the compiler to add bounds to all the buffers 
* Implement automatic bound checking 
* Always protect the return pointer on the stack 
* Never allow execution of code outside the code space 
* Regularly patch applications and operating systems 
* Perform code inspection manually with a checklist to ensure that the code meets certain criteria
* Employ non-executable stacks, i.e., data execution prevention \(DEP\), which can mark the stack or memory regions as non-executable to prevent exploitation
* Implement code pointer integrity checking to detect whether a code pointer has been corrupted before it is dereferenced
* Scrutinize the code thoroughly to avoid possible errors by performing testing and debugging
* Perform automated and manual code auditing 
* Avoid using unsafe functions and use strncat instead of strcat and strncpy instead of strcpy
* Use the NX bit to mark certain areas of memory as executable and non-executable 
* Digitally sign the code before launching the program 
* Ensure that all the control transfers are encompassed by a trusted and approved code image
* Adopt deep packet inspection \(DPI\) for detecting remote exploitation attempts at the network perimeter using attack signatures
* Consider altering the rules at the operating-system level where the memory pages can hold executable data
* Use IDS solutions to detect behavior that simulates an attack

## 3. Escalating Privileges

* An attacker can gain access to the network using a non-admin user account and the next step would be to gain administrative privileges.
* The attacker performs a privilege escalation attack that takes advantage of design flaws, programming errors, bugs, and configuration oversights in the OS and software application to gain administrative access to the network and its associated applications.
* These privileges allow the attacker to view critical/sensitive information, delete files, or install malicious programs such as viruses, Trojans, or worms.

### Types of Privilege Escalation

* _Horizontal Privilege Escalation_: Refers to acquiring the same privileges that have already been granted, by assuming the identity of another user with the same privileges.
* _Vertical Privilege Escalation_: Refers to gaining higher privileges than those existing.

### Privilege Escalation Using DLL Hijacking \(Windows\)

* Most Windows applications do not use the fully qualified path when loading an external DLL library; instead, they first search the directory from which they have been loaded. Taking this as an advantage, if attackers can place a malicious DLL in the application directory, the application will execute the malicious DLL in place of the real DLL.
* For example, if an application program “.exe” needs library.dll \(usually in the Windows system directory\) to install the application, and fails to specify the library.dll path, Windows will search for the DLL in the directory from which the application was launched.
* If an attacker has already placed the DLL in the same directory as program.exe, then that malicious DLL will load instead of the real DLL, which allows the attacker to gain remote access to the target system.

Tools: [Robber](https://github.com/MojtabaTajik/Robber) & [PowerSploit](https://github.com/Exploit-install/PowerSploit).

### Privilege Escalation Using Dylib Hijacking \(OS X\)

* Similar to Windows, OS X is also vulnerable to dynamic library attacks. OS X provides several legitimate methods, such as setting the DYLD\_INSERT\_LIBRARIES environment variable, which are user specific. These methods force the loader to automatically load malicious libraries into a target running process.
* OS X allows the loading of weak dylibs \(dynamic libraries\) dynamically, which in turn allows an attacker to place a malicious dylib in the specified location. In many cases, the loader searches for dynamic libraries in multiple paths.
* This helps an attacker to inject a malicious dylib in one of the primary directories and simply load the malicious dylib at runtime. Attackers can utilize such methods to perform various malicious activities such as stealthy persistence, run-time process injection, bypassing security software, and bypassing Gatekeeper.

Tool: [Dylib Hijack Scanner](https://objective-see.com/products/dhs.html)

### Privilege Escalation Using Spectre and Meltdown Vulnerabilities \(AMD, ARM, Intel\)

* Spectre and Meltdown are vulnerabilities found in the design of modern processor chips from AMD, ARM, and Intel.
* The performance and CPU optimizations in the processors, such as branch prediction, out of order execution, caching, and speculative execution, lead to these vulnerabilities.
* Attackers exploit these vulnerabilities to gain unauthorized access and steal critical system information such as credentials and secret keys stored in the application’s memory, to escalate privileges.

#### Spectre Vulnerability

* Attackers may take advantage of this vulnerability to read adjacent memory locations of a process and access information for which he/she is not authorized.
* Using this vulnerability, an attacker can even read the kernel memory or perform a web-based attack using JavaScript.

The Spectre vulnerability is found in many modern processors, including Apple, AMD, ARM, Intel, Samsung, and Qualcomm processors. This vulnerability allows attackers to trick a processor into exploiting speculative execution to read restricted data. Modern processors implement speculative execution to predict the future to complete the execution faster. For example, if the chip identifies that a program includes multiple conditional statements, it will start executing and concluding all the possible outputs before the program does. Attackers may exploit this vulnerability in different ways:

* The processor is forced to accomplish a speculative execution of a read before bound checking is performed. Consequently, an attacker can access and read out-of-bounds memory locations.
* When executing conditional statements, for faster processing, the processors use branch prediction to pick a path to execute speculatively. Attackers may exploit this feature to force the processor to take an improper speculative decision and further access data out of range.

Attackers may use this vulnerability to read adjacent memory locations of a process and access information for which he/she is not authorized. This vulnerability helps attackers to extract confidential information, such as credentials stored in the browser, from that target process. In certain cases, using this vulnerability, an attacker can even read the kernel memory or perform a web-based attack using JavaScript.

#### Meltdown Vulnerability

* Attackers may take advantage of this vulnerability to escalate privileges by forcing an unprivileged process to read other adjacent memory locations such as kernel memory and physical memory.
* This leads to revealing critical system information such as credentials, private keys, etc.
* Meltdown vulnerability is found in all Intel and ARM processors deployed by Apple. This vulnerability allows attackers to trick a process into accessing out-of-bounds memory by exploiting CPU optimization mechanisms such as speculative execution. For example, an attacker requests to access an illegal memory location. He/she sends a second request to read a valid memory location conditionally. In this case, a processor using speculative execution will complete evaluating the result for both requests before checking the first request. When the processor checks that the first request is invalid, it rejects both requests after checking the privileges. Even though the processor rejects both the requests, the results of both the requests remain in the cache memory. Now the attacker sends multiple valid requests to access out-of-bounds memory locations. 
* Attackers may use this vulnerability to escalate privileges by forcing an unprivileged process to read other adjacent memory locations, such as kernel memory and physical memory. 
* This leads to critical system information such as credentials, private keys, etc. being revealed.

### Privilege Escalation by Exploiting Vulnerabilities

* Attackers exploit software vulnerabilities by taking advantage of programming flaws in a program, service, or within the operating system software or kernel, to execute malicious code.
* Exploiting software vulnerabilities allows the attacker to execute a command or binary on a target machine to gain higher privileges than those existing or to bypass security mechanisms.
* Attackers using these exploits can access privileged user accounts and credentials.
* Attackers search for an exploit based on the OS and software application on exploit sites such as [SecurityFocus](https://www.securityfocus.com) and [Exploit Database](https://www.exploit-db.com)

### Privilege Escalation using Named Pipe Impersonation \(Windows OS\)

* In the Windows operating system, named pipes provide legitimate communication between running processes.
* Attackers often exploit this technique to escalate privileges on the victim’s system to those of a user account having higher access privileges.
* Attackers use tools such as Metasploit to perform named pipe impersonation on a target host.
* Attackers use Metasploit commands such as getsystem to gain administrative-level privileges and extract password hashes of the admin/user accounts.

### Privilege Escalation by Exploiting Misconfigured Services

#### Unquoted Service Paths

* In Windows operating systems, when starting a service, the system attempts to find the location of the executable file to launch the service.
* The executable path is enclosed in quotation marks “”, so that the system can easily locate the application binary.
* Attackers exploit services with unquoted paths running under SYSTEM privileges to elevate their privilege.

#### Service Object Permissions

* Misconfigured service permissions may allow an attacker to modify or reconfigure the attributes associated with that service.
* By exploiting such services, attackers can even add new users to the local administrator group and then hijack the new account to elevate their privileges.

#### Unattended Installs

* Unattended install details such as configuration settings used during the installation process are stored in Unattend.xml file
* Unattend.xml file is stored in one of the following locations: 
  * C:\Windows\Panther 
  * C:\Windows\Panther\Unattend 
  * C:\Windows\System32 
  * C:\Windows\System32\sysprep\
* Attackers exploit information stored in Unattend.xml to escalate privileges 

### Pivoting and Relaying to Hack External Machines

#### Pivoting

Pivoting and relaying are the techniques used to find detailed information about the target network. These techniques are performed after successfully compromising a target system. The compromised system is used to penetrate the target network to access other systems and resources that are otherwise inaccessible from the attacking network.

![](../../.gitbook/assets/image%20%2836%29.png)

#### Relaying

In the pivoting technique, only the systems accessible through the compromised systems are exploited, whereas in the relaying technique, the resources accessible through the compromised system are explored or accessed. Using pivoting, attackers can open a remote shell on the target system tunneled through the initial shell on the compromised system. In relaying, resources present on the other systems are accessed through a tunneled shell session on the compromised system.

![](../../.gitbook/assets/image%20%2858%29.png)

### Other privilege escalation techniques

* **Access Token Manipulation**:
  * The Windows operating system uses access tokens to determine the security context of a process or thread.
  * Attackers can obtain access tokens of other users or generate spoofed tokens to escalate privileges and perform malicious activities by evading detection.
* **Application Shimming**:
  * The Windows Application Compatibility Framework called Shim is used to provide compatibility between the older and newer versions of the Windows operating system.
  * Shims like RedirectEXE, injectDLL, and GetProcAddress can be used by attackers to escalate privileges, install backdoors, disable Windows Defender, etc.
* **Filesystem Permissions Weakness**:
  * If the filesystem permissions of binaries are not properly set, an attacker can replace the target binary with a malicious file.
  * If the process that is executing this binary has higher level permissions, then the malicious binary also executes under higher level permissions.
* **Path Interception**:
  * Applications include many weaknesses and misconfigurations like unquoted paths, path environment variable misconfiguration, and search order hijacking that lead to path interception.
  * Path interception helps an attacker to maintain persistence on a system and escalate privileges.
* **Scheduled Task**:
  * The Windows Task Scheduler along with utilities such as ‘at’ and ‘schtasks’ can be used to schedule programs that can be executed at a specific date and time.
  * The attacker can use this technique to execute malicious programs at system startup, maintain persistence, perform remote execution, escalate privileges, etc.
* **Launch Daemon**:
  * Launchd is used in MacOS and OS X boot up to complete the system initialization process by loading parameters for each launch-on-demand system-level daemon.
  * Daemons have plists that are linked to executables that run at start up
  * The attacker can alter the launch daemon’s executable to maintain persistence or to escalate privileges.
* **Plist Modification**:
  * Plist files in MacOS and OS X describe when programs should execute, the executable file path, the program parameters, the required OS permissions, etc. 
  * Attackers alter plist files to execute malicious code on behalf of a legitimate user to escalate privileges.
* **Setuid and Setgid**:
  * In Linux and MacOS, if an application uses setuid or setgid then the application will execute with the privileges of the owning user or group.
  * An attacker can exploit the applications with the setuid or setgid flags to execute malicious code with elevated privileges.
* **Web Shell**:
  * A Web shell is a web-based script that allows access to a web server.
  * Attackers create web shells to inject malicious script on a web server to maintain persistent access and escalate privileges.
* **Abusing Sudo Rights**:
  * Sudo is a UNIX and Linux based system utility that permits users to run commands as a superuser or root using the security privileges of another user.
  * Attackers can overwrite the sudo configuration file, /etc/sudoers with their own malicious file to escalate privileges.
* **Abusing SUID and SGID Permissions**:
  * SUID and SGID are access permissions given to a program file in Unix based systems.
  * Attackers can use executable commands with SUID and SGID bits enabled to escalate privileges.
* **Kernel Exploits**:
  * Kernel exploits are referred to as the programs the can exploit vulnerabilities present in the kernel to execute arbitrary commands or code with higher privileges.
  * Attackers can attain superuser access or root-level access to the target system by exploiting kernel vulnerabilities.

### Privilege Escalation Tools

* [BeRoot](https://github.com) & [linpostexp](https://github.com)

### How to Defend Against Privilege Escalation

1. Restrict the interactive logon privileges
2. Run users and applications with the lowest privileges
3. Implement multi-factor authentication and authorization
4. Run services as unprivileged accounts
5. Implement a privilege separation methodology to limit the scope of programming errors and bugs
6. Use an encryption technique to protect sensitive data
7. Reduce the amount of code that runs with a particular privilege  
8. Perform debugging using bounds checkers and stress tests 
9. Test the system for application coding errors and bugs thoroughly
10. Regularly patch and update the kernel 
11. Change the User Account Control settings to “Always Notify”
12. Restrict users from writing files to the search paths for applications
13. Continuously monitor file system permissions using auditing tools
14. Reduce the privileges of users and groups so that only legitimate administrators can make service changes
15. Use whitelisting tools to identify and block malicious software
16. Use fully qualified paths in all Windows applications
17. Ensure that all executables are placed in write-protected directories
18. In Mac operating systems, make plist files read-only
19. Block unwanted system utilities or software that may be used to schedule tasks
20. Regularly patch and update the web servers  

### Tools

#### Tools for Defending against DLL and Dylib Hijacking

Cybersecurity professionals can use tools such as Dependency Walker, DLL Hijack Audit Kit, and DLLSpy to detect and prevent privilege escalation using DLL hijacking. In addition, tools such as Dylib Hijack Scanner help security professionals to detect and prevent privilege escalation using Dylib hijacking on OS X systems. These tools help security professionals to monitor system files for modifying, moving, renaming, or replacing DLLs or dylibs in the systems.

* [Dependency Walker](http://www.dependencywalker.com) & [Dylib Hijack Scanner](https://objective-see.com/products/dhs.html)

#### Tools for Detecting Spectre and Meltdown Vulnerabilities

Security professionals can use tools such as InSpectre, Spectre & Meltdown Checker, INTEL-SA-00075 Detection and Mitigation Tool, etc. to detect Spectre and Meltdown vulnerabilities that exist in the system hardware. Detection of these vulnerabilities before exploitation helps security professionals to install the necessary OS and firmware patches to defend against such exploitation.

* [InSpectre](https://www.grc.com) & \[Spectre & Meltdown Checker\]

## 4. Maintaining Access

### Executing applications

* Once attackers gain higher privileges in the target system by trying various privilege escalation attempts, they may attempt to execute a malicious application by exploiting a vulnerability to execute arbitrary code. By executing malicious applications, the attacker can steal personal information, gain unauthorized access to system resources, crack passwords, capture screenshots, install a backdoor for maintaining easy access, etc.
* Attackers execute malicious applications at this stage in a process called “owning” the system. Once they acquire administrative privileges, they will execute applications. Attackers may even try to do so remotely on the victim’s machine to gather the same information as above.

The malicious programs attackers execute on target systems can be:

* **Backdoors**: Program designed to deny or disrupt the operation, gather information that leads to exploitation or loss of privacy, or gain unauthorized access to system resources.
* **Crackers**: Components of software or programs designed for cracking a code or passwords.
* **Keyloggers**: These can be hardware or software. In either case, the objective is to record each keystroke made on the computer keyboard.
* **Spyware**: Spy software may capture screenshots and send them to a specified location defined by the hacker. For this purpose, attackers have to maintain access to victims’ computers. After deriving all the requisite information from the victim’s computer, the attacker installs several backdoors to maintain easy access to it in the future.

### Remote Code Execution Techniques

* Exploitation for Client Execution 
  * Web-Browser-Based Exploitation
  * Office-Applications-Based Exploitation
  * Third-Party Applications-Based Exploitation
* Scheduled Task
* Service Execution
* Windows Management Instrumentation \(WMI\)
* Windows Remote Management \(WinRM\)

Tools: [RemoteExec](https://www.isdecisions.com) or

* [Pupy](https://github.com)
* [PDQ Deploy](https://www.pdq.com)
* [Dameware Remote Support](https://www.dameware.com)
* [ManageEngine Desktop Central](https://www.manageengine.com)
* [PsExec](https://docs.microsoft.com)

#### Keylogger

* Keystroke loggers are programs or hardware devices that monitor each keystroke as the user types on a keyboard, logs onto a file, or transmits them to a remote location 
* Legitimate applications for keyloggers include in office and industrial settings to monitor employees’ computer activities and in the home environment where parents can monitor and spy on children’s activity
* It allows the attacker to gather confidential information about the victim such as email ID, passwords, banking details, chat room activity, IRC, and instant messages 
* Physical keyloggers are placed between the keyboard hardware and the operating syste

A keylogger can:

* Record every keystroke typed on the user’s keyboard 
* Capture screenshots at regular intervals, showing user activity such as typed characters or clicked mouse buttons
* Track the activities of users by logging Window titles, names of launched applications, and other information
* Monitor the online activity of users by recording addresses of the websites visited and with keywords entered
* Record all login names, bank and credit card numbers, and passwords, including hidden passwords or data displayed in asterisks or blank spaces
* Record online chat conversations 
* Make unauthorized copies of both outgoing and incoming email messages

**Types of keystroke loggers**

* **Hardware Keystroke Loggers**
  * _PC/BIOS Embedded_: BIOS-level firmware that is responsible for managing keyboard actions can be modified in such a way that it captures the keystrokes that are typed. It requires physical and/or admin-level access to the target computer.
  * _Keylogger Keyboard_: If the hardware circuit is attached to the keyboard cable connector, it can capture the keystrokes. It records all the keyboard strokes to its own internal memory that can be accessed later. The main advantage of a hardware keylogger over a software keylogger is that it is not OS dependent and, hence, will not interfere with any applications running on the target computer, and it is impossible to discover hardware keyloggers by using any anti-keylogger software.
  * _External Keylogger_: External keyloggers are attached between a standard PC keyboard and a computer. They record each keystroke. External keyloggers do not need any software and work with any PC. You can attach one to your target computer and monitor the recorded information on your PC to look through the keystrokes.
    * _PS/2 and USB Keylogger_: This is completely transparent to computer operation and requires no software or drivers for functionality. It records all the keystrokes typed by the user on the computer keyboard, and stores data such as emails, chat records, applications used, IMs, etc.
    * _Acoustic/CAM Keylogger_: Acoustic keyloggers work on the principle of converting electromagnetic sound waves into data. They employ either a capturing receiver capable of converting the electromagnetic sounds into the keystroke data, or a CAM \(camera\) capable of recording screenshots of the keyboard.
    * _Bluetooth Keylogger_: This requires physical access to the target computer only once, at the time of installation. After installation on the target PC, it stores all the keystrokes and you can retrieve the keystroke information in real-time by connecting via a Bluetooth device.
* **Software Keystroke Loggers**: These loggers are the software installed remotely via a network or email attachment in a target system for recording all the keystrokes. Here, the logged information is stored as a log file on a computer hard drive. The logger sends keystroke logs to the attacker using email protocols. Software loggers can often obtain additional data as well, because they do not have the limitation of physical memory allocation, as do hardware keystroke loggers. 
  * _Application Keylogger_: An application keylogger allows you to observe everything the user types in his/her emails, chats, and other applications, including passwords. It is even possible to trace records of Internet activity. This is an invisible keylogger to track and record everything happening within the entire network.
  * _Kernel/Rootkit/Device Driver Keylogger_: The rootkit-based keylogger is a forged Windows device driver that records all keystrokes. This keylogger hides from the system and is undetectable, even with standard or dedicated tools. This kind of keylogger usually acts as a device driver. The device driver keylogger replaces the existing I/O driver with the embedded keylogging functionality. This keylogger saves all the keystrokes performed on the computer into a hidden logon file, and then sends the file to the destination through the Internet.
  * _Hypervisor-Based Keylogger_: A hypervisor-based keylogger works within a malware hypervisor operating on the OS.
  * _Form-Grabbing-Based Keylogger_: A form-grabbing-based keylogger records web form data and then submits it over the Internet, after bypassing HTTPS encryption. Form-grabbing-based keyloggers log web form inputs by recording web browsing on the “submit event” function.
  * _JavaScript-Based Keylogger_: Attackers inject malicious JavaScript tags on the web page of a compromised website to listen to key events such as onKeyUp\(\) and onKeyDown\(\). Attackers use various techniques such as man-in-the-browser, cross-site scripting, etc. to inject malicious script.
  * _Memory-Injection-Based Keylogger_: Memory-injection-based keyloggers modify the memory tables associated with the web browser and system functions to log keystrokes. Attackers also use this technique to bypass UAC in Windows systems.

### Spyware

* Spyware is a stealthy program that records the user's interaction with the computer and the Internet without the user's knowledge and sends the information to the remote attackers.
* Spyware hides its process, files, and other objects in order to avoid detection and removal.
* It is like a Trojan horse, which is usually bundled as a hidden component of freeware programs that can be available on the Internet for download.
* It allows the attacker to gather information about a victim or organization such as email addresses, user logins, passwords, credit card numbers, and banking credentials.

Propagation:

* Drive-by download 
* Masquerading as anti-spyware
* Web browser vulnerability exploits
* Piggybacked software installation 
* Browser add-ons
* Cookies 

### Rootkits

Rootkits are software programs designed to gain access to a computer without being detected. They are malware that help attackers gain unauthorized access to a remote system and perform malicious activities. The goal of a rootkit is to gain root privileges to a system. By logging in as the root user of a system, an attacker can perform various tasks such as installing software or deleting files. It works by exploiting the vulnerabilities in the OS and its applications. It builds a backdoor login process in the OS via which the attacker can evade the standard login process.

* Rootkits are programs that hide their presence as well as attacker’s malicious activities, granting them full access to the server or host at that time, and in the future.
* Rootkits replace certain operating system calls and utilities with their own modified versions of those routines that, in turn, undermine the security of the target system causing malicious functions to be executed.
* A typical rootkit comprises of backdoor programs, DDoS programs, packet sniffers, log-wiping utilities, IRC bots, etc.

The attacker places a rootkit by:

* Scanning for vulnerable computers and servers on the web
* Wrapping it in a special package like a game
* Installing it on public computers or corporate computers through social engineering
* Launching a zero-day attack \(privilege escalation, buffer overflow, Windows kernel exploitation, etc.\)

Objectives of a rootkit:

* To root the host system and gain remote backdoor access 
* To mask attacker tracks and presence of malicious applications or processes 
* To gather sensitive data, network traffic, etc. from the system to which attackers might be restricted or possess no access 
* To store other malicious programs on the system and act as a server resource for bot updates

#### How a Rootkit Works

* **System hooking**: It is the process of changing and replacing the original function pointer with a pointer provided by the rootkit in stealth mode. Inline function hooking is a technique in which a rootkit changes some of the bytes of a function inside the core system DLLs \(kernel32.dll and ntdll.dll\), placing an instruction so that any process calls hit the rootkit first.
* **Direct kernel object manipulation \(DKOM\)**: rootkits can locate and manipulate the “system” process in kernel memory structures and patch it. This can also hide processes and ports, change privileges, and misguide the Windows event viewer without any problem by manipulating the list of active processes of the OS, thereby altering data inside the process identifier structures. It can obtain read/write access to the \Device\Physical Memory object. It hides a process by unlinking it from the process list.

#### Popular Rootkits

[LoJax](https://www.welivesecurity.com), [Scanos](https://www.bitdefender.com), [Horse Pill](http://www.pill.horse), [Necurs](https://www.f-secure.com)

#### NTFS Data Stream

NTFS is a filesystem that stores a file with the help of two data streams, called NTFS data streams, along with the file attributes. The first data stream stores the security descriptor for the file to be stored, such as permissions, and the second stores the data within a file. ADSs are another type of named data stream that can be present within each file.

An ADS refers to any type of data attached to a file, but not in the file on an NTFS system. The master file table of the partition contains a list of all the data streams that a file contains and their physical locations on the disk. Therefore, ADSs are not present in the file but attached to it through the file table. NTFS ADS is a Windows hidden stream that contains metadata for the file, such as attributes, word count, author name, and access and modification times of the files.

ADSs can fork data into existing files without changing or altering their functionality, size, or display to file-browsing utilities. They allow an attacker to inject malicious code into files on an accessible system and execute them without being detected by the user. ADSs provide attackers with a method of hiding rootkits or hacker tools on a breached system and allow a user to execute them while hiding from the system administrator.

Hidden files:

```text
> notepad eric.txt
> notepad eric.txt:hidden-file
```

Hide malware:

```text
type calc.exe > eric.txt:calc.exe
start c:\<path>\eric.txt:calc.exe
# or
mklink backdoor.exe Readme.txt:Trojan.exe
```

In task manager:

```text
eric.txt:calc.exe
```

**Tools to detect NTFS Streams**

Some additional examples of NTFS stream detectors are listed as follows:

* [Stream Detector](https://www.novirusthanks.org) 
* [GMER](http://www.gmer.net) 
* [ADS Manager](https://dmitrybrant.com) 
* [ADS Scanner](https://www.pointstone.com) 
* [Streams](https://docs.microsoft.com)

### Steganography

* Steganography is a technique of hiding a secret message within an ordinary message and extracting it at the destination to maintain confidentiality of data.
* Utilizing a graphic image as a cover is the most popular method to conceal the data in files.
* The attacker can use steganography to hide messages such as a list of the compromised servers, source code for the hacking tool, or plans for future attacks.

For example, attackers can hide a keylogger inside a legitimate image; thus, when the victim clicks on the image, the keylogger captures the victim’s keystrokes.

#### Classification of Steganography

* Based on its technique, steganography can be classified into two areas: technical and linguistic. 
* In technical steganography, a message is hidden using scientific methods, whereas in linguistic steganography, it is hidden in a carrier, which is the medium used to communicate or transfer messages or files. 
* This medium comprises of the hidden message, carrier, and steganography key.
* Technical Steganography
  * Invisible Ink
  * Microdots
  * Computer-Based Methods
    * Substitution Techniques
    * Transform Domain Techniques
    * Spread Spectrum Techniques
    * Statistical Techniques
    * Distortion Techniques
    * Cover Generation Techniques
* Linguistic Steganography
  * Semagrams
    * Visual Semagrams
    * Text Semagrams
  * Open Codes 
    * Jargon Codes
    * Covered Ciphers
      * Null ciphers
      * Grille ciphers

#### Types of Steganography based on Cover Medium

* Image Steganography 
* Document Steganography 
* Folder Steganography 
* Video Steganography 
* Audio Steganography 
* White Space Steganography
* Web Steganography 
* Spam/Email Steganography 
* DVD-ROM Steganography 
* Natural Text Steganography 
* Hidden OS Steganography 
* C++ Source-Code Steganography

#### Whitespace Steganography

Whitespace steganography is used to conceal messages in ASCII text by adding whitespaces to the ends of the lines. Because spaces and tabs are generally not visible in text viewers, the message is effectively hidden from casual observers. If built-in encryption is used, the message cannot be read even if it is detected.

Tool: [Snow](http://www.darkside.com.au)

#### Image Steganography

* In image steganography, the information is hidden in image files of different formats such as .PNG, .JPG, and .BMP
* Image steganography tools replace redundant bits of image data with the message in such a way that the effect cannot be detected by the human eye

**Image File Steganography Techniques**

**Least Significant Bit Insertion**

* The binary data of the message is broken, which is then inserted into the LSB of each pixel in the image file in a deterministic sequence.
* Modifying the LSB does not result in a visible difference because the net change is minimal and can be indiscernible to the human eye. Thus, its detection is difficult.

Hiding the data:

* The stego tool makes a copy of an image palette with the help of the red, green, and blue \(RGB\) model.
* Each pixel of the 8-bit binary number LSB is substituted with one bit of the hidden message.
* A new RGB color in the copied palette is produced.
* With the new RGB color, the pixel is changed to an 8-bit binary number.

**Masking and Filtering**

Masking and filtering techniques hide data using techniques such as watermarks on an actual paper; this can be done by modifying the luminance of some image parts.

Masking allows you to conceal secret data by placing the data in an image file. You can use masking and filtering techniques on 24-bit-per-pixel and grayscale images. To hide secret messages, you must adjust the luminosity and opacity of the image. If the change in luminance is insignificant, then people other than the intended recipients will fail to notice that the image contains a hidden message.

This technique can be easily applied as the image remains undisturbed. In most cases, users perform masking of JPEG images.

Lossy JPEG images are relatively immune to cropping and compression image operations. Hence, you can hide your information in lossy JPEG images, often using the masking technique. If a message hides in significant areas of the picture, the steganography image encoded with a marking degrades at a lower rate under JPEG compression.

Masking techniques can be detected with simple statistical analysis but are resistant to lossy compression and image cropping. The information is not hidden in the noise but in the significant areas of the image.

**Algorithms and Transformation**

* Hide data in mathematical functions that are used in compression algorithms.
* The data are embedded in the cover image by changing the coefficients of a transform of an image.

The algorithms and transformation technique involves hiding secret information during image compression. In this technique, the user conceals the information by applying various compression algorithms and transformation functions. A compression algorithm and transformation uses a mathematical function to hide the coefficient of the least bit during image compression. The data are embedded in the cover image by changing the coefficients of a transformation of an image. Generally, JPEG images are the most suitable for compression, as they can function at different compression levels. This technique provides a high level of invisibility of secret data. JPEG images use a discrete cosine transform to achieve compression.

There are three types of transformation used in the compression algorithm:

* Fast Fourier transformation 
* Discrete cosine transformation 
* Wavelet transformation

**Image Steganography Tools**

* [OpenStego](https://www.openstego.com)
* [QuickStego](http://quickcrypto.com)
* [SSuite Picsel](https://www.ssuitesoft.com)
* [CryptaPix](https://www.briggsoft.com)
* [gifshuffle](http://www.darkside.com.au)
* [PHP-Class Stream Steganography](https://www.phpclasses.org)

#### Document Steganography

* Document steganography is the technique of hiding secret messages transferred in the form of documents.
* It includes the addition of white spaces and tabs at the end of the lines.

**Document Steganography Tools**

* [StegoStick](https://sourceforge.net)
* \[StegJ\]
* \[Office XML\]
* [SNOW](http://www.darkside.com.au)
* \[Data Stash\]
* \[Texto\]

#### Video Steganography

* Video steganography refers to hiding secret information in a carrier video file.
* In video steganography, the information is hidden in video files of different formats such as .AVI, .MPG4, and .WMV.
* Discrete Cosine Transform \(DCT\) manipulation is used to add secret data at the time of the transformation process of the video.

**Video Steganography Tools**

* [OmniHide Pro](http://omnihide.com)
* \[RT Steganography\]
* [StegoStick](https://sourceforge.net)
* \[OpenPuff\]
* \[MSU StegoVideo\]

#### Audio Steganography

* Audio steganography refers to hiding secret information in audio files such as .MP3, .RM, and .WAV
* Information can be hidden in an audio file using LSB or using frequencies that are inaudible to the human ear \(&gt;20,000 Hz\).
* Some of the audio steganography methods are echo data hiding, spread spectrum method, LSB coding, tone insertion, phase encoding, etc.

**Audio Steganography Tools**

* \[BitCrypt\]
* [StegoStick](https://sourceforge.net)
* \[MP3Stego\]
* [QuickCrypto](http://www.quickcrypto.com)
* \[spectrology\]

#### Folder Steganography

In folder steganography, files are hidden and encrypted within a folder and do not appear to normal Windows applications, including Windows Explorer.

#### Folder Steganography Tools

Attackers use folder steganography tools to hide and secure folders and hide their confidential data. These tools secure folders using different encryption techniques.

* [GiliSoft File Lock Pro](http://www.gilisoft.com)
* [Folder Lock](http://www.newsoftwares.net)
* [Hide Folders 5](https://fspro.net)
* [Invisible Secrets 4](http://www.invisiblesecrets.com)
* [Max Folder Secure](https://maxpcsecure.com)
* [QuickCrypto](http://www.quickcrypto.com)

#### Spam/Email Steganography

Spam/email steganography refers to the technique of sending secret messages by embedding them and hiding the embedded data in spam emails. Various military agencies supposedly use this technique with the help of steganography algorithms. You can use the Spam Mimic tool to hide a secret message in an email.

* Spam/email steganography refers to the technique of sending secret messages by hiding them in spam/email messages.
* Spam emails help to communicate secretly by embedding the secret messages in some way and hiding the embedded data in the spam emails.
* Spam Mimic is a spam/email steganography tool that encodes the secret message into an innocent-looking spam email.

**Spam/Email Steganography Tool**

[Spam Mimic](http://www.spammimic.com)

#### Steganography Tools for Mobile Phones

* [Steganography Master](https://play.google.com)
* [Stegais](http://stegais.com)

Some additional steganography tools for mobile phones as follows:

* [SPY PIX](https://www.juicybitssoftware.com)
* [Pixelknot: Hidden Messages](https://guardianproject.info)
* [Pocket Stego](https://www.talixa.com)
* [Steganography Image](https://play.google.com)
* [Steganography](https://github.com)

#### Steganalysis

* Reverse Process of Steganography: 
  * Steganalysis is the art of discovering and rendering covert messages using steganography
  * It detects hidden messages embedded in images, text, audio, and video carrier mediums
* Challenges of Steganalysis:
  * Suspect information stream may or may not have encoded hidden data 
  * Efficient and accurate detection of hidden content within digital images is difficult
  * The message could be encrypted before being inserted into a file or signal 
  * Some of the suspect signals or files may have irrelevant data or noise encoded into them

Steganalysis has two aspects: the detection and distortion of messages. In the detection phase, the analyst observes the relationships between the steganography tools, stego-media, cover, and message. In the distortion phase, the analyst manipulates the stego-media to extract the embedded message and decides whether it is useless and should be removed altogether.

The first step in steganalysis is to discover a suspicious image that may be harboring a message. This is an attack on the hidden information. There are two other types of attacks against steganography: message and chosen-message attacks. In the former, the steganalyst has a known hidden message in the corresponding stego-image. The steganalyst determines patterns that arise from hiding and detecting this message. The steganalyst creates a message using a known stego tool and analyzes the differences in patterns. In a chosen-message attack, the attacker creates steganography media using the known message and steganography tool \(or algorithm\).

**Steganalysis Methods/Attacks on Steganography**

Steganography attacks work according to the type of information available for the steganalyst to perform steganalysis on. This information may include a hidden message, carrier \(cover\) medium, stego-object, steganography tools, or algorithms used for hiding information. Thus, the classification of steganalysis includes the following types of attacks: stego-only, known-stego, known-message, known-cover, chosen-message, chosen-stego, chi-square, distinguishing statistical, and blind classifier.

* Stego-only attack: In a stego-only attack, the steganalyst or attacker does not have access to any information except the stego-medium or stego-object. In this attack, the steganalyst must try every possible steganography algorithm and related attack to recover the hidden information.
* Known-stego attack: This attack allows the attacker to know the steganography algorithm as well as the original and stego-object. The attacker can extract the hidden information with the information at hand.
* Known-message attack: The known-message attack presumes that the message and the stego-medium are available. Using this attack, one can detect the technique used to hide the message.
* Known-cover attack: Attackers use the known-cover attack when they know both the stego-object and the

  original cover medium. This will enable a comparison between both mediums to detect changes in the format of the medium and find the hidden message.

* Chosen-message attack: The steganalyst uses a known message to generate a stego-object by using various steganography tools to find the steganography algorithm used to hide the information. The goal in this attack is to determine patterns in the stego-object that may point to the use of specific steganography tools or algorithms.
* Chosen-stego attack: The chosen-stego attack takes place when the steganalyst knows both the stego-object and steganography tool or algorithm used to hide the message.
* Chi-square attack: The chi-square method is based on probability analysis to test whether a given stego-object and the original data are the same or not. If the difference between both is nearly zero, then no data are embedded; otherwise, the stego-object includes embedded data inside.
* Distinguishing statistical attack: In the distinguishing statistical method, the steganalyst or attacker analyzes the embedded algorithm used to detect distinguishing statistical changes, along with the length of the embedded data.
* Blind classifier attack: In the blind classifier method, a blind detector is fed with the original or unmodified data to learn the appearance of the original data from multiple perspectives. The output of the blind detector is used to train the classifier to detect differences between the stego-object and original data.

**Detecting Steganography**

**Text File**:

* For text files, the alterations are made to the character positions to hide the data.
* The alterations are detected by looking for text patterns or disturbances, language used, and an unusual amount of blank spaces.

**Image File**:

* The hidden data in an image can be detected by determining changes in size, file format, the last modified timestamp, and the color palette pointing to the existence of the hidden data.
* The statistical analysis method is used for image scanning.

**Audio File**:

* The statistical analysis method can be used for detecting audio steganography as it involves LSB - modifications.
* The inaudible frequencies can be scanned for hidden information.
* Any odd distortions and patterns show the existence of the secret data.

**Video File**:

* Detection of the secret data in video files includes a combination of methods used in image and audio files.

**Steganography Detection Tools**

* [zsteg](https://github.com)

Some examples of steganography detection tools are as follows:

* [StegoVeritas](https://github.com)
* [Stegextract](https://github.com)
* [StegoHuntTM](https://www.wetstonetech.com)
* [Steganography Studio](http://stegstudio.sourceforge.net)
* [Virtual Steganographic Laboratory \(VSL\)](http://vsl.sourceforge.net)

## 5. Clearing Logs

The next step involves removing any resultant traces/tracks in the system.

### Covering tracks

Once intruders have successfully gained administrator access on a system, they will try to cover their tracks to avoid detection.

Attackers must make the system appear as it did before access was gained and a backdoor was established. This allows them to change any file attributes back to their original state. The information listed, such as file size and date, is just attribute information contained in the file

Attackers may not wish to delete an entire log to cover their tracks, as doing so may require admin privileges. If attackers can delete only attack event logs, they will still be able to escape detection.

The attacker can manipulate the log files with the help of:

* SECEVENT.EVT \(security\): failed logins, accessing files without privileges 
* SYSEVENT.EVT \(system\): driver failure, things not operating correctly 
* APPEVENT.EVT \(applications\) 

### Techniques Used for Covering Tracks

The main activities that an attacker performs toward removing his/her traces on a computer are as follows:

* **Disabling Auditing**: An attacker disables auditing features of the target system. 
* **Clearing Logs**: An attacker clears/deletes the system log entries corresponding to his/her activities.
* **Manipulating Logs**: An attacker manipulates logs in such a way that he/she will not be caught in legal action.
* **Covering Tracks on the Network**: An attacker uses techniques such as reverse HTTP shells, reverse ICMP tunnels, DNS tunneling, and TCP parameters to cover tracks on the network.
* **Covering Tracks on the OS**: An attacker uses NTFS streams to hide and cover malicious files in the target system.
* **Deleting Files**: An attacker uses a command-line tool such as Cipher.exe to delete the data and prevent recovery of that data in future.
* **Disabling Windows Functionality**: An attacker disables Windows functionality such as last access timestamp, hibernation, virtual memory, system restore points, etc. to cover tracks

### Disabling Auditing: Auditpol

* Intruders disable auditing immediately after gaining administrator privileges.
* Windows records certain events to the event log \(or associated syslog\). The log can be set to send alerts \(email, SMS, etc.\) to the system administrator. Therefore, the attacker will want to know the auditing status of the system he/she is trying to compromise before proceeding with his/her plans. 
* `Auditpol.exe` is the command-line utility tool to change audit security settings at the category and sub-category levels. Attackers can use AuditPol to enable or disable security auditing on local or remote systems, and to adjust the audit criteria for different categories of security events.

Enabling system auditing:

```text
C:\>auditpol /set /category:”system”,”account logon” /success:enable /failure:enable
```

Disabling system auditing:

```text
C:\>auditpol /set /category:”system”,”account logon” /success:disable /failure:disable
```

This will make changes in the various logs that might register the attacker’s actions. He/she can choose to hide the registry keys changed later on.

Attackers can use AuditPol to view defined auditing settings on the target computer, running the following command at the command prompt:

```text
auditpol /get /category:*
```

### Clearing Logs

`Clear_Event_Viewer_Logs.bat` is a utility that can be used to wipe out the logs of the target system. This utility can be run through command prompt, PowerShell, and using a BAT file to delete security, system, and application logs. Attackers might use this utility to wipe out the logs as one method of covering their tracks on the target system.

#### Manually Clearing Event Log

**For Windows**

* Navigate to Start 
  * Control Panel 
  * System and Security 
  * Administrative Tools 
  * double click Event Viewer
* Delete the all the log entries logged while compromising the system

**For Linux**

* Navigate to /var/log directory on the Linux system 
* Open the plain text file containing log messages with text editor /var/log/messages 
* Delete all the log entries logged while compromising the system

#### Ways to Clear Online Tracks

Remove the Most Recently Used \(MRU\), delete cookies, clear the cache, turn off AutoComplete, and clear the Toolbar data from the browsers.

**From the Privacy Settings in Windows 10**:

* Right-click on the Start button, choose Settings, and click on “Personalization”.
* In Personalization, click Start from the left pane and Turn Off both “Show most used apps” and “Show recently opened items in Jump Lists on Start or the taskbar”.

**From the Registry in Windows 10**:

* Open the Registry Editor and navigate to HKEY\_LOCAL\_MACHINE\SOFTWARE Microsoft\Windows\CurrentVersion\

  Explorer and then remove the key for “RecentDocs”.

* Delete all the values except "\(Default\)".

**What can attackers do to clear their online tracks?**:

* Use private browsing 
* Delete history in the address field  
* Disable stored history  
* Delete private data  
* Clear cookies on exit  
* Clear cache on exit  
* Delete downloads  
* Disable password manager
* Clear data in the password manager 
* Delete saved sessions 
* Delete user JavaScript 
* Set up multiple users 
* Remove Most Recently Used \(MRU\) 
* Clear toolbar data from browsers 
* Turn off AutoComplete

#### Covering BASH Shell Tracks

* The BASH is an sh-compatible shell that stores command history in a file called bash\_history 
* You can view the saved command history using the more ~/.bash\_history comma

Attackers use the following commands to clear the saved command history tracks:

**Disabling history**: This command disables the Bash shell from saving history. HISTSIZE determines the number of commands to be saved, which is set to 0. After executing this command, attackers lose their privilege to review the previously used commands.

```text
export HISTSIZE=0
```

**Clearing the history**:

This command is useful in clearing the stored history. It is an effective alternative to disabling the history command as, in this command, an attacker has the convenience of rewriting or reviewing the earlier used commands:

```text
history –c
```

This command only deletes the history of the current shell, whereas the command history of other shells remains unaffected:

```text
history -w
```

**Clearing the user’s complete history**: This command deletes the complete command history of the current and all other shells and exits the shell.

```text
cat /dev/null > ~.bash_history && history –c && exit
```

**Shredding the history**:

This command shreds the history file and renders its contents unreadable. It is useful when an investigator locates the file, but owing to this command, becomes unable to read any content in the history file:

```text
shred ~/.bash_history
```

This command first shreds the history file, then deletes the file, and finally clears all the evidence of its usage:

```text
shred ~/.bash_history&& cat /dev/null > .bash_history && history -c && exit
```

#### Covering Tracks on a Network

**Using Reverse HTTP Shells**

* The attacker installs a reverse HTTP shell on the victim’s machine, which is programmed in such a way that it would ask for commands from an external master who controls the reverse HTTP shell.
* The victim here will act as a web client who is executing HTTP GET commands, whereas the attacker behaves like a web server and responds to the requests.
* This type of traffic is considered as normal traffic by an organization’s network perimeter security controls like DMZ, firewall, etc.

**Using Reverse ICMP Tunnels**

* The attacker uses an ICMP tunneling technique to use ICMP echo and ICMP reply packets as a carrier of the TCP payload, to access or control a system stealthily.
* The victim‘s system is triggered to encapsulate the TCP payload in an ICMP echo packet that is forwarded to the proxy server.
* Organizations have security mechanisms that only check incoming ICMP packets but not outgoing ICMP packets, therefore attackers can easily bypass the firewall.

**Using DNS Tunneling**

* Attackers can use DNS tunneling to encode malicious content or data of other programs within DNS queries and replies.
* DNS tunneling creates a back channel to access a remote server and applications.
* Attackers can make use of this back channel to exfiltrate stolen, confidential, or sensitive information from the server.

**Using TCP Parameters**

* TCP parameters can be used by the attacker to distribute the payload and to create covert channels
* TCP fields where data can be hidden are as follows: 
  * IP Identification field 
  * TCP acknowledgement number 
  * TCP initial sequence number

#### Covering Tracks on an OS

**Windows**

* NTFS has a feature known as Alternate Data Streams that allows attackers to hide a file behind normal files
* Given below are some steps to hide a file using NTFS: 
  * Open the command prompt with an elevated privilege
  * Type the command “type C:\SecretFile.txt &gt; C:\LegitFile.txt:SecretFile.txt” \(here, the file is kept in C drive where the SecretFile.txt file is hidden inside LegitFile.txt file\)
  * To view the hidden file, type “more &lt; C:\SecretFile.txt” \(for this you need to know the hidden file name\)

**UNIX**

* Files in UNIX can be hidden just by appending a dot \(.\) in front of a file name
* Attackers can use this feature to edit the log files to cover their tracks
* Attackers can use the “export HISTSIZE=0” command to delete the command history and the specific command they used to hide log files

#### Delete Files using Cipher.exe \(Windows\)

`Cipher.exe` is an in-built Windows command-line tool that can be used to securely delete data by overwriting it to avoid their recovery in the future.

This command also assists in encrypting and decrypting data in NTFS partitions.

When an attacker creates and encrypts a malicious text file, at the time of the encryption process, a backup file is created. Therefore, if the encryption process is interrupted, the backup file can be used to recover the data. After the completion of the encryption process, the backup file is deleted, but this deleted file can be recovered using data recovery software and can then be used by security personnel for investigation.

To avoid data recovery and cover their tracks, attackers use the Cipher.exe tool to overwrite the deleted files, first with all zeroes \(0 × 00\), second with all 255s \(0 × FF\), and then finally with random numbers.

To overwrite deleted files in a specific folder:

```text
cipher /w:<drive letter>:\<folder name>
```

To overwrite all the deleted files in the given drive:

```text
cipher /w:<drive letter>
```

### Track-Covering Tools

Track-covering tools help the attacker to clean up all the tracks of computer and Internet activities on the target computer. Track-covering tools free cache space, delete cookies, clear Internet history and shared temporary files, delete logs, and discard junk.

* [CCleaner](https://www.ccleaner.com)
* [DBAN](https://dban.org) 
* [Privacy Eraser](https://www.cybertronsoft.com) 
* [Wipe](https://privacyroot.com) 
* [BleachBit](https://www.bleachbit.org) 
* \[ClearProg\]\([http://www.clearprog.d](http://www.clearprog.d)

#### Defending against Covering Tracks

The various countermeasures against covering tracks are listed as follows:

* Activate logging functionality on all critical systems 
* Conduct a periodic audit on IT systems to ensure logging functionality is in accordance with the security policy
* Ensure new events do not overwrite old entries in the log files when the storage limit is exceeded
* Configure appropriate and minimal permissions necessary to read and write log files stored on critical systems
* Maintain a separate logging server on the DMZ, so that all the critical servers, such as the DNS server, mail server, web server, etc., forward and store their logs on that server
* Regularly update and patch OSs, applications, and firmware 
* Close all unused open ports and services 
* Encrypt the log files stored on the system, so that altering them is not possible without an appropriate decryption key
* Set log files to “append only” mode to prevent unauthorized deletion of log entries  Periodically back up the log files to unalterable media

## Module Summary

In this module, we have discussed the following:

* CEH hacking methodology along with various phases involved in system hacking such as gaining access, escalating privileges, maintaining access, and covering tracks
* Various techniques and tools attackers employ to gain access to the target system - Various tools and techniques attackers use to escalate their privileges
* Various techniques such as the execution of malicious applications \(Keyloggers, spywares, rootkit, etc.\), NTFS stream manipulation, steganography, and steganalysis that attackers use to maintain remote access to the target system and steal critical information
* Various techniques attackers employ to erase all evidence of compromise from the target system
* Various countermeasures that should be employed to protect the system from hacking attempts, along with various software protection tools

In the next module, we will discuss in detail about various malware threats.

