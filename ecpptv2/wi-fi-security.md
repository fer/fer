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

These controllers use the common Mini PCI \(or more recently, Mini PCI-Express\) bus and are teotally integrated in the notebook chassis.

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



















## Wireless Standards and Networks

## Discover Wi-Fi Networks

### Discover Wi-Fi Networks

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
{% endtab %}
{% endtabs %}

























































#### WPA and WPA2 

#### WPS

### ▶ WEP Cracking

### ▶ WPA Capture Attacks

## Wi-Fi as Attack Vectors

### Wi-Fi as Attack Vectors

### ▶ Rogue Access Point

### ▶ Evil Twin Attack with Mana Toolkit Pt. 1

### ▶ Evil Twin Attack with Mana Toolkit Pt. 2

