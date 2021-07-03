---
description: >-
  Introduction to C++, Python, and Command-Line Scripting in the Penetration
  Testing Preliminary Skills & Programming course.
---

# Preliminary Skills & Programming

## Introduction

Set of instructions that a computer may follow. It can be used to automate tasks, leaving specific things to be done by a machine instead of a human. Syntax and usage requirements are specific per language, but purpose keeps on being the same.

* Each programming language has its own syntax, which may require some instructions to use certain characters at the end of each statement while in another language this may not be needed.
* Variables might have different types depending on the programming language.
* Functions are normally allowed to be created. These are pieces of code responsible for some repeatable tasks. Might use arguments and return a value.
* Conditional statements are part of a programming language syntax.
* Loops are a set of instructions that need to be executed numerous times.

Level can tell how close these languages are to the hardware.

| Low level | High level |
| :--- | :--- |
| More complicated, more prone to create vulnerabilities | Ease of development |
| Can do anything with them, as they are so closed to the machine | Less flexible |
| Deep understanding is required | Writing custom functionality from scratch can be difficult |
| Assembly | Java, Python |
|  | They can't run on a bare OS, will need some kind of software already running |

| Programming Languages | Scripting Languages |
| :--- | :--- |
| Programming languages require a compiler. | Interpreted |
| A compiler will convert your plain-text program file into something readable by the language environment. | Software environment install on your computer can read a plain-text program file |

### 

## Command Line Scripting \(12 items\)

### Bash Shell

* The main non-graphical tool to interact with the operating system is Shell.
* In FreeBSD there is no GUI at all.
* Other notable shells: `ksh`, `zsh`, `dash`.

### Bash Environment

* Upon the start of the shell, the OS checks for the existence of several files as: `~/.bashrc`, `~/.bash_login`, `~/.bash_profile`, `~/.bash_logout`.
* Environment Variables can be viewed by typing `env`.
* `PATH` is a relevant environment variable, which has a format of `[location]:[location]:...:[location]`.
* The `PATH` variable is one of the execution helpers.

### Bash Commands and Programs

* Bash has some built-in commands that provide basic functionality.
* Examples are: `fg`, `echo`, `set`, `while`.
* Most commands that are used in everyday tasks are external mini-programs kept in `PATH` locations \(use `which` to find the real location\).
* `man` displays help about commands.

### Bash Output Redirectors and Special Characters

* `~`: current user's home directory.
* `*`: wildcard that can be used for choosing only certain types of files.
* `$()`: will be evaluated before the whole statement and will become part of this statement.
* Use `command > file.txt` format to create a file containing command's output.
* Use `command >> file.txt` format to append containing command's output to an existing file.
* `|`: pipe.
* chaining commands is a quite powerful Bash feature, one-liners.

```bash
file `ls /etc/*.conf | sort` > test.txt && cat test.txt | wc -l
```

### Bash Conditional Statements and Loops

* `chmod +x scriptname` so you can execute this script with `./scriptname`

```bash
echo '#!/bin/bash' > script.sh
echo 'ls /tmp | wc -l' >> script.sh
chmod +x script.sh
./script.sh
```

```bash
if <conditions>; then
<commands>
fi
```

```bash
if [ x ]; then
  docommand
elif [ y ]; then
  doothercommand
else
  dosomethingelse
fi
```

Conditional statements:

* `-eq`: equal
* `-ne`: not equal
* `-lt`: less than
* `-le`: less than or equal
* `-gt`: greater than
* `-ge`: greater than or equal

Loops:

```bash
#!/bin/bash

for i in $(ls); do
  echo item: $i
done
```

or:

```bash
#!/bin/bash
for i in `seq 1 10`;
do
  echo $i
done
```

While loop:

```bash
while [condition]; do command1; command2; done
```

for example:

```bash
while read line; do echo $line; done < file.txt
```

Filters open ports from nmap output files

```bash
cat *.nmap | grep "open" | grep -v "filtered" | cut -d '/' -f 1 | sort -u | xargs | tr ' ' ',' > ports.txt
```

Fingerprint potential applications:

```bash
cat domains.txt
domain1.com
domain2.com
```

alivecheck.sh:

```bash
#!/bin/bash

for protocol in 'http://' 'https://';do
  while read line;
  do
    code=$(curl -L --write-out "%{http_code}\n" --output /dev/null --silent --insecure $protocol$line)
    if [ $code = "000" ]; then
      echo "$protocol$line: not responding."
    else
      echo "$protocol$line: HTTP $code"
      echo "$protocol$line: $code" >> alive.txt
    fi
  done < domains.txt
done
```

### Windows Command Line

* `cmd.exe` or Windows Command Line is the Microsoft equivalent of the Linux Bash Shell.
* Its usual location is `C:\Windows\system32\cmd.exe`.
* CMD relies mainly on built-in commands.
* Some of the are: `dir`, `cls`, `move` or `del`.

### Windows Environment

In Windows 10: `Control Panel` &gt; `System and Security` &gt; `System` &gt; `Advanced System Settings`.

* There are System variables \(for all users\) and for current user.
* Windows does have a `PATH` variable too, where the executable directories are separated through the `;` symbol.

### Windows Commands and Programs

* Windows CMD supports more built-in commands than the Linux one.
* If you would like to make your newly installed software executable from the command line, syou should place it within any of your `PATH` locations or change the `PATH` variable to contain its location.

### Windows Output Redirectors and Special Characters

* Windows CMD is a less flexible scripting env than Bash.
* PowerShell is better to create advanced scripts in Windows.
* In order to access Windows' env variables: `%varname%`.
* You can print env variables using `echo`, as in: `echo %PATH%`.
* `set` allows you to view variables.
* You can also create your own variables or temporarily modify existing ones.
* Any modifications will not be permanent and will only exist in the current `cmd.exe` window.
* Two different `cmd.exe` windows will not affect each other.
* Output redirection also works in Windows, as in `echo aaa > file.txt` or the append version: `echo bbb >> file.txt`.
* View files with `type` command: `type file.txt`.
* Some ways of command chaining:
  * `command1 & command2`: execute both regardless of the result.
  * `command1 && command2`: execute the 2nd one if the 1st one's execution succeeded.
  * `command1 | command2`: send output from the first command to the second one.
  * `command1 || command2`: execute the 1st command, and if ti fails, execute the second one.

### Windows Conditional Statements and Loops

* `.bat` files allow you to save larger command line scripts

```text
SET x=123
if %x%==123 (echo true) # true
if %x%==xyz (echo true) # nothing is output
if %x%==xyz (echo true) else (echo "does not contain xyz")
```

For loop:

```text
for %i in (*.*) do @echo FILE: %i
```

> `@`: hides the command prompt and just display the output

