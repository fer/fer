# grep

## Caveats

* Know regular expressions well, and the various flags to `grep`/`egrep`. The `-i`, `-o`, `-A`, and `-B` options are worth knowing.
* `-H` Always print filename headers output lines.

## Search some text from all files inside a directory

```bash
grep -Hrn "text" directory
```

## Count lines in a file with grp \(as `wc -l`\)

```bash
grep -c ".*" filename
```

## Supress empty lines and comments

```text
grep ^[^#] /etc/squid/squid.conf
```



* [7 Linux Grep OR, Grep AND, Grep NOT Operator Examples](http://www.thegeekstuff.com/2011/10/grep-or-and-not-operators/)
* [USEFUL ONE-LINE SCRIPTS FOR SED](http://sed.sourceforge.net/sed1line.txt)
* [Idle Curiosity and Bash](http://www.tomgibara.com/misc/command-history)

