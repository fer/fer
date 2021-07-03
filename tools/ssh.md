---
description: >-
  Know ssh, and the basics of passwordless authentication, via ssh-agent,
  ssh-add, etc.
---

# ssh

## **Append your key to a server's authorized keys file**

```bash
function authme {
   ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}
```

## References

* [SSH: Best practices](https://www.howtoforge.com/ssh-best-practices)
* [Easy SSH for Admins on Mac OS X](http://sysadmin.flakshack.com/post/4842226032/easy-ssh-for-admins-on-mac-os-x)
* [analyzing-malicious-ssh-login-attempts](http://www.symantec.com/connect/articles/analyzing-malicious-ssh-login-attempts)
* [Bastionando SSH](https://www.securityartwork.es/2015/11/25/bastionando-ssh-ii/?utm_source=twitterfeed&utm_medium=twitter&utm_campaign=Feed:+SecurityArtWork+%28Security+Art+Work)

## **SSH key management**

gpg-agent can handle GPG keys as well as SSH keys. In order to use your SSH key with gpg-agent you have to run ssh-add once to store the key's fingerprint in ~/.gnupg/sshcontrol.

