# BB3

## Prework

### Connect to VPN

```bash
sudo openvpn black-box-penetration-test-3.ovpn
```

### Scan network

```bash
sudo nmap -sn 172.16.37.0/24 -oN hostAlive.nmap &&
cat hostAlive.nmap | grep for | awk {'print $5'} > ips.txt &&
sudo nmap -sV -n -v -Pn -p- -T4 -iL ips.txt -A --open -oX portScan.xml &&
sh nmap2md.sh portScan.xml | xclip
```



