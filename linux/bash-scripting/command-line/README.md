# Command Line Tools

### **Listen for ports and discover underlaying applications using that port**

```text
netstat -an | grep -i listen
lsof -n -i:5556 | grep -i listen
```

## Get Exact Boot, Sleep, and Wake Times from the Command Line

```text
sysctl -a | grep kern.boottime
```







