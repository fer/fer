# sed

## **Rename files massively**

```bash
ls | awk '{print("mv "$1" "$1)}' | sed 's/this/that/2' | /bin/sh
```

## Substitute string across a file

```bash
sed -i s/regexp/subst/g file
```

