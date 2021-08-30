---
description: >-
  Learn the security mechanisms implemented in Wi-Fi architectures as well as
  their weaknesses and how to exploit them.
---

# Wi-Fi Security

{% hint style="danger" %}
**This document is still in progress...** 
{% endhint %}

## Prerequisites

While normal pentesting operations can be performed with standard hardware, when it ocmes to Wi-Fi pentesting, you must choose your equipment carefully.

### Hardware

Almost all new notebooks come equipped with a WNIC \(Wireless Network Interface Controller\) that enables Wi-Fi communications.

These controllers use the common Mini PCI \(or more recently, Mini PCI-Express\) bus and are totally integrated in the notebook chassis.

This does not make them the perfect solution for penetration testers as they can not provide the necessary signal power and receiving sensitivity - crucial parameters for a successful wireless attack.

A better option is to buy an external USB Wi-Fi dongle.

This is especially true if you plan to perform your attacks from a virtualized environment as an integrated wireless card will simply work as an Ethernet card in your guest OS.

When looking for a new Wi-Fi adapter, you have to pay attention to these three factor:

* Signal power
* Receiver sensitivity
* Linux Driver support

The last one is probably the most important.

While there are tons of compatible wireless adapters, some _standards_ emerged inside the Linux Wi-Fi pentesting community.

The **Alpha AWUS036H** has become quite a popular device and has been tested and confrmed to work very well with the `aircrack-ng suite`.

It comes with the **Realtek RTL8187L** chipset, which is widely supported.

It also has a huge transmit \(TX\) power of 1000mW.

The external connector RP-SMA type enables substitution of the standard antenna so you can choose the best fit for your scenario.

It's also **802.11g wireless standard** compatible.

### Antennas

Most Wi-Fi adapters are sold with integrated antennas. These kind of adapters are good for home or small office use but they are not the best choice when it comes to penetration testing.

If you are going to do some serious tests, you will need a more flexible adapter that gives you the ability to change the attached antenna to fit your scenario.

Connection range of a Wi-Fi adapter mostly depends on the antenna **power gain**. This characteristic is often specified using decibels \(dB\) as a relative numeric value compared to a reference antenna. Most of the time you will find gain specified as _dBi_, on rare occasions, it can be noted using _dBd_. 

You can convert with this formula

$$dBd = 2.14dBi$$ 

There are two main types of antennas:

* Omnidirectional
* Directional

#### Omnidirectional antennas

They are designed to pick up signals coming from multiple directions - typically in a 360 degrees area. 

Because of that, they are commonly found on all wireless-enabled consumer devices, especially on routers and Access Points as they must support connection over a wider area. 

Their gain ranges from 2 dBi to 9 dBi.  
  
**Rubber ducky** antenna is well known and shipped with Alpha Wi-Fi adapters.

#### Directional antennas

Because omnidirectional antennas power spreads in each direction, their power gain is inherently lower than directional antennas which focus their energy across a narrow angle. This characteristic makes them ideal for long-range connections but as the antenna pattern gets narrower, you will limit your coverage area.

Directional antennas can provide gains over 12 dBi.

As directional antennas can be useful, even for home users, many homemade designs have emerged during the past few years and were popularized over the Internet.

**Cantennas**

Made of cans. Prigles' packages are used for the purpose. 

This type of antenna can provide gains of **8 dBi and up**.

**WokFi**

Parabolic antenna made from Asian works \(or other metallic dishes\) that can boost your power gain to **12 dBi and higher** as they have a very narrow beam-width.

As with "cantennas", you can find a lot of tutorials on the Internet that will help you build one from cheap materials.

**Yagi-Uda**

Directional antenna that can be used for very long-distance connections. 

Commercial products reach gains over **20 dBi**. 

### Signal Strength

Most of tools use dBm nottation to express signal levels.

dBm are relative measures too and their reference value is **1mW**. 

To calculate the dBm value from an absolute power value, you can use this formula

$$dBm = 10*log10(power/1mW)$$ 

| dBM | mW |
| :--- | :--- |
| 0 | 1 |
| 10 | 10 |
| 15 | 31 |
| 20 | 100 |
| 27 | 500 |
| 30 | 1000 |

When using negative notation, the expressed power is a fraction of the reference **1mW** power. 

So -30dBm corresponds to 1µW or one thousandth of a milliwatt.

Given that, lower absolute value dBm values guarantee stronger signals.

Ex: -30dBm signal is much stronger than -70dBm

> As a quick reference, you should remember that a 10dBm decrease is a hundredth reduction of the power.

{% embed url="https://www.wikihow.com/Make-a-Cantenna" %}

{% embed url="https://www.aircrack-ng.org/doku.php?id=compatibility\_drivers\#determine\_the\_chipset" %}

{% embed url="https://www.instructables.com/Wifi-Signal-Strainer-WokFi/" %}

## Environment Setup

> **Consideration \#1**
>
> * The Linux 802.11 subsystem is fragmented. Available tools and commands depend on the driver you are using.

The most reliable way to determine if you are using mac80211 drivers is by running following command from a terminal window:

```bash
> lsmod | grep mac80211
mac80211    1378841    1    rtl8187
```

Modules listed on the right side are mac80211 drivers. In this particular example `rtl8187` is the driver of our Wi-Fi Dongle, based on a Realtek chip.

> **Consideration \#2**
>
> another difference to note between the various Linux wireless drivers is the naming scheme for the network interface; older drivers use different prefixes like `eth`, `wifi` or `ath`.

The mac80211 framework set a standard prefix, `wlan`. 

{% embed url="https://www.aircrack-ng.org/doku.php?id=install\_drivers" %}

### Adapter configuration

#### 1st step

As a first step, you must verify that your wireless card has been correctly detected:

```bash
> iwconfig
```

If you want to get even more information, you can use another command available for `mac802111` drivers: `iw` tool.

```bash
> iw list
```

You will get a list of all of your adapter's supported modes and capabilities.

It's worth noting that the `iwconfig` utility can be used to set various parameters for your wireless interface. For example this command sets the card's Wi-fi channel to 11:

```bash
> iwconfig wlan0 channel 11
> iw dev wlan0 set channel 11
```

> Maximum transmission power level is also controlled by country laws. In the 802.11 specifications, every country represents a so-called regulatory domain, often shortened to _regdomain_. Each _regdomain_ is identified by the correspondent ISO country code.
>
> **Please not that using a high transmission power may be illegal in your country!**

By default, many wireless adpaters are configured to work with regdomain set to 0. When running with this configuration, most adpaters will not deliver their maximum performance. However you can change internal regdomain setting with command line utilities. 

{% hint style="info" %}
**Bolivia**

A trick that is often used to increase maximum transmit power of a wireless adapter consists in setting the country code to match Bolivia's. 

```bash
> iw reg set BO
> iw dev wlan0 set txpower fixed 30dbm
```

This commands se the maximum transmission power to 30dBm which as we know, corresponds to 1000mW. 

You can confirm everything worked by launching `iwconfig`.
{% endhint %}

Usually the `wlan0` interface can only be used to connect to _intrastructure_ or _ad-hoc_ networks, although more can be done.

#### 2nd step

The next step is to setup a **monitor interface**_,_ a virtual interface that can be used to sniff traffic and perform low level network operations through your adapter.

```bash
> airmon-ng start wlan0
> iwconfig mon0
> airmon-ng stop mon0 # stop / dete the monitor interface!
```

`airmon-ng` can also help you to detect and resolve blocked device conditions.

```bash
> airmon-ng check kill
```

#### 3rd step

The last thing we should do is to check if everything is working fine with `aireplay-ng` tool, in this way we can test whether packet injection is working. 

`-9` is 'test-mode'. Upon execution, `aireplay-ng` will send out broadcast probe requests. If any AP responds, `arieplay-ng` will print a message informing you that your card can successfully inject.

> Remember to start your monitor interface first and set the card to the desired channel.

Every AP in the respondents list is the directly probed 30 times and a percentage of responses received is given for each one. 

