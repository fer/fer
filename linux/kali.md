---
description: Kali post-installation hit-list.
---

# Kali

## 1. Update/Upgrade OS + Install Apps

```text
sudo apt update -y && sudo apt upgrade -y && sudo apt-get dist-upgrade
sudo apt install terminator code-oss -y
```

* [ ] Remove desktop background image
* [ ] Power Manager &gt; Display Power Management &gt; Disable
* [ ] Power Manager &gt; Security &gt; Automatically lock the session &gt; Never
* [ ] Power Manager &gt; Security &gt; Lock screen when system is going to sleep &gt; Disable
* [ ] [S](http://manicai.net/comp/swap-caps-ctrl.html)wap CAPS for CTRL 
  * [ ] Session and Startup &gt; Add &gt; `/usr/bin/setxkbmap -option "ctrl:nocaps"`
* [ ] Change kali user password.
* [ ] Remove login screen at boot

```text
 > sudo vi /etc/lightdm/lightdm.conf
 
[Seat:*]
autologin-user=kali
autologin-user-timeout=0
autologin-session=lightdm-xsession
```

* [ ] Encrypt VMWare disk
* [ ] Install FoxyProxy: [https://addons.mozilla.org/es/firefox/addon/foxyproxy-standard/](https://addons.mozilla.org/es/firefox/addon/foxyproxy-standard/)

## References

{% embed url="https://askubuntu.com/questions/530072/how-to-auto-login-in-xubuntu-or-ubuntu-server-with-xfce" %}

{% embed url="https://serverfault.com/questions/10437/how-do-you-swap-the-caps-lock-to-control-in-xfce" %}

{% embed url="https://docs.vmware.com/en/VMware-Workstation-Pro/16.0/com.vmware.ws.using.doc/GUID-8A64D0EF-CB0E-4C50-A034-3FD5C0A0F905.html" %}





