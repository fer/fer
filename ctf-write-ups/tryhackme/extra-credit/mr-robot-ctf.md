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
{% embed url="http://10.10.235.2" %}

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