This percentage is an excellent indication of the link quality for the specified AP.

{% embed url="https://www.aircrack-ng.org/doku.php?id=aireplay-ng" %}

{% embed url="https://www.aircrack-ng.org/doku.php?id=airmon-ng" %}

## Wireless Standards and Networks

### IEEE 802.11 Standards

IEEE \(Institute of Electrical and Electronic Engineers\) is a worldwide association counting over 435000 members dedicated to advancing technological innovation.

IEEE 802.11 is the IEEE Working Group that develops and enhances standards related to Wi-Fi technologies.

| Protocol | Release Date | Radio Band \(GHz\) |
| :--- | :--- | :--- |
| 802.11 \(legacy\) | 1997 | 2.4 |
| 802.11a | 1999 | 5 |
| 802.11b | 1999 | 2.4 |
| 802.11g | 2003 | 2.4 |
| 802.11n | 2009 | 2.4 / 5 |

IEEE 802.11g is the most widely deployed version of the protocol. In the last few years, 'n' version APs have become quite frequent but most of them still use the 2.4GHz band for backward compatibility with older adapters.

The 2.4GHz band \(2.4GHz - 2.495Ghz\) is divided into _14 overlapping channels_ with a 22MHz bandwidth around the central frequency. Each channel is simply referred to by its number.

Channel availability is not the same in every part of the world. In fact, most countries have special requirements. For example in USA you can only use channels from 1 to 11 while in Japan the whole spectrum is available \(1 to 14\).

The 802.11n protocol introduced the 5GHz band as the 2.4GHz was getting more and more crowded with so many devices interfering with Wi-Fi communications \(bluetooth, cordless phones, microwave ovens\). 5GHz band is far less crowded and guarantees a higher number of non-overlapping channels.

802.111n also defines specifications for 40MHz channel bandwidth that double the maximum theoretical throughput.

### Types of Wireless Networks

There are two main types of wireless network architectures described by Wi-Fi standards:

1. Infrastructure Network
2. Ad-hoc Network

#### Infrastructure Network

A Basic Service Set \(BBS\) contains an Access Point \(AP\) and a set of wireless client stations \(STAs\).

Every BSS has a unique formal identifier called BSSID \(the MAC address of the AP\).

An informal name is also assigned to a BSS. It is called SSID \(Service Set Identifier\) and it's easier to remember.

It's composed by a 32-byte \(maximum\) character string and is the one you usually see when connecting to a wireless network.

Single BSS's can be combined to form groups of Access Points connected together. This configuration takes the name of Extended Service Set \(ESS\). In such a configuration, multiple BSS's exist with a common SSID \(now called ESSID\) but unique BSSID.

Access Points can be linked together using a backbone Distribution System \(DS\) which is usually a wired Ethernet network; this enables communications between STAs associated in different BSSs and other segments of the network.

This configuration is used by corporations and it enables larger coverage areas.

#### Ad-hoc network

This type of network does not need an existing infrastructure. All of the STAs directly communicate to each other, as there is not a central base. A set of stations connected like this is called IBSS \(Independent Basic Service Set\).

A simple schema of an Ad-hoc network can be a simple IBSS with 3 stations communicating each other.

### Wireless frames

Now we'll take a look at the fundamental datagram units of the Wi-Fi protocols.

In the context of 802.11 specifications, datagrams are called _frames_.

Each frame consists of

* a header
* an optional payload \(data\)
* a Frame Check Sequence \(FCS\)

This is the 802.11MPDU \(MAC Protocol Data Unit\) format. Each field is annotated with its byte length:

![Second row decomposes the Frame Control Field!](../.gitbook/assets/image%20%2877%29.png)

We will not dive into the details of every single field as this is not the purpose of this course. Instead, we will focus or attention on the most interesting ones.

The _Frame Control_ field contains control information defining the type of 802.11 MAC frame and how to process the frame itself.

The frame function is defined by the _Type_ and _Subtype_ fields. 

Note that there are multiple subtype fields for each frame type. Each subtype determines the specific function to perform for its associates frame type.

Currently the standard describes three types of frames:

* Management Frames
* Control Frames
* Data Frames

The frames _To DS_ and _From DS_ indicate whether the frame is going to or existing from the DS \(Distributed System\).

The WEP field \(also called Privacy Bit\) is a Boolean flag and indicates whether or not the WEP algorithm has been used to encrypt the packet. The Privacy Bit can be set only for data frames and management frames for authentication purposes.

Addresses can be a combination of the following:

* BSSID: identifies an AP
* Destination Address \(AD\): final destination to receive the frame
* Source Address \(SA\): original source that created the frame
* Receiver Address \(RA\): receiving STA
* Transmitter Address \(TA\): transmitting STA

The presence of both a SA and a TA might be confusing at first but if you think about how Wi-Fi works, you will understand that all of these fields are necessary as frames are relayed.

For example, in an Infrastructure network, all of the frames between two stations still to pass from the base AP. In that case, packet coming from the stations will have the 1st tation's MAC as Source Address but AP's MAC as Transmitter Address.

Frame Body is an optional field \(from 0 to 2312 bytes\) that contains the payload of the transmission. It is used in either data and management frames. When the WEB bit is set, the body is extended by 8 bit \(so its maximum length becomes 2320 bytes\).

And finally the Frame Check Sequence \(a simple Cyclic Redundancy Check - CRC - of the entire frame\) is used for transmission errors and detection.

This table lists Management frames subtypes:

| Type \(Management\) | Subtype | Description |
| :--- | :--- | :--- |
| 00 | 0000=0x00 | Association Request |
| 00 | 0001=0x01 | Association Response |
| 00 | 0010=0x02 | Reassociation Request |
| 00 | 0011=0x03 | Reassociation Response |
| 00 | 0100=0x04 | Probe Request |
| 00 | 0101=0x05 | Probe Response |
| 00 | 1000=0x08 | Beacon |
| 00 | 1010=0x0A | Disassociation |
| 00 | 1011=0x0B | Authentication |
| 00 | 1100=0x0C | Deauthentication |

Beacon frames are periodically transmitted by an AP. Their purpose is to advertise the availability of a wireless network. They contain information about network parameters and AP capabilities such as supported throughput rates.

Beacons also contain the SSID but that value can be stripped from the frame for security reasons \(Hidden SSID configuration\).

Probe Requests are sent by a wireless client in order to determine the network availability status. It contains the SSID name of the network and is sent over all the wireless channels. A special "null" \(0x00\) SSID can be used if the client does not want to search for a specific network.

Client can also query the AP for specific information in the request.

Probe Responses are sent by an AP upon the reception of a Probe Request.

They are very similar to beacons but they can also contain addition information \(as specified by the communicating client inside the corresponding Probe Request frame\).

Authentication frames are used to perform the authentication process.

Unlike association or probing, all authentication frames share the same subtype.

After the authentication, a station needs to associate to an AP. This is the purpose of the Association Request frames. These frames carry information about the STA capabilities \(e.g. supported data rates\) and the SSID of the network to which it wishes to associate.

After receiving the association request, the AP considers associating with the STA, and \(if positive\) establishes an Association ID \(AID\) for the newly associated STA reserving necessary memory resources.

The Association Response frame contains an acceptance or rejection notice to the requesting STA. If the AP accepts the STA, the frame includes information regarding the association such as Association ID and supported data rates.

The wireless STA can now start to communicate with other peers in the network through the AP.

A station sends a Disassociation Frame to another station if it wishes to terminate the association but the same frame can be used by either party of the communication.

Disassociation is often used when the station is roaming from a BSS to another in order to keep the authentication status.

The frame also contains a reason code field.

Deauthentication frames are used when all of the communication is terminated. For example, a STA that is shut down gracefully can send a deauthentication frame to alert the access point that it is powering off. The access point can then free memory allocations and remove corresponding records in its internal structures.

As for disassociation, the AP can also use these frames.

Reassociation Requests and Responses are used by a STA and AP respectively and they enable roaming stations the capability to move from one AP to another without losing the authenticated status. 

