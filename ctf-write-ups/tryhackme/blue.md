---
description: >-
  Deploy & hack into a Windows machine, leveraging common misconfigurations
  issues.
---

# Blue

## Task \#1: Recon

Generated on **Tue Jul 20 05:12:11 2021** with `nmap 7.91`.

```bash
nmap -sV -n -v -Pn -p- -T4 -A --open -oX portScan.xml 10.10.146.250
```

### Open Ports and Running Services

| Port | State | Service | Version |
| :--- | :--- | :--- | :--- |
| 135/tcp | open | msrpc | Microsoft Windows RPC |
| 139/tcp | open | netbios-ssn | Microsoft Windows netbios-ssn |
| 445/tcp | open | microsoft-ds | Windows 7 Professional 7601 Service Pack 1 microsoft-ds |
| 3389/tcp | open | ms-wbt-server |  |
| 49152/tcp | open | msrpc | Microsoft Windows RPC |
| 49153/tcp | open | msrpc | Microsoft Windows RPC |
| 49154/tcp | open | msrpc | Microsoft Windows RPC |
| 49158/tcp | open | msrpc | Microsoft Windows RPC |
| 49159/tcp | open | msrpc | Microsoft Windows RPC |



