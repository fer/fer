# BB3

## Prework

### Connect to VPN

```bash
sudo openvpn black-box-penetration-test-3.ovpn
```

### Scan network

```bash
sudo nmap -sn 172.16.37.0/24 -oN hostAlive.nmap &&
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt &&
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml &&
nmap2md.sh portScan.xml | xclip
```

## Scanner

> Generated on **Sun Jul 18 11:53:14 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml
```

## Hosts Alive \(2\)

| Host | OS | Accuracy |
| :--- | :--- | :--- |
| 172.16.37.220 | Linux 3.11 - 4.1 | 95% |
| 172.16.37.234 | Linux 3.11 - 4.1 | 95% |

## Open Ports and Running Services

### 172.16.37.220 \(Linux 3.11 - 4.1 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 80/tcp | open | http | Apache httpd 2.4.18 |
| 3307/tcp | open | tcpwrapped |  |

{% tabs %}
{% tab title="Dirbuster" %}
* Target URL: [http://](http://172.16.64.81)172.16.37.220
* File Extension: \*
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt
{% endtab %}

{% tab title="Report" %}
```bash

```
{% endtab %}
{% endtabs %}

### 172.16.37.234 \(Linux 3.11 - 4.1 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 40121/tcp | open | ftp | ProFTPD 1.3.0a |
| 40180/tcp | open | http | Apache httpd 2.4.18 |

