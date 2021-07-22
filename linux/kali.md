---
description: Kali post-installation hit-list... Work in progress!
---

# Kali

{% hint style="danger" %}
**This document is still in progress...** 
{% endhint %}

## 1. Update/Upgrade OS + Install Apps

```text
sudo apt update -y && sudo apt upgrade -y && sudo apt-get dist-upgrade
sudo apt install terminator code-oss jq -y 
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
* [ ] Remove Desktop Icons \(Home, File System... leave only Trash and Removable Devices\)
* [ ] Change Download Directory, Documents Directory, Pictures:
* [ ] ```text
  cat ~/.config/user-dirs.dirs                                           1 ⨯

  # This file is written by xdg-user-dirs-update
  # If you want to change or add directories, just edit the line you're
  # interested in. All local changes will be retained on the next run.
  # Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
  # homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
  # absolute path. No other format is supported.
  # 
  XDG_DESKTOP_DIR="$HOME/Desktop"
  XDG_DOWNLOAD_DIR="$HOME/Desktop"
  XDG_TEMPLATES_DIR="$HOME/Templates"
  XDG_PUBLICSHARE_DIR="$HOME/Public"
  XDG_DOCUMENTS_DIR="$HOME/Desktop"
  XDG_MUSIC_DIR="$HOME/Desktop"
  XDG_PICTURES_DIR="$HOME/Desktop"
  XDG_VIDEOS_DIR="$HOME/Desktop"

  ```

  * Point Firefox/Chromium Download folder to Desktop
  * 

## References

{% embed url="https://askubuntu.com/questions/530072/how-to-auto-login-in-xubuntu-or-ubuntu-server-with-xfce" %}

{% embed url="https://serverfault.com/questions/10437/how-do-you-swap-the-caps-lock-to-control-in-xfce" %}

{% embed url="https://docs.vmware.com/en/VMware-Workstation-Pro/16.0/com.vmware.ws.using.doc/GUID-8A64D0EF-CB0E-4C50-A034-3FD5C0A0F905.html" %}