### Security features

We'll explore two main aspects of Wi-Fi security:

* Traffic encryption
* Station authentication

#### Wired Equivalent Privacy

The first attempt to secure the communications on Wi-Fi netowrks was WEP which was introduced in the 802.11 standard - ratified on September 1999. The acronym stands for Wired Equivalent Privacy.

Despite this, WEP has been proven to suffer from a number of flaws that made it completely ineffective. Due to these findings it has been deprecates in subsequent versions of the standard.

WEP uses the RC4 algorithm for encryption with a 40 \(WEP-40\) or 104 bits \(WEP-104\) long key.

RC4 is a stream cipher that uses a pseudo-random generation algorithm \(also called PRGA\) coupled with an internal state and a key to generate a byte keystream.

This keystream is then XORed to the plaintext to obtain the final encrypted cyphertext.

In WEP implementation, the RC4 internal state is reset on every frame.

Normally, this will completely break security as every plaintext would be encrypted with the exact same keystream; despite its name, the PRGA algorithm is completely deterministic and would produce the same results over and over if the same key is applied.

To alleviate this problem, the RC4 implementation designed for WEP makes use of a 24 bits Initialization Vector \(IV\) as a concatenated prefix of the key. This IV is then sent unencrypted with the cyphertext to enable decryption on the receiver side. The receiver must still know the key to be able to recover the original plaintext.

![](../.gitbook/assets/image%20%2881%29.png)

Key Index is a number from 0 to 3 that stands as a key identifier. In fact most wireless routers optionally let you specify 4 WEP keys and then choose which one to use. This mechanism was introduced to facilitate key changes in large organizations.

![](../.gitbook/assets/image%20%2878%29.png)

The last part of the WEP frame is the Integrity Check Value. This is a 4-byte CRC code of the original unencrypted frame. It is appended to the plaintext data and subsequently sent encrypted along with the actual payload. Its purpose is to detect frame tampering by an attacker. WEP vulnerabilities make this integrtiy protection much less effective.

#### WEP Flaws

The first and simplest WEP flaw descends from the short length of the IVs. As this is only 24 bits, there is a 50% probability that the same IV will be repeated after only 5000 packets and so also the related keystream would be reused.

In a semi-busy network, the packet rate is large enough to assure repetitions will happen quite often.

Keystream reuse is a critical vulnerability.

If the attacker can get two cyphertexts that were encrypted with the same keystream and has knowledge about on of the two plaintexts, he can recover the other messages with a simple operation.

{% hint style="info" %}
To see why IV repetition is a problem, we need to understand some formulas. Let us indicate:

* P1 and P2 as two plaintext messages
* C1 and C2 as the corresponding cyphertexts.
* RC4\(IV1, K\) and RC4\(IV2, K\) as the generated keystreams used to encrypt P1 and P2.

Both messages are encrypted with the same key K but different IVs, so:

 C1 = P1⊕RC4\(IV1, K\) ; C2 = P2⊕RC4\(IV2, K\)

IF the used IVs are the same we get:

C1⊕ C2 = P1⊕RC4\(IV1, K\) ⊕ C2

Substituting C2 on the right we obtain:

C1⊕ C2 = P1⊕RC4\(IV1, K\) ⊕ P2⊕RC4\(IV1, K\) 

This can be further simplified resulting in:

C1⊕ C2 = P1⊕ P2

> Therefore, w can see that a known plaintext attack can be applied.

In fact, if an attacker knows the content of P2 or P2 message \(or a prefix of it\) the other message can be obtained with a simple XOR operation as the attacker knows all the other values of the equation \(C1 and C2 are sent on the wireless medium and can be sniffed by any wireless-enabled device\).
{% endhint %}

WEP cannot guarantee the confidentiality of the encrypted data. Another thing to note about this theoretical exposure is that it is possible to abuse the vulnerability for the inverse task of recovering the keystream.

While data confidentiality is one of the security requirements of an encryption algorithm, it is not he only one. A good algorithm must also provide data integrity protection.

An attacker that has obtained an encrypted frame should not be able to modify that frame and re-inject it into the network successfully.

WEP uses CRC-32 to calculate a checksum \(the ICV/CRC\) of the payload before encryption; the ICV is then sent encrypted along with the message.

When decrypting, the receiver calculates the ICV in the same different way.

If the calculated version and the received one do not match, the frame is discarded so tampering the encrypted data should not be easy for an attacker who lacks knowledge of the key.

The main problem of this approach is that CRC-32 was not intended as a security measure when it was designed. Its main purpose is to provide error checking during transmissions or storage of data, using statistical methodologies. This leads to another major WEP flaw: it is actually possible to make controlled changes to the frame payload and re-inject it without the receiver noticing.

{% hint style="info" %}
**Linearity of the CRC algorithm** _**and bit-flipping attack**_

Given two messages M1 and M2, the following is valid:

CRC\(M1\) ⊕ CRC\(M2\) = CRC\(M1⊕ M2\) 

The above equation simply states the linearity of the CRC function with the XOR operation.

Suppose now that a message M was sent encrypted on the network with cyphertext C:

C=RC4\(IV,K\) ⊕ \(M,CRC\(M\)\)

The attacker can now build a new cyphertext C' that is decrypted to \(M', CRM\(M'\)\) without knowing the network key.

He chooses an arbitrary message Δ and uses it to compute C':

C' = C ⊕ \(Δ,CRC\(Δ\)\) 

= RC4\(IV, K\) ⊕ \(M,CRC\(M\)\) ⊕  \(Δ,CRC\(Δ\)\) 

= RC4\(IV, K\) ⊕ \( M ⊕ Δ, CRC\(M\) ⊕ CRC\(Δ\)\) 

= RC4\(IV, K\) ⊕ \( M ⊕ Δ, CRC\(M ⊕ Δ\)\)

= RC4\(IV, K\) ⊕ \( M', CRC\(M'\)\)  \# here we apply CRC linearity!

The major limitation of the attack derives from the fact that the attacker does not know the plaintext content of the original message but he does know is that a "1" in a specified position in the Δ message produce a "flipped" bit in the corresponding position in M'.

This is called a _bit-flipping attack_. Using this technique, an attacker can make controlled changes that will not be detected by the receiver.
{% endhint %}

While these design flaws surfaced almost after WEP specification release, further analysis of plain RC4 cypher and particularly of its usage mode in WEP showed that the encryption schme could be broken by a series of statistical attacks.

Back in 2001, Scott Fluhrer, Itsik Mantin and Adi Shamir published a paper exposing a methodology to take advantage of the way RC4 cipher and IV are used in WEP in order to recover the network key.

The authors discovered correlations between the first bytes of the keystream and the key itself resulting in a passive attack that can recover the RC4 key after eavesdropping on the network long enough to collect a sufficient amount of packets \(typically around 4 million\).

The attack was named **FMS** after the names of the original discoverers.

The **FMS Attack** relies particularly on a subset of the possible IVs, named "weak IVs". While the other IVs are simply discarded during the attack, these weak IVs can "leak" portions of the key; statistical attacks can be performed in order to fully recover the network key.

Implementation of the attack are available in the `aireplay-ng` tool.

Most vendors implemented countermeasures against the FMS attack. An obvious one was detecting and avoiding the use of "weak IVs". This countermeasure proved to be insufficient; in 2004 a person using the pseudonym **KoreK** posted a series of 17 statistical attacks that do not need weak IVs and reduced the number of frames to recover the key to less than 500000.

Andreas Klein, in 2005, discovered even more correlations between the key and the RC4 generated keystream.

In 2007, Andrei Pychkine, Erik Tews and Ralf-Philipp Weinmann were able to optimize Klein's attack and apply to the WEP scenario in a powerful new methodology.

With this new attack, named **PTW** from the initials of the original authors, it is possible to recover a 104-bit WEP key with 50% probability using only 40000 captured packets.

{% embed url="https://eprint.iacr.org/2007/120.pdf" %}



#### WPA: Wi-Fi Protected Access

