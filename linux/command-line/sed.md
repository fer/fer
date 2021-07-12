---
description: 'http://www.pement.org/sed/sed1line.txt'
---

# sed



{% hint style="info" %}
You can use this information as tutorial if you wish.

Practice sed commands by generating the following files:

```bash
mkdir sed-files
cd sed-files
touch myfile-{1..20}.md
ls -la >> myfile-{1..20}.md
```
{% endhint %}

\*\*\*\*

## **Rename files massively**

```bash
ls | awk '{print("mv "$1" "$1)}' | sed 's/this/that/2' | /bin/sh
```

## Substitute string across a file

```bash
sed -i s/regexp/subst/g file
```

