# Black Box Test 3

## Discover live hosts on the network

```bash
sudo nmap -sn 172.13.37.0/24 --exclude 172.13.37.10 -oN hostAlive.nmap
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oG portScan.grep
```