It became available in 2003 as part of the IEEE 802.11i standard draft. It was intended as a replacement for WEP while WPA2 was in development stage. WPA specification solves the flaws that plagued WEP.

The main addition was the use of a per-packet 128 bit key, generated using the Temporal Key Integrity Protocol \(TKIP\), a feature that prevents the types of attacks that compromised WEP. This means that for each packet, a new key is dynamically generated.

Another feature of WPA is the addition of a message integrity check \(MIC\). This is designed to prevent an attacker from capturing, altering and/or resending data packets; this replaces the Cyclic Redundancy Check \(CRC\) used by WEP that could not provide any security guarantee.

WPA2 is the result of the final IEEE 802.11i specifications and was published in 2004. The new standard deprecates the use of TKIP in favor of CCMP, a new AES-based encryption scheme with strong security properties.

While WPA was a huge improvement over WEP with regard to security guarantees, TKIP was still based on the RC4 cypher. This was a design requirement as it allowed adoption of the new algorithm implementation through a simpler software/firmware upgrade.

However, researchers were able to demonstrate attacks on WPA when TKIP encryption was in use by exploiting some of the known flaws existing in RC4.

These attacks, developed by Martin Beck, Eric Tews, Toshihiro Ohigashi and Masakatu Morii, circumvent WPA anti-replay protection and enable the attacker to decrypt one packet and use the obtained keystream to forge and inject up to 7 new frames. While the discovered attacks are interesting on theoretical bases, they are not practical and can not be used to recover the network key.

{% embed url="https://dl.aircrack-ng.org/breakingwepandwpa.pdf" %}

Since TKIP is completely secure and has been deprecated, to guarantee the best security of a Wi-Fi network, WPA2 with CCMP/AES encryption must be used.

#### Authentication

In order to exchange messages, client stations must be associated with an AP. Before this can happen, stations need to authenticate themselves, proving they have the rights to access the wireless network.

802.11 specifications describes three possible connection states for a client that model this process:

1. Not authenticated
2. Authenticated but not associated
3. Authenticated and associated

The 802.11 original standard specified two different station's authentication modes:

* Open Authentication
* Sharked Key Authentication \(SKA\)

{% hint style="info" %}
**Open Authentication**

If Open Authentication is enabled on the AP, the client station simply sends an Authentication Request frame specifying the target SSID, and receives an Authentication Response with a successful result.

In this case, the client does not need to provide any proof beside the SSID; given that this information is broadcasted by the AP in beacon frames, it cannot be considered a secret.

Open Authentication messages flow:

1. STA → AP: Open System Authentication Request
2. STA ← AP: Open System Authentication Response
3. STA → AP: Association Request
4. STA ← AP: Association Response

Truth is that something could go wrong along the way due to transmission errors, stations incompatibilities but also to MAC filtering features enabled on the AP. When one of these happens, the AP will report a failure status code in its Authentication Response.

It's also useful to note that all of the messages exchanged during the process are sent unencrypted; WEP encryption is used only for data frames sent immediately after a successful authentication.
{% endhint %}

{% hint style="info" %}
**Shared Key Authentication**

SKA is available only when WEP is enabled. Different from the Open mode, when receiving an Authentication Request, the AP responds with a challenge text \(128 bytes\). The client needs to encrypt the challenge with the shared WEP key and return it to the AP in the next frame. Then the AP compares the decrypted challenge to the known plaintext and successfully authenticates the client if they are equal.

1. STA → AP: Authentication Request
2. STA ← AP: Challenge Text
3. STA → AP: Encrypted Challenge 
4. STA ← AP: Authentication Response

The Association messages are removed but are obviously necessary. 

While it may seem like SKA is an improvement over simple open authentication, _it can simplify certain attacks against WEP_. In fact, an attacker is able to recover 128 bytes of keystream given that the challenge text that was sent unencrypted. **This can be used to forge encrypted packets without actually knowing the key!**

An attacker will be able to authenticate to the AP once he has snooped over at least one authentication message flow. 

This clearly makes the Shared Key Authentication completely broken so you should not rely on it for any security requirements. 
{% endhint %}

## Discover Wi-Fi Networks

### Discover Wi-Fi Networks

#### Tools

Since discovering wireless network mostly requires just traffic sniffing, mature tools are available for all of the major platforms. Some of the best are:

* Kismet, `airodump-ng` \(Linux\)
* InSSIDer Office \(Windows\)
* KisMAC \(Mac OS X\)

{% hint style="info" %}
**InSSIDer Office**

Intuitive tool developed by MetaGeek. It is a commercial Windows-only tool but it's available in a free trial mode. There's a _Networks panel_, we find information about reachable networks in the area.

The InSSIDer Networks panel table provides us with:

* SSID \(Service Set Identifier\)
* Signal strength
* Channel\(s\)
* Encryption level \(WEP/WPA/WPA2\)
* AP MAC address
* Wi-Fi protocol

As a side note, InSSIDer also provides the Channels pane which gives us a great way to optimize our Wi-Fi performances by choosing the less crowded channels.
{% endhint %}

{% hint style="info" %}
**Kismet**

While less intuitive, it offers more useful features for the wireless pentester. Kismet is based on a client/server architecture. The server provides data while the client application uses them to display information gathered from one or more servers. This architecture is further extensible with another subject: drones.

These drones are simple wireless devices that only scan the air and feed captured frames to a specified server.

The first thing to do when using Kismet is putting your wireless adapter into monitor mode.

The simples way to start sniffing with Kismet and your monitoring interface is through:

```bash
> kismet -c <mon_interface>
```

In the upper panel, you will find a list of available wireless networks. The central panel will display information about clients connected to the selected network. The plot displays packets and data rates. The bottom panel shows an informative log that can be useful for debugging purposes. Sidebar shows useful statistics as well.

If you want to dive into a particular network, you can click on its row in the Networks list and a details window will open up.

A more interesting feature allows you to see the clients that communicate with a particular AP/Network. Information about currently or previously associated clients is fundamental for some of the most powerful attacks.

Kismet uses color coding to help you to identify features of listed networks. Chosen color depends on the value of the C \(Encryption type\) column:

* Green. N \(None\)
* Red. W \(WEP\)
* Yellow. O \(Other\), typically WPA or WPA2
{% endhint %}

{% hint style="info" %}
**airodump-ng**

Comprehensive wireless sniffing tool included in the famous `aircrack-ng` suite. It comes with a very essential text-based user interface. Despite this, it has a lot of useful feautres and it perfectly integrates with all of the other tools of the `aircrack-ng` suite which makes it the perfect  pentester companion.

It can:

* Perform automatic channel switching
* Filter captured traffic by BSSID or cypher suite
* Determine the list of clients associated to a network and their MAC addresses
* Provide information on signal level, network traffic, security settings
{% endhint %}



























#### Hidden SSID

### ▶ Discover Wi-Fi Networks

## Traffic Analysis

### Traffic Analysis

### ▶ Protocol and Wireshark Filters

## Attacking Wi-Fi Networks

### Attacking Wi-Fi Networks

Now we are going to see how you can exploit vulnerabilities of Wi-Fi security protocols and gain access to protected wireless networks.

#### WEP

 Given the low security level provided by the WEP encryption scheme, less and less networks are configured to use it.

Still, it's useful to know how to deal with them as corporations or individuals could still be using this configuration for various compatibility reasons.

The main flaws of WEP encryption are:

* Weak authentication scheme
* Short Initialization Vector \(IV\) and subsequent frequent reuse
* vulnerable to replay attacks
* Weak frame integrity protection
* Low resistance to related key attacks enabling efficient statistical attacks

The key of all attacks directed against WEP key recovery is getting a sufficient amount of encrypted packets to be able to successfully execute the statistical attacks.

In a medium-sized network, the actual traffic between legitimate clients could be enough to gather the required encrypted data very quickly but this will not always be the case.  


{% tabs %}
{% tab title="LAB \#1" %}
Setup your environment with the following guidelines:

