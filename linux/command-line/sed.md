---
description: 'http://www.pement.org/sed/sed1line.txt'
---

# sed



{% hint style="info" %}
You can **use this information as tutorial** if you wish.
{% endhint %}

{% hint style="success" %}
**Practice sed commands by generating the following files**

\*\*\*\*

```bash
mkdir sed-files
cd sed-files
touch myfile-{1..20}.md
ls -la >> myfile-{1..20}.{md,txt}
```
{% endhint %}

## **Rename files massively**

{% tabs %}
{% tab title="Input" %}
```bash
ls *.txt | awk '{print("mv "$1" "$1)}' | sed 's/myfile/text/2' | /bin/sh
```
{% endtab %}

{% tab title="Output" %}
```bash
[~/sed-files] ls -la                                                                                                                                                   2 ⨯
total 168
drwxr-xr-x 2 kali kali 4096 Jul 12 07:56 .
drwxr-xr-x 6 kali kali 4096 Jul 12 07:39 ..
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-10.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-11.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-12.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-13.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-14.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-15.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-16.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-17.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-18.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-19.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-1.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-20.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-2.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-3.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-4.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-5.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-6.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-7.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-8.md
-rw-r--r-- 1 kali kali 3424 Jul 12 07:52 myfile-9.md
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-10.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-11.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-12.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-13.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-14.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-15.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-16.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-17.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-18.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-19.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-1.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-20.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-2.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-3.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-4.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-5.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-6.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-7.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-8.txt
-rw-r--r-- 1 kali kali 2258 Jul 12 07:52 text-9.txt

[~/sed-files] ls * | wc -l                     
40
[~/sed-files] ls *.txt | wc -l                 
20
[~/sed-files] ls *.txt | wc -l                 
20
```
{% endtab %}
{% endtabs %}

## Substitute string across a file

```bash
sed -i s/regexp/subst/g file
```



