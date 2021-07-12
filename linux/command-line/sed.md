---
description: >-
  You can use this information as tutorial if you wish.
  http://www.pement.org/sed/sed1line.txt
---

# sed

## **Practice sed commands** 

Start by generating the following files. Check _Output_  tab to test your results.

{% tabs %}
{% tab title="Input" %}
```bash
mkdir sed-files
cd sed-files
touch myfile-{1..20}.md
ls -1 >> myfile-{1..20}.{md,txt}
```
{% endtab %}

{% tab title="Output" %}
```bash
[~/sed-files] ls -1 
myfile-10.md
myfile-10.txt
myfile-11.md
myfile-11.txt
myfile-12.md
myfile-12.txt
myfile-13.md
myfile-13.txt
myfile-14.md
myfile-14.txt
myfile-15.md
myfile-15.txt
myfile-16.md
myfile-16.txt
myfile-17.md
myfile-17.txt
myfile-18.md
myfile-18.txt
myfile-19.md
myfile-19.txt
myfile-1.md
myfile-1.txt
myfile-20.md
myfile-20.txt
myfile-2.md
myfile-2.txt
myfile-3.md
myfile-3.txt
myfile-4.md
myfile-4.txt
myfile-5.md
myfile-5.txt
myfile-6.md
myfile-6.txt
myfile-7.md
myfile-7.txt
myfile-8.md
myfile-8.txt
myfile-9.md
myfile-9.txt
```
{% endtab %}
{% endtabs %}

### **Rename files massively**

{% tabs %}
{% tab title="Input" %}
```bash
ls *.txt | awk '{print("mv "$1" "$1)}' | sed 's/myfile/text/2' | /bin/sh
```
{% endtab %}

{% tab title="Output" %}
```bash
[~/sed-files] ls -1
myfile-10.md
myfile-11.md
myfile-12.md
myfile-13.md
myfile-14.md
myfile-15.md
myfile-16.md
myfile-17.md
myfile-18.md
myfile-19.md
myfile-1.md
myfile-20.md
myfile-2.md
myfile-3.md
myfile-4.md
myfile-5.md
myfile-6.md
myfile-7.md
myfile-8.md
myfile-9.md
text-10.txt
text-11.txt
text-12.txt
text-13.txt
text-14.txt
text-15.txt
text-16.txt
text-17.txt
text-18.txt
text-19.txt
text-1.txt
text-20.txt
text-2.txt
text-3.txt
text-4.txt
text-5.txt
text-6.txt
text-7.txt
text-8.txt
text-9.txt

[~/sed-files] ls * | wc -l                     
40
[~/sed-files] ls *.txt | wc -l                 
20
[~/sed-files] ls *.txt | wc -l                 
20
```
{% endtab %}
{% endtabs %}

## Text Conversion and substitution

### Change "md" or "txt"  to "one"

{% tabs %}
{% tab title="Input" %}
```bash
sed 's/md/one/g;s/md/one/g;' myfile-1.txt
```
{% endtab %}

{% tab title="Output" %}
```bash
[~/sed-files] sed 's/md/one/g;s/txt/one/g;' myfile-1.txt
myfile-10.one
myfile-10.one
myfile-11.one
myfile-11.one
myfile-12.one
myfile-12.one
myfile-13.one
myfile-13.one
myfile-14.one
myfile-14.one
myfile-15.one
myfile-15.one
myfile-16.one
myfile-16.one
myfile-17.one
myfile-17.one
myfile-18.one
myfile-18.one
myfile-19.one
myfile-19.one
myfile-1.one
myfile-1.one
myfile-20.one
myfile-20.one
myfile-2.one
myfile-2.one
myfile-3.one
myfile-3.one
myfile-4.one
myfile-4.one
myfile-5.one
myfile-5.one
myfile-6.one
myfile-6.one
myfile-7.one
myfile-7.one
myfile-8.one
myfile-8.one
myfile-9.one
myfile-9.one

```
{% endtab %}

{% tab title="myfile-1.txt" %}
```
myfile-10.md
myfile-10.txt
myfile-11.md
myfile-11.txt
myfile-12.md
myfile-12.txt
myfile-13.md
myfile-13.txt
myfile-14.md
myfile-14.txt
myfile-15.md
myfile-15.txt
myfile-16.md
myfile-16.txt
myfile-17.md
myfile-17.txt
myfile-18.md
myfile-18.txt
myfile-19.md
myfile-19.txt
myfile-1.md
myfile-1.txt
myfile-20.md
myfile-20.txt
myfile-2.md
myfile-2.txt
myfile-3.md
myfile-3.txt
myfile-4.md
myfile-4.txt
myfile-5.md
myfile-5.txt
myfile-6.md
myfile-6.txt
myfile-7.md
myfile-7.txt
myfile-8.md
myfile-8.txt
myfile-9.md
myfile-9.txt
```
{% endtab %}
{% endtabs %}

## Selective deletion of certain rules

### Delete lines matching pattern

{% tabs %}
{% tab title="Input" %}
```bash
sed '/md/d' myfile-1.txt 
```
{% endtab %}

{% tab title="Output" %}
```bash
[~/sed-files] sed '/md/d' myfile-1.txt 
myfile-10.txt
myfile-11.txt
myfile-12.txt
myfile-13.txt
myfile-14.txt
myfile-15.txt
myfile-16.txt
myfile-17.txt
myfile-18.txt
myfile-19.txt
myfile-1.txt
myfile-20.txt
myfile-2.txt
myfile-3.txt
myfile-4.txt
myfile-5.txt
myfile-6.txt
myfile-7.txt
myfile-8.txt
myfile-9.txt
```
{% endtab %}

{% tab title="myfile-1.txt" %}
```
myfile-10.md
myfile-10.txt
myfile-11.md
myfile-11.txt
myfile-12.md
myfile-12.txt
myfile-13.md
myfile-13.txt
myfile-14.md
myfile-14.txt
myfile-15.md
myfile-15.txt
myfile-16.md
myfile-16.txt
myfile-17.md
myfile-17.txt
myfile-18.md
myfile-18.txt
myfile-19.md
myfile-19.txt
myfile-1.md
myfile-1.txt
myfile-20.md
myfile-20.txt
myfile-2.md
myfile-2.txt
myfile-3.md
myfile-3.txt
myfile-4.md
myfile-4.txt
myfile-5.md
myfile-5.txt
myfile-6.md
myfile-6.txt
myfile-7.md
myfile-7.txt
myfile-8.md
myfile-8.txt
myfile-9.md
myfile-9.txt
```
{% endtab %}
{% endtabs %}













To try out:

```bash
# Substitute string across a file
sed -i s/regexp/subst/g file
```