* Access Point SSID: LabNetwork
* Use WEP Encryption
* Set WEP key size to 40bit and choso your key \(10 hexadecimal characters\)
* 1 vicitim STA \(associated to Lab Network\), this shouldn't be the same device you will use for the attack!
* The attacker machine

> Have a note of your AP channel as you'll need it later.

### 1. Start `airmon-ng` and `airodump-ng`

```bash
# Attacker machine
> airmon-ng start <interface>
# -w save all caputred data into a collection 
# of files all sharing the same filename prefix
> airodump-ng -c <channel> -w wep_attack <interface>
```

`airodump-ng` will start scanning. As you can see `LabNetwork` is listed in the command output with the encryption correctly identified as WEP.

We can also see our victim client associated stations section.

> `#Data` column indicates the number of data frames collected thus far on a particular network while `#/s` displays the data frames capture rate as frames per second. 
>
> You **do want** high values for these columns in order to succeed.

### 2. Deauthentication attack: Increment packet rate

If `LabNetwork` does not produce a lot of traffic, we might need to have a way to increment the packet rate.

When deauthenticated from a wireless network, normally a client will try to re-authenticate shortly later \(_just as the IEEE 802.11 standard specifies a management frame for this purpose, this is sent completely unencrypted and requires no authentication from the sender_\).

_**deauth**_ **frames aren't encrypted**. They are not useful per se to increase the number of collected IVs.

On the other hand, after re-associating a client, the client will most certainly send some gratuitous ARP or DHCP messages and this traffic is clearly valuable as it's sent encrypted.

To deauthenticate a client:

```bash
> aireplay-ng -0 10 -c <client_mac> -a <bssid> <interface>
```

This will increase the number of data frames.

> Deauthentication attacks force the victim to actually disconnect from the network. If you abuse this techniques, **chances are that your attack will be noticed!** So keep this is in mind when pentesting a real-world wireless network.

### 2.1 ARP Replay Attack

ARP replay is the most effective way to generate new IVs. Once you sniff an ARP request generated by a STA, you can re-inject that packet due to WEP's lack of message replay countermeasures.

As it's a broadcast message, the AP will forward the request to the associated STAs and each of these request will contain a new IV for you to collect.

The ARP replay attack is a bit more complicated than simple deauthentication. As such, it will be useful to get an overview of the attack before diving into it.

Steps of an ARP Replay attack:

1. Stations normally communicate with the AP while the attacker machine is not yet operating.  `aireplay-ng -1 15 -a <bssid> -e <ssid> <interface>`. This will associate your adapter to the specified network. You have to provide both the BSSID and SSID. The `-1` stands for _fake authentication_, while the number on the right is the delay between authentication attempts. When successful, you should see something like `Association successful`
2. The attacking machine associates itself with the AP, with Open Authentication system, this is only a matter of exchanging 4 frames without providing any credentials. In the `aircrack-ng` terminology, this is called **fake authentication**. 
   1. During the real attack, you can find that your adapter constantly receives deauthentication messages from the victim AP. You can try this variation for "picky APs": `aireplay-ng -1 6000 -1 10 -o 1 -a <bssid> -e <ssid> <interface>`
      1. `-q 10` enables keep-alive packets. This command causes this packets to be sent every 10 seconds to maintain the authentication status. The long re-authentication time permits these packets to be sent.
      2. `-o 1` forces `aireplay-ng` to send one set of packets at a time, these can be necessary as some APs can get confused by aireplay-ng's default behavior.
      3. Do not close opened terminal windows as `aireplay-ng` will need to continue running while performing the attack. 
3. Once the attacker is associated, the attacker starts to passively scan for ARP request, listen for broadcasted ARP request frames.
   1. Now we need to listen for ARP requests sent by clients on the network. Obviously this will not work if your STA is the only associated one.  `aireplay-ng -3 -b <bssid> <interface>`
4. After a while, STA1 sends an ARP request to all of the nodes in the network, and the AP forwards it and the attacker is thus able to capture the frame.
   1. After a few minutes you should capture at least an ARP request. 
5. At this point, the attacker can flood the network by re-injecting the same ARP frame over and over. Simply put: the attacker floods the AP with ARP requests.
   1. Almost instantly `aireplay-ng` will start to re-inject the captured ARP request.
6. Following the protocol, the AP simply forwards each received ARP **using a new IV every time**.
   1. airodump-ng will show the increase in received frames as you are flooding the AP.
7. By collecting all of these frames, the attacker can then mount one of the statistical attacks. 

{% hint style="info" %}
**Question: Given that the traffic is encrypted, how can the attacker actually identify an ARP request?**

Luckily, ARP request have a fixed payload size \(36 bytes\) so they can be easily identified. They always have a broadcast destination address\(`FF:FF:FF:FF:FF:FF`\) that is transmitted in plain text in the frame header.
{% endhint %}

### 3. Cracking the key with aircrack-ng

`aircrack-ng` is a software that encapsulates a series of cracking techniques for both WEP and WPA network keys. 

This command needs packets in order to crack the WEP key. **The minimum amount of packets depend on the key length.**

{% hint style="info" %}
**40 bit keys will require about 5000 IVs to be cracked while 104 bits keys could require a number ten times higher or more.**

The number should be taken with care as they could vary if the AP implements some sort of protection.
{% endhint %}

As you do not know they key length of the attack, a good strategy is first trying with 64 bits.

If that fails for more than 10000 IVs, just try again with a key of 128 bits.

```bash
> aircrack-ng -n <key_length> <.cap file(s)>
# -n speficiy the WEP key length (default: 128bits/WEP-104)

> aircrack-ng -e LabNetwork wep_attack*.cap
```

Now `aircrack-ng` will start reading all of the IVs from the specified files then the cracking process will begin. If the number of IVs isn't sufficient, `aircrack-ng` will just wait for `airodump-ng` to get more so you do not need to restart the command. 

{% hint style="info" %}
**PTW attack with aircrack-ng**

WEP cracking technique developed in 2007 that exploits correlations discovered between RC4 keystream and the key itself.

Statistical analysis votes for each byte of the key are collected and shown in the output window.

The more votes a byte receives, the more likely the byte will be found in the real network key.

The key that gets the most votes is the most probable key _but is not guaranteed to be the real one_. `aircrack-ng` uses brute force to determine the WEP key from the statistical guesses.

This technique **only** requires ARP requests/responses in order to work as they are used to improve the speed of the cracking process.

So the usual network traffic will not be useful and you will need to launch an active attack with some of the ARP generation techniques.
{% endhint %}

{% hint style="info" %}
**KoreK attack**

PWT is the fastest and default technique used by aircrack-ng but it requires ARP. As a fallback, you can still use the old pre-PTW technique that uses a combination of KoreK statistical methods.

Cracking speed can be much slower, moreover the required number of IVs is at least an order of magnitude higher. You can switch to KoreK attacks by using the `-K` flag when you launch `aircrack-ng`.
{% endhint %}
{% endtab %}

{% tab title="Clientless WEP cracking" %}
> Assure yourself there are no clients associated to the "AP.  You can have a look to your `airodump-ng` output and see that no clients are listed.

1. Use `aireplay-ng` fragmentation attack option to get a PRGA \(Pseudo Random Generation Algorithm: it represents a keystream generated by the RC4 cipher used in WEP encryption\) stream.
2. Once you have a _keystream_, we can encrypt any packet and inject it \(like we had the network key\). In this way, we can forge an ARP request, encrypt it and still use the old ARP replay technique.

```bash
# 1. Use aireplay-ng for fake authentication as usual:
aireplay-ng -1 6000 -1 10 -a <BSSID> <interface>

# 2. Start aireplay-ng fragmentation attack
airepaly-ng -5 -b <BSSID> -c <source_mac> <interface>

 # -5 indicates the fragmentation attack
 # source_mac is your wireless adapter MAC
```

At some point, if you are lucky, you will get a data packet transmitted from the AP. These are distinguishable by the `FromDS` bit set to 1.

