---
description: 'https://tryhackme.com/room/thefindcommand'
---

# find

Most of the time, you won’t be looking for something in your working directory. The first argument of your `find` command should be the directory you want to search. The command will search in that directory and in all its subdirectories. So, if you want to search the whole filesystem, your command should begin with `find /`.

Two very useful flags are the `-type` and `-name` flags. With `-type`, you can use `d` to only find directories, and `f` to only find files. The `-name` flag is used to specify a name or pattern to look for. You can type the whole name, or use wildcards to specify only part\(s\) of the name. If you use wildcards, you need to enclose your pattern in quotes, otherwise the command won't work as intended. It is useful to know that you can also use the `-iname` flag; same as `-name`, but case insensitive.

## Find all files whose name ends with ".xml"

```text
find / -type f -name "*.xml"
```

## Find all files in the /home directory \(recursive\) whose name is "user.txt" \(case insensitive\)

```text
find /home -type f -iname user.txt
```

## Find all directories whose name contains the word "exploits"

```text
find / -type f -name *exploits*
```

## Find all files owned by the user "kittycat"

```text

```

## Find all files that are exactly 150 bytes in size

```text

```

## Find all files in the /home directory \(recursive\) with size less than 2 KiB’s and extension ".txt"

```text

```

## Find all files that are exactly readable and writeable by the owner, and readable by everyone else \(use octal format\)

```text

```

## Find all files that are **only** readable by anyone \(use octal format\)

```text

```

## Find all files with write permission for the group "others", regardless of any other permissions, with extension ".sh" \(use symbolic format\)

```text

```

## Find all files in the /usr/bin directory \(recursive\) that are owned by root and have at least the SUID permission \(use symbolic format\)

```text

```

## Find all files that were not accessed in the last 10 days with extension ".png"

```text

```

## Find all files in the /usr/bin directory \(recursive\) that have been modified within the last 2 hours

```text

```

