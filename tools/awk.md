# awk

## Summing all numbers in the third column of a text file 

This is probably 3X faster and 3X less code than equivalent Python\):

```bash
awk '{ x += $3 } END { print x }' myfile
```

