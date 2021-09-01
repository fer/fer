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



















## 

## 

## 

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

![The 4 way handshake](../../.gitbook/assets/image%20%2880%29.png)

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

![](../../.gitbook/assets/image%20%2879%29.png)

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

As a penetration tester, you should know that Wi-Fi networks are not only interesting as an attack point but can turn out to be useful attack vector too.

#### Rogue AP

In some situations it's simpler to get a wireless client to connect to our attacking system instead of recovering the network WEP or WPA key.

> Caffe-Latte attack consisted in tricking a wireless client into connecting to a fake AP with the purpose of collecting a sufficient long keystream. 
>
> With that keystream, we are able to forge our packets and flood the client itself with ARP requests, collecting a lot of IVs.

Imagine being able to to set up a "Free Wi-Fi" Access Point to control all of the communications through it.  As you are totally in control of the packet flow, you could launch all of your favorite attacks you have learned to apply in the wired word such as MitM, ARP poisoning, traffic sniffing or even browser vulnerabilities.

{% hint style="info" %}
**airbase-ng**

* Implementations of the Caffe-Latte and Hirte attacks
* Act as _ad-hoc_ or _infrastructure_ AP
* Encrypt and decrypt traffic
* Can capture WPA/WPA2 handshakes
* Packets manipulation and external commands
* Filtering by BSSID or client MAC

Given that `aribase-ng` has a pretty list of options, you are encouraged to take a look at its own man page.
{% endhint %}

Imagine this simple situation:

* Sam is an employee at "ACME Corporation"
* There's a Wi-Fi network called "ACMEWiFi" at his workplace
* This Wi-Fi network is using WEP encryption and Shared Key authentication
* Sam normally takes a cup of tea at his preferred bar.
* Unfortunately, he also has some backlog so he boots up his notebook to continue working on ACME's matters while sitting at the bar table.
* Sam's notebook will start to probe the neighborhood area in order to discover available networks.

> **Attack**
>
> If we could set up a fake AP that spoofs the "ACMEWifi" SSID name and advertise itself as a WEP network, we could trick Sam's notebook into starting an authentication/association message exchange with our machine!
>
> The objective of the attack is getting Sam's notebook to connect to the fake AP.
>
> Since Shared Key Authentication is enabled, you will be able to recover a good amount of keystream \(generally 140 bytes\) which is more than what you need to forge your own ARP requests with packetforge-ng.

> **Recover PRGA with a rogue AP**
>
> Here's our setup:
>
> * A victim client unassociated from any AP
> * Our attacking machine \("fake" AP\)
>
> ```bash
> > airmon-ng start <interface>
> > airodump-ng  -c <channel> -w <outfile> <interface>
> # You will need to lock the wireless card to a specific channel.
>
> > airbase-ng -c <channel> -e <SSID> -s -W 1 <interface>
> # -F <file> let airbase-ng save all of the captured information to a file
> # -s force the client to authenticate using the SKA method
> # -W 1 instructs airbase-ng to set the WEP bit in the beacons 
> # as some clients can get confused otherwise.
>
> # At this point you should have gotten a keystream after the victim client
> # connected to the fake AP. airodump-ng should see a SKA handshake was captured
> # and saved in a .xor file for our convenience.
> ```

> **Initiate a WPA/WPA handshake**
>
> We can also use the same technique to obtain a WPA/WPA2 handshake. Configure your client network connection as WPA2 and give it a password. Then launch `airbase-ng` with these options:
>
> ```bash
> > airbase-ng -c <channel> -e <SSID> -W 1 -Z 4 <interface>
> # -Z is used to specify WPA2 optiosn while 4 stands for CCMP encryption scheme.
> ```
>
> The victim client can be tricked into connecting to the spoofed AP and we are able to collect the WPA2 handshake, whenever the client was able to associate.
>
> To prove the attack really worked, we try to crack the captured handshake by passing `aircrack-ng` the configured password through a shell "pipe":
>
> ```bash
> echo largecream | aircrack-ng file.cap -e <SSID> -q -w -
> ```
>
> This is just a convenient way to test one password. Notice we used a dash after the `-w` option to instruct `aircrack-ng` to use the standard input as word list source.
>
> The fun part of this attack is that **we were able to get a real handshake without actually knowing the network PSK.** How is this possible?
>
> In the first message of the 4-way handshake, the AP sends an Anonce to the authenticating client which in turn sends its SNonce plus the MIC. Now the AP has all of the needed information to actually try to crack the PSK, the subsequent steps in the handshake are not eve needed.