> At this point, aireplay will ask for y/n to confirm if you really want to use that packet.

At this point, the fragmentation attack really starts. As you will see, `aireplay-ng` saves the obtained keystream to a file so now we can forge packets with it!

{% hint style="warning" %}
**Fragmentation attacks can sometime fail.**

If you are not able to obtain a keystream, please be sure you are associated to the network and close enough to reach the AP with your wireless signal.

`aireplay-ng` will suggest you to move close or farther away from the AP:

```bash
Not enough acks, repeating.
```
{% endhint %}

With the captured PRGA, we now build an APR request packet using this command. This command creates the packet and saves it to the specified output file:

```bash
packetforge-ng -0 -a <BSSID> -h <source_mac> -k <ip1> -l <ip2> -y <prga.xor> -w outfile

# -0 build an ARP request looking for the MAC address of ip1

# Ex:we use 255.255.255.255 as the value for both IP since many IPs will ignore the IPs used in the ARP
packetforge-ng -0 -a 00:11:22:33:44:55 -h 22:22:22:33:33:33 -k 255.255.255.255 -l 255.255.255.255 -y file.xor -w arp-request
```

Now we will start injecting packets thus generating new IVs so start up `airodump-ng`to save them. To inject the forged ARP request, we use `aireplay-ng` interactive mode:

```bash
aireplay-ng -2 -r <packet-file> <interface>
# confirm pressing "y" and let the attack begin!
```

As we now have a way to generate new traffic, we can proceed through the usual attack process. We will gather the IVs and run `aircrack-ng` .
{% endtab %}

{% tab title="Bypassing Shared Key Authentication" %}
There is another option when it comes to authenticating wireless stations on a WEP "secured" network. That is _Shared Key Authentication_. 

When using SKA, a station wanting to associate to an AP needs to know the WEP key, otherwise its authentication request would be discarded and consequently it would not be able to associate and communicate with other stations.

But this is not entirely true given the fact than an attacker will be able to authenticate if he can sniff one challenge-response message exchanged from a victim client and the target AP.

{% hint style="info" %}
**Shared Key Authentication process with Wireshark!**

* The first Authentication Frame, from client to AP reports Shared Keys is in use \(value is 1\)
* The second frame from AP to STA contains the 'Challenge Text'
* The client using the known WEP key encrypts the challenge and resends it through the wireless medium.
* The 4th and final message of the process is just a simple confirmation message from the AP. It should contain a success status code if the challenge was decrypted correctly.
{% endhint %}

### ByPass Attack

Steps:

1. Deauthenticate one victim client
2. Obtain keystream from captured authentication frames
3. Authenticate with the AP using recovered keystream
4. Initiate ARP replay attack

**Lab settings**

| Access Point SSID | LabNetwork |
| :--- | :--- |
| 1 victim STA | associated to LabNetwork |
| WEP encryption | using Shared Key Authentication |
|  |  |
|  |  |

The AP should be configured to use WEP encryption using Shared Key Authentication System. Please ensure the same options are set on STA.

#### Step 1: Deauthentication attack

The objective here is to force the victim to restart the authentication process and then capture the challenge-response messages. 

Of course this is not possible when there are no clients associated with the target network. In that scenario, you are stuck waiting for a client to associate.

Start `airodump=ng` on the proper channel and start saving captured data to a file:

```text
airodump-ng -c <channel> -w shared <interface>
```

Once `airodump-ng` is started, you should see the victim client reported as associated to the target network. Note MAC address as you will need it.

In another terminal, we will now launch the deauthentication attack using aireplay-ng:

```bash
aireplay-ng -0 0 -e <SSID> -c <client_MAC> <interface>
```

The _client\_MAC_ uses the MAC address you noted. This syntax is a little different than since we are specifying the target network by its SSID value instead of its BBSID. The result will be the same in this case as there is only one AP having that SSID name in our scenario.

#### Step 2: Explore airodump-ng

On the top part you should see a message which informs you a keystream was recovered.

The recovered keystream will be saves in a `.xor` file located in the `airodump-ng` directory. The file will have the prefix you specified in the `airodump-ng` command, followed by the MAC address of the victim client.

#### Step 3: Try to authenticate with the target AP

As we now have a reusable keystream \(along with its IV\), we can try to authenticate ourselves with the target AP.

We will launch `aireplay-ng` _fake authentication_ attack but this time, we will provide the command with the needed keystream.

The syntax is almost the same as usual fake authentication, only this time we use the `-y` option specifying they keystream file:

```bash
aireplay-ng -1 6000 -q 10 -e <SSID> -y <file.xor> <interface>
```

`Association successful` is the desired output for this command.

#### Step 4: ARP Replay

The attack is now almost complete. You just need to perform ARP replay as we have learned along this document.
{% endtab %}

{% tab title="Caffe-Latte: Attacking the client" %}
All of the attacks explored thus far against WEP require the physical presence of the AP to be perpetrated.

In the past few years, a new type of attack arose that could permit WEP cracking off-site. This is possible because these attacks target the wireless clients instead of the network infrastructure. A good example of this new type of attacks is the so-called Caffe-Latte attack.

The Caffe-Latte attack was presented in 2007 by Vivek Ramachandran and MD Sohail Ahmad of Airtight Networks at the Toorcon conference. 

Its name comes from the fact that using this attack you can crack a WEP key in the time you enjoy a caffe-latte at the bar.

The main target of the attack is the roaming client: an unassociated client periodically sends out Probe Request on every channel, searching for the wireless networks it is configured to use.

Probe Requests only search for a particular SSID so that the AP MAC address can change without affecting the clients. 

This property, along with the multiple flaws of WEP can be used to mount this attack. The attacker starts a fake AP advertising as the target network. As mutual authentication is not enforced by WEP security, the client will simply sense that its preferred AP is in range and try to associate with it. Until now, no encrypted packets have been sent so how can the attack collect a sufficient number of IVs?

Most wireless clients, upon association to a network, will send out a few gratuitous ARP and DHCP requests. These packets are encrypted! A basic form of the attack could now deauthenticate the client and restart the process over and over until a sufficient amount of IVs has been gathered. Unfortunately, this could take a huge amount of time and wouldn't be practical as we are targeting a roaming client and we only have few minutes.

The solution found by this attacks' authors is to exploit how WEP fails to verify the integrity and absence of manipulation of transmitted packets.

In fact, it is possible to "flip" bits in the packet payload and then adjust the corresponding ICV \(Integrity Check Value\), a CRC-32 field calculated on the encrypted data, obtaining a perfectly valid packet. 

Once a gratuitous ARP packet is received, it is possible to flip certain bytes and forge a new ARP request targeting the client \(see the paper for details\). It is now possible to flood the client with these ARP requests and collect a huge amount of encrypted packets in a few minutes.

### Lab Setup

* Your target network AP is switched off or out of reach.
* A client with a pre-configured WEP key for the target network is in range an unassociated to any wireless network.
* You have another device as your attack machine.

#### Step 1

If we start airodump-ng, we can see our client is sending Probe Request searching for pre-configured networks. 

```bash
airodump-ng -w <outfile> <interface>
```

{% hint style="info" %}
As Probe Request will be sent out on all channels, a good tip is to fix the channel in `airodump-ng` using the `-c` option.
{% endhint %}

#### Step 2

Rogue AP / evil-twin. We need to perform the Caffe-Latte attack:

```bash
airbase-ng -c <channel> -W 1 -L -e <SSID> <interface>
# -L enable Caffe-Latte attack
# -e sets airbase-ng to act as an AP for the specified SSID
# -c fixes the wireless channel
# -W 1 force airbase-ng to not set the WEP Privacy Bit in beacons
```

Results should show clients associated to our fake AP and `airbase-ng` automatically starts the Caffe-Latte attack for us, incrementing the number of data packet rate as we collect the IVs \(see this in your on-going `airodump-ng`\).

We now just wait to gather a sufficient amount of encrypted packets. In the meantime, we can start `aircrack-ng` and feed it with the capture file from `airodump-ng`. 150000 IVs should be enough to decrypt the key.

