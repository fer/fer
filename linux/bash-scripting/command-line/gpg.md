---
description: Use gpg to encrypt files in your system
---

# gpg

**Encrypt a file**

It will prompt for a passphrase you'll want to remember:

```text
gpg -c --cipher-algo AES256 fichero.txt
```

**De-cyphering a file** 

```text
gpg -d fichero.txt.gpg
```

