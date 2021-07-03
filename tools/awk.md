---
description: >-
  awk is a general purpose programming language that is designed for processing
  text-based data, either in files or data streams.
---

# awk

## Summing all numbers in the third column of a text file 

This is probably 3X faster and 3X less code than equivalent Python\):

```bash
awk '{ x += $3 } END { print x }' myfile
```

## Apache access.log parsing

### total unique visitors

```bash
cat access.log | awk '{print $1}' | sort | uniq -c | wc -l
```

### unique visitors today

```bash
cat access.log | grep `date '+%e/%b/%G'` | awk '{print $1}' | sort | uniq -c | wc -l
```

### unique visitors this month

```bash
cat access.log | grep `date '+%b/%G'` | awk '{print $1}' | sort | uniq -c | wc -l
```

### unique visitors for the month of March

```bash
cat access.log | grep Mar/2007 | awk '{print $1}' | sort | uniq -c | wc -l
```

### show sorted statistics of “number of visits/requests” “visitor’s IP address”

```bash
cat access.log | awk '{print "requests from " $1}' | sort | uniq -c | sort
```

### same **statistics** will be produces for an specific **date**

```bash
cat access.log | grep 26/Mar/2007 | awk '{print "requests from " $1}' | sort | uniq -c | sort
```