{% hint style="info" %}
**Hirte Attack \(\`-H\`\)**

There is a variation to this attack that you can perform while using `airbase-ng.` 

This attack uses the same tactics targeting the client but also uses frame fragmentation to achieve a higher speed as the same ARP request can be split into multiple shorter encrypted frames. 

If the attack doesn't not work for you, you can still fallback on the classic Caffe-Latte.
{% endhint %}
{% endtab %}
{% endtabs %}

#### WPA and WPA2

{% hint style="info" %}
**The Four-Way Handshake**

Attacks against WPA/WPA2 keys are much less diversified than those targeting WEP. Until now, WPA has proved to be robust security measure to provide effective privacy for wireless networks. WPA and its successor WPA2 fixed the various flaws that plagued WEP, making it impossible to just look at the traffic to get information about the key.

When a new client wants to join a WPA/WPA2 protected network, it must first authenticate itself, proving it owns the shared key. After association, the two parties start what is called _the four-way handshake_, which is a process that permits the mutual authentication between the AP \(called Authenticator\) and the STA \(called Supplicant\).

During the communication, the PSK is never sent through the wireless medium. The PSK is only used to generate a PTK \(Pairwise Transient Key\) that is used as session-only encryption key.

Since the PSK is never transmitted, both AP and STA need a secure way to generate the PTK. This is what the 4-way handshake does.
{% endhint %}

![The 4 way handshake](../.gitbook/assets/image%20%2880%29.png)

#### Steps of the 4-way handshake

**Step 0**

At first the shared passphrase is used to generate the so-called PMK \(Pairwise Master Key\), which is 256bits long.

Both the STA and AP independently calculate this value combining the PSK and SSID name.

**Step 1/4**

When the handshake starts, the AP sends the STA a message containing a `nonce` , a security cryptographic random number. In the WPA specification, this number is called `Anonce` \(as Authenticator Nonce\).

**Step 2/4**

STA generates another nonce, called `SNonce` \(Supplicant Nonce\), and builds the PTK containing the PMK, both nonces, the MAC addresses of AP and STA and processing this product through a cryptographic hash function called `PBKDF2-SAH1`.

**Step 3/4**

STA then sends its `SNonce` to the AP that can now build the PTK. As it uses the same information, both PTKs will be the same without the original PSK ever being transmitted over the air. This third message also contains a MIC \(Message Integrity Code\) which is used to authenticate the sending STA. 

**Step 4/4**

Finally, the AP replies back with a message containing the GTK \(Group Temporal Key\) used to decrypt multicast and broadcast traffic. This message is also authenticated by means of MIC. An acknowledgment concludes the process.

#### Perform an attack

#### Capturing the Handshake

**Setup LAB** 

* AP SSID: LabNetwork, channel 11, WPA enabled.
* 1 vicitim STA associated to the AP
* The attacker PC

Capturing the handshake is actually quite simple. Launch `airodump-ng` and start sniffing on the correct channel:

```bash
airodump-ng -w <outfile> -c <channel> <interface>
```

If we wanted to perform a totally passive attack, we could have waited for a new client to join the network but this could require more time.

Write down the client MAC address and launch the _deauth_ attack against it:

```bash
aireplay-ng -0 1 -a <BSSID> -c <client_mac> <iface>
```

If the victim STA is inside the reachable area of your wireless card, it will be forced to rejoin the network and you should be able to get a new 4-way handshake \(`airodump-ng` notifies when the handshake reception happens\).

Now that we have captured the handshake and it is stored into a file, it's time to crack it!

#### Use aircrack-ng against the handshake

`aircrack-ng` has two cracking options when it comes to WPA/WPA2 keys:

1. Dictionary Attack \(also available for WEP\)
2. Pure brute force attack

{% hint style="info" %}
Before using brute force, it is always recommended to at least try a dictionary attack, this is because it may be possible to recover the password \(even if long or complex\) with a fraction of the time if compared with a brute force attempt.
{% endhint %}

```bash
aircrack-ng -w <wordlist(s)> <.cap file>

# Example:
aircrack-ng -w /usr/share/wordlists/nmap.st wpa-file.cap
```

The syntax is very simple, you only have to provide a wordlist file \(or comma-separated list\) and the path to your `.cap` file containing the captured handshake. This is the file saved by `airodump-ng` at the previous step.

#### Build a wordlist with crunch

`crunch` will generate all of the possible combination of words between the two length values. 

```bash
crunch <min_length> <max_length>

# Hint: start with a minimum length of 8 as routers and APs require 
#  a passphrase at least that long. 
# crunch will output the words to the console by default. 

# consult "man crunch" for a complete reference

crunch 8 8 -o my_words.lst # to generate 1.8 TB of data

# without dumping words into a file and save disk space:
crunch 8 8 | aircrack-ng -e LabNetwork file.cap -w -
```

{% hint style="warning" %}
**Notes on Speed**

* If you want to compare your computing power, you can run a simple test with `aircrack-ng` itself: `aircrack-ng -S`
* Exploiting GPU power tools
  * `oclHascat`: supports many hashing functions and cryptographic algorithms but if you want to be able to discover the key from a WPA/WPA2 handshake, you'll need to transform the `.cap` file to a format understandable by the program \(`.hccap`\). There's an [online tool](https://hashcat.net/cap2hccap/) for this purpose. You can also use `aircrack-ng` with the `-J` option.
  * `Pyrit`
  * `John the Ripper`

```bash
oclHashCat -m 2500 <.hccap file> <wordlist_file>
# -m 2500 crack a WPA/WPA2 handshake
```

"Cracking as a Service" can be an option for those without a powerful GPU. These services only require you to upload the `.cap` file containing the 4-way handshake and specify the target SSID. Once you have uploaded the file, you often choose between a series of different dictionaries so if you have a clue of the key, you can better restrict the search. Please note that most powerful services need you to pay a small fee. 

* CloudCracker
{% endhint %}

{% hint style="info" %}
**Space-time tradeoff**

As _the last option available in your toolbox_, we will present you an alternative bruteforce method that can be particularly useful in some occasions. 

A recent trend in the password cracking field make use of the time-space tradeoff to pre-calculate large amount of hashes and store them in so-called **rainbow-tables.**

**Rainbow tables**

Brute forcing a WPA or WPA2 key is only possible when you get a 4-way handshake from a client and the AP. Both parties generates a PTK that is uses to encrypt subsequent communications.

MICS are computed using the generate PTK and thus provide guarantee that both parties originally had the same PSK.

Every PSK you want to try against the handshake, you first need to calculate the PMK. Then using the values obtained from the handshake, generate the PTK. Finally you calculate the MIC and compare it with the one in the handshake. If they are equal, you have foudn the correct PSK.

_Beware this process is slow!_

In fact, the algorithm used to calculate the PMK, called `PBKDF2` requires running 4096 iterations of the HMAC algorithm that is actually designed to be computationally expensive.

One way to speed up this process is to pre-calculate the PMK for all of the various passphrases in your wordlist.

In theory, this would be a huge speed improvement as now every time you want to crack WPA handshake, you only have to generate the PTK and compare MICs; both of these operations are much faster than the `PBKDF2` function.

However, WPA authors thought about this possibility when they were designing the protocol and they came up with a pretty clever but simple solution.

> The calculation of the PMK does not only depend on the used PSK but it also depends on the network's SSID value!

Given that you cannot have universally acceptable PMKs but you must calculate them for each SSID name you are interested in cracking.

Even with the mentioned limitation, a rainbow table approach is still applicable to WPA cracking. It is also the case that a lot of APs are configured with standard factory values like "default", "linksys", "dlink" or similar vendor-related SSIDs.

With these theoretic bases, let's figure out how to create a PMKs database.

### Pyrit

Python-based application compatible with Linux, Mac OS X and BSD. `pyrit` uses a file-based storage to persist its database:

```bash
> pyrit eval
```

`pyrit` will "connect" to the local file and get some statistics about currently stored passwords. At first, obviously you will have 0 passwords.

Let's import some passwords from our wordlist:

```bash
> pyrit -i <wordlist_file> import_passwords
```

`pyrit` will process the input file and automatically discard all duplicates and all the words that are not suitable for a PSK \(also short\). Will also remove all the unusable passwords.

> **Note** you will need large wordlists to have any success while cracking WPA.

Now to generate the PMKs, we must provide `pyrit` with at least one SSID. In order to do this, we use `create_essid` command:

```bash
> pyrit -e <ssid> create_essid
```

This last command will not actually start the building process. In fact, try to re-eval the database:

```bash
> pyrit eval
```

Still, our newly added SSID does not have calculated PMKs. The number of calculated PMKs for our `LabNetwork` SSID is still zero. The last step of the process is launching the `batch` command which has a very simple syntax:

```bash
> pyrit batch
```

At this point, `pyrit` will start building your database for the included SSIDs and password combinations. Database generation could be a very long process, depending on the power of your CPU and the number of passwords you imported. `pyrit` can make use of the computational power of modern GPUs, like `oclHashCat`, so you are encouraged to run it on a desktop PC with a recent video card installed.

Now launch this command to initiate the attack against the handshake:

```bash
> pyrit -r <.cap file> attack_db
```

`pyrit` will try all of the different PMKs in its database very quickly and will eventually output the found key if it was initially in your wordlist. The focal point here is the speed.

> Having a pre-built database for a given SSID can tremendously speed up your attack.

### Pre-built hash files

On the internet you can find pre-built PMKs databases for the most common SSID names.

* Church of WiFi WPA-PSK Lookup Tables
  * [https://www.renderlab.net/projects/WPA-tables/](https://www.renderlab.net/projects/WPA-tables/)
  * 2 databases
    * 172000 words X 1000 SSIDs: 7GB
    * 1 Million words X 1000 SSIDs: 33GB
* Google
  * SSID rainbow table
  * SSID PMK database
{% endhint %}

#### WPS: Wireless Protected Setup

In 2011, Stefan Viehbock published a paper describing a new attack against WPS \(Wireless Protected Setup\).

{% embed url="https://sviehb.files.wordpress.com/2011/12/viehboeck\_wps.pdf" %}

WPS was designed a simple and secure way to setup a protected wireless network.

Stefan also found that design and implementation flaws in various devices may lead to a very effective attack method that can disclose the wireless encryption key.

WPS provides 3 different setup alternative methods:

* Push-Button-Connect
* Internal-Registrar
* External-Registrar

While the former two methods require stronger authentication procedures \(physical access or web interface access\) the External-Registrar method only requires the client to provide a PIN \(8 digits\).

> Normally, bruteforcing a 8 digits number will require testing for 10^8 \(=1000000000\) combinations but the actual form of authentication used by WPS highly reduces this number.

This is the representation of the WPS PIN number:

| 1st half of PIN \(4 bits\) | 2nd half of PIN \(4 bits\) |
| :--- | :--- |
| 0, 1, 2, 3 | 4, 5, 6, 7 \(7 = checksum digit\) |

It's divided into two halves of 4 digits each. The last digit of the 2nd half is a checksum meaning it is always calculated from the other digits.

The authentication process works like this:

1. Both AP and client initialize encryption keys and internal state
2. Client proves possession of 1st half of the PIN
3. Client proves possession of 2nd half of the PIN
4. AP sends network security configuration

At every step, if the client is sending wrong data the AP terminates the process and sends a `NACK` packet.

This behavior, combined with the split PIN allows us to build a quite optimized brute force attack.

![](../.gitbook/assets/image%20%2879%29.png)

> **How many combinations do we need to try?**
>
> Splitting the PIN get us from 10^8 to 10^4 + 10^4 \(=20000\) while having a checksum digit reduces the number of guesses for the 2nd half and we get the final result of only **10^4 + 10^3 \(=11000\)** combinations.

There are two tools that can help to exploit this vulnerability:

* Reaver
* Bully

{% hint style="info" %}
**Reaver \(& wash\)**

Developed by Tactical Network Solutions. It has both an open-source and a paid version that features a friendlier GUI and other goodies.

`reaver` also comes with aa secondary tool called `wash`that can be used to find vulnerable APs.

To be able to attack WPS, you must first be sure the target AP has WPS enabled. Inside `reaver` package you can find `wash` that servers this purpose.

With your monitor interface up and running, launch:

```bash
> wash -i <interface>
```

`wash` will start hopping through the wireless channels and will list discovered APs that support WPS.

`wash` output offers other useful information apart from signal level \(`RSSI` column\) you can find `WPS Locked` column. If the value is `YES` you will find the corresponding AP disabled WPS due to internal anti-bruteforce protection mechanisms, being a major hurdle for the WPS attacks.
{% endhint %}

{% hint style="info" %}
**Bully**

`bully` is opensourced on GitHub. It has some advantages over `reaver` such as fewer dependencies and a build process optimized for embedded devices. It also has features to handle anomalous scenarios.

Once you are sure your target AP is vulnerable to the attack \(with `bash`\) you can launch `bully` with the following command:

```bash
> bully -b <BSSID> <interface>
```

Where BSSID is the target AP's MAC address.

`bully` will start trying every possible PIN in randomized order. On average, you will need to try 50% of the possible PIN numbers which is roughly 5500 WPS requests. The time it could take varies depending from the AP as well as the quality of the signal.

In the best scenario, you will probably need a few hours to complete the attack and get the WPA/WPA2 key back.
{% endhint %}

WPS attacks have been around since 2011. Since then, many vendors have upgraded their devices and AP firmware now contains a protection against PIN bruteforce. This protection is called **WPS Lockdown** and it's simply a self-defense procedure that temporarily disables WPS registration if a repeated number of attempts to register is detected.

When your attack is detected, an AP can lockdown the WPS registration procedure for a time that varies between a few seconds to one hour or more. Some devices could even require a complete reboot.

If `bully` detects a lockout, it will normally display the following output and then wait for 43 seconds before next attempt. On the other hand, you can also disable lockout detection in `bully` and force it to continue the attack but this is not recommended.

```bash
> bully -b <BSSID> -L <interface>
```

The `-L` switch is used to disable lockdown detection.

A better option to avoid being locked out is to add a certain delay after every PIN attempt. By adding a pause between each try, you could bypass the attack detection system and get a smoother bruteforce attack. 

This will increase the needed time to test each PIN; most of the time, this will be the only viable solution given that newer firmware disables WPS registration for hours after multiple authentication attempts are detected in a few seconds.

The syntax to use to enable delay for the bully command goes as follows:

```bash
> bully -b <BSSID> -1 <seconds> -2 <seconds> <interface>
```

Where the `-1` option controls the delay in the first phase of the attack \(first half of the PIN\) and `-2` options sets the delay value for the second phase. Values of 60 seconds or more are recommended for most APs.

{% embed url="https://www.aircrack-ng.org/" %}

{% embed url="https://www.aircrack-ng.org/doku.php?id=arp-request\_reinjection" %}

{% embed url="https://www.aircrack-ng.org/doku.php?id=packetforge-ng" %}

{% embed url="https://www.slideshare.net/AirTightWIPS/toorcon-caffe-latte-attack" %}

{% embed url="http://www.tcpipguide.com/free/t\_TCPIPAddressResolutionProtocolARP.htm" %}

{% embed url="https://eprint.iacr.org/2007/120.pdf" %}



{% embed url="https://www.aircrack-ng.org/doku.php?id=airbase-ng" %}

{% embed url="http://www.tcpipguide.com/free/t\_TCPIPAddressResolutionProtocolARP.htm" %}



### ▶ WEP Cracking

### ▶ WPA Capture Attacks

## Wi-Fi as Attack Vectors

### Wi-Fi as Attack Vectors

### ▶ Rogue Access Point

### ▶ Evil Twin Attack with Mana Toolkit Pt. 1

### ▶ Evil Twin Attack with Mana Toolkit Pt. 2

