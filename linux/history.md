# History

## History summary

The idea is simple, we gather info from history, lets look at the command combo’s now.

```bash
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
```

Output would be something like this:

```text
#     1  19.4%  ls
#     2  78  15.6%  cd
#     3  46  9.2%   vi
#     4  27  5.4%   sudo
#     5  25  5%     apt-get
#     6  15  3%     ps
#     7  13  2.6%   rm
#     8  13  2.6%   ll
#     9  11  2.2%   man
#    10  8   1.6%   mv
```

