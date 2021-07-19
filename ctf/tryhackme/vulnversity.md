---
description: 'Learn about active recon, web app attacks and privilege escalation.'
---

# Vulnversity

## Task \#1: Deploy the Machine

```bash
sudo openvpn fer.opvn
```

## Task \#2: Reconnaisance

> Generated on **Mon Jul 19 07:27:50 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -A --open -oX portScan.xml 10.10.32.135
```

### Open Ports and Running Services

| State | Service | Version |  |
| :--- | :--- | :--- | :--- |
| 21/tcp | open | ftp | vsftpd 3.0.3 |
| 22/tcp | open | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 |
| 139/tcp | open | netbios-ssn | Samba smbd 3.X - 4.X |
| 445/tcp | open | netbios-ssn | Samba smbd 4.3.11-Ubuntu |
| 3128/tcp | open | http-proxy | Squid http proxy 3.5.12 |
| 3333/tcp | open | http | Apache httpd 2.4.18 |

## Task \#3: Locating directories in the webserver

{% hint style="success" %}
#### What is the directory that has an upload form page?

Dirbuster found the following route with an Upload form:

* [http://10.10.32.135:3333/internal/](http://10.10.32.135:3333/internal/)
{% endhint %}

{% tabs %}
{% tab title="OWASP Dirbuster 1.0-RC1 " %}
* Target URL: [http://10.10.32.135:3333/](http://10.10.32.135:3333/)
* File Extension: \*
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt
{% endtab %}

{% tab title="Report" %}
```bash

```
{% endtab %}
{% endtabs %}

## Task \#4: Compromise the webserver

#### Try upload a few file types to the server, what common extension seems to be blocked?

####  