> **Man in the Middle Attack**
>
> Setup:
>
> * A victim client unassociated from any AP
> * The attacker machine should be connected to the internet through a wired interface
>
> You will need Internet access on the attack point as we will be running MitM attacks that require packet forwarding towards the real destination in order to sniff the resulting traffic.
>
> Steps:
>
> 1. Set up a fake AP
> 2. Start a DHCP server to provide the network configuration to connecting clients
> 3. Forward all the traffic toward the Internet but ...
> 4. .. act as MitM eavesdropping all the communications
>
> ```bash
> # First we put the wireless interface into monitor mode as we always do:
> > airmon-ng
> # Start airbase-ng and setup AP with a catch SSID name
> > airbase-ng -c <channel> -e "Free Internet" <interface>
>
> # Create a network bridge interface with the following commands:
> > sudo apt-get install bridge-utils
> > brctl addbr br0
> > brctl addif br0 eth0
> > brctl addif br0 at0
> # br0: is the name of the bridge interface we are creating
> # eth0: wired interface
> # at0: virtual interface created by airbase-ng
>
> # Now that we have created a bridge between the airbase-ng virtual interface
> # and our wired interface, we need to assign an IP address to it:
> > ipconfig br0 <ip_address> up
>
> # enable IP packet forwarding:
> > echo 1 > /proc/sys/net/ipv4/ip_forward
> ```
>
> All of the Internet directed traffic from the victim client is already being forwarded through the attack machine. To confirm everything is working fine, you can try to browse a website from your victim client. You should be able to load it correctly. 
>
> Now that you are controlling all of the traffic flowing from and towards the client, you can try to steal confidential data such as website credentials as in the classic MitM attack. 
>
> Fire up your favorite sniffing tool and start listening on your virtual wireless interface
>
> ```bash
> > tcpdump -nvi <interface> tcp port 80 -A
> ```
>
> From the victim client, we now ingenuously browse to a sample website. In such website a form where the user is required to insert login and password in order to access a secured area
>
> Shortly after the POST HTTP request, `tcpdump` output will dump the user credentials on your screen.
>
> More possibilities:
>
> * Redirect DNS Requests
> * Change web page content
> * Harvest user information
> * Inject browser-specific payloads to exploit browser vulnerabilities

> **Rogue AP: an alternative definition**
>
> The following is an alternative definition of rogue AP: it's an unmanaged and unauthorized wireless AP attached to an enterprise wireless network. 
>
> A rogue AP could have been installed by a legitimate user unaware of the security implications or on purpose for an insider attack. An outsider can also install the AP inside the enterprise premises if insufficient physical security measures are used.
>
> Rogue APs represent a major security threat as they create a wireless backdoor on the internal wired network that bypasses all of the perimeter defenses like firewalls and IDS.
>
> In many occasions they are installed by security-illiterate employees and configured with poor encryption scheme as WEP or worst, left completely open.
>
> A typical example of Rogue AP is the one set up by an employee willing to share the company's Internet connection with mobile devices or the same employee could bring an AP to connect from its laptop and bypass internal security policies just to be able to surf social network sites.
>
> In all cases, wireless signal could reach past the company premises.
>
> A pentester with good wireless equipment will then be able to try a series of attacks.
>
> In the simplest case, the attacker can passively scan the wireless medium to collect information about network configuration, hostnames and IPs.
>
> Sensitive information could also be disclosed such as usernames, passwords or emails \(especially if the wireless network uses no encryption\).

> **Rogue AP: Evil Twin Attack**
>
> We setup a rogue access point to mimic an existing known access point, we can use an Evil Twin attack combined with a bit of social engineering to obtain a WPA2 networks' Pre-shared key without the need to conduct a cryptographic attack against the WPA2 protocol itself.
>
> A typical flow for an Evil Twin attack is as follows:
>
> 1. Replicate a known Access Point ESSID via creation of an access point with hostapd.
> 2. De-authenticate a station that is associated to the "real" AP.
> 3. Station reconnects to "Evil Twin" AP.
> 4. The user, upon launching a browser is presented with a web page over HTTP requesting SSID for an "Important Firmware Upgrade"
> 5. We receive the SSID in plain-text via the HTTP page.
>
> As "all-in-one" toolkit we can use to conduct this type of attack is known as **Mana**.
>
> Mana allows us to quickly spin up a rogue access point, configure the necessary DHCP settings and with some modifications to the default configuration, we can host our own web page to be served to a connected station.
>
> **Important!** The attacker AP should be in close proximity to a station already connected to the legitimate AP. This way, upon de-authentication of the client, the client should auto-reconnect to the AP with the stronger signal \(the attacker-controlled AP\).

