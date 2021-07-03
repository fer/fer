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

