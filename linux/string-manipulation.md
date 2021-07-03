# String Manipulation

```bash
cat a b | sort | uniq > c   # c is a union b
cat a b | sort | uniq -d > c   # c is a intersect b
cat a b b | sort | uniq -u > c   # c is set difference a - b
```