> **Attacks against WPA2-Enterprise**
>
> WPA2-Enterprise introduced several improvements to the WPA2-PSK model in regards to security, primarily with the support of 802.1x authentication, and therefore, requires its own set of tools and changes to the way we traditionally perform attacks against wireless networks.
>
> In the traditional WPA2-PSK model, we typically have a client \(supplicant\) that connects to an access point \(authenticator\), the usual "two-party" scenario.
>
> With WPA2-Enterprise, we introduce a third-party "Authentication Server", which is usually a system that supports the RADIUS and Extensible Authentication \(EAP\) protocols.
>
> * **Initialization:** On detection of a new supplicant, the port on the switch \(authenticator\) is enabled and set to the "unauthorized" state. In this state, only 802.1X traffic is allowed; other traffic such as the Internet Protocol \(and with that TCP and UDP\) is dropped.
> * **Initiation:** to initiate authentication will periodically transmit EAP-Request Identity frames to a special Layer 2 address \(01:80:C2:00:00:03\) on the local network segment. The supplicant listens on this address and on receipt of the EAP-Request Identity frame it responds with an EAP-Response Identity frame containing an identifier for the supplicant such as a User ID. The authenticator then encapsulates this Identity response in RADIUS Access-Request packet and forwards it on to the authentication server. The supplicant may also initiate or restart authentication by sending an EAPOL-Start frame to the authenticator, which will then reply with an EAP-Request Identity frame.
> * **Negotiation:** technically EAP negotiation, the authentication server sends a reply \(encapsulated in a RADIUS Access-Challenge packet\) to the authenticator, containing an EAP Request specifying the EAP Method \(the type of EAP based authentication it wishes the supplicant to perform\). The authenticator encapsulates the EAP Request in an EAPOL frame and transmits it to the  supplicant. At this point, the supplicant can start using the requested EAP method, or do a NAK \(negative acknowledgement\) and respond with the EAP methods it is willing to perform.
> * **Authentication:** if the authentication server and supplicant agree on an EAP Method, EAP Requests and Responses are sent between the supplicant and the authentication server \(translated by the authenticator\) until the authentication server responds with either an EAP-Success message \(encapsulated in a RADIUS Access-Accept packet\), or an EAP-Failure message \(encapsulated in a RADIUS Access-Reject packet\). If authentication is successful, the authenticator sets the port to the "authorized" state and normal traffic is allowed; if it's unsuccessful, the port remains in the "unauthorized" state. When the supplicant logs off, it sends an EAPOL-logoff message to the authenticator, the authenticator then sets the port to the "unauthorized" state, once again blocking all non-EAP traffic.

> **Eaphammer: Attacking WPA2-Enterprise neworks**
>
> Aside from being able to automate Evil Twin attacks similar to the previously mentioned Mana toolkit, eaphammer allows us to steal RADIUS credentials, conduct hostile portal attacks to steal Active Directory credentials \(through Responder-type attacks\), and includes a host of other features we'll find useful during Wireless Penetration testing engagements:
>
> * Built-in Responder Integration
> * Support for Open networks and WPA-EAP/WPA2-EAP
> * No manual configuration necessary for most attacks
> * No manual configuration necessary for installation and setup process
> * Leverages latest version of hostapd \(2.6\)
> * Support for evil twin and karma attacks
> * Generate timed Powershell payloads for indirect wireless pivots
> * Integrated HTTP server for Hostile Portal attacks
> * Support for SSID cloaking

#### Wardriving

It's the act of searching for Wi-Fi networks by a person on a moving vehicle \(like a car\) using a portable computer, a smartphone or any other Wi-Fi enabled device.

The word originated from WarDialing, a practice that consisted of using a modem to automatically scan a list of telephone numbers searching for equipment as fax machines, modems or other systems.

The main objective of wardriving is creating a map of Wi-Fi access points in a specific area.

The map can then be used to observe AP distribution and characteristics like SSID names or encryption type \(if used\).

To start wardriving, all you need is a good GPS receiver, a Wi-Fi enabled device and, obviously a vehicle.

These days, most smartphones available on the market have decent Wi-Fi capabilities and an integrated GPS sensor so they can actually be used as wardriving devices, however you can not expect the same level of signal range than a good wireless adapter with a proper antenna could get.

WiGLE.net is a website that collects all of the user uploaded information and build constantly updated maps of Wi-Fi Access Points around the world.

After the drive, we use an app functionality which allows one to export the database of found APs in KML.

{% embed url="https://github.com/sensepost/mana" %}

{% embed url="https://en.wikipedia.org/wiki/IEEE\_802.1X" %}

{% embed url="https://en.wikipedia.org/wiki/Evil\_twin\_\(wireless\_networks\)" %}

{% embed url="https://wigle.net/" %}

{% embed url="https://en.wikipedia.org/wiki/RADIUS" %}

{% embed url="https://github.com/s0lst1c3/eaphammer" %}

### ▶ Rogue Access Point

### ▶ Evil Twin Attack with Mana Toolkit Pt. 1

### ▶ Evil Twin Attack with Mana Toolkit Pt. 2

