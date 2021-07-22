# wfuzz

wfuzz -c -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt --sc 200,202,204,301,307,403 -t 500 -R4 -f /tmp/output2,json -d "username=admin&password=admin" [http://172.16.64.140/project/FUZZ](http://172.16.64.140/project/FUZZ)

