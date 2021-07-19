---
description: Kali post-installation hit-list.
---

# Kali

## Update/Upgrade OS + Install Apps

```text
sudo apt update -y && sudo apt upgrade -y
sudo apt install terminator code-oss -y
```

* [ ] Remove desktop background image
* [ ] Power Manager &gt; Display Power Management &gt; Disable
* [ ] Power Manager &gt; Security &gt; Automatically lock the session &gt; Never
* [ ] Power Manager &gt; Security &gt; Lock screen when system is going to sleep &gt; Disable
* [ ] [http://manicai.net/comp/swap-caps-ctrl.html](http://manicai.net/comp/swap-caps-ctrl.html)
* [ ] Remove login screen at boot

```text
 > sudo vi /etc/lightdm/lightdm.conf
 
[Seat:*]
autologin-user=kali
autologin-user-timeout=0
autologin-session=lightdm-xsession
```

## References

{% embed url="https://askubuntu.com/questions/530072/how-to-auto-login-in-xubuntu-or-ubuntu-server-with-xfce" %}



