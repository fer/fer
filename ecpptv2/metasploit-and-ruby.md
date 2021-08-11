---
description: >-
  Exploiting vulnerable applications with Ruby, as well as creating and editing
  Metasploit modules.
---

# Metasploit & Ruby

## Installation and Fundamentals

> Ruby is a dynamic, open source programming language with a focus on simplicity and productivity. Elegant syntax, natural to read and easy to write.

* Use Ruby as a multi-paradigm language that supports a functional style of programming.
* You can use high order programming methodology and lambda calculus.

### Installation

* Comes preinstalled with Kali.
* Use [RubyInstaller](https://rubyinstaller.org/) for Windows.

### Getting started

#### Ruby from the command line

```text
c:\Ruby193>ruby -e "puts 'Hello friend'"
```

#### Interactive Ruby

Classic default prompt prints more information than the simple one:

```text
c:\Ruby193>irb --simple-prompt
```

#### Check Ruby interpreter

```bash
$ which ruby
/usr/bin/ruby
```

So use in your scripts `#!/usr/bin/ruby` as a shebang.

```ruby
#!/usr/bin/ruby

puts 'Hi!'
```

For Windows machines, the easiest way to perform the same task is to associate the Ruby files using the Ruby installer.

### The Power of Ruby

We'll cover two interesting examples which will be useful to explain the full potential of Ruby

* **irb:** interactive ruby console.
* **Ruby One Liners**: small programs that are defined with a single line of code, they are executed using the command line Ruby, they are often used for file/directory manipulation or simple file system scripting.
  * Some examples are:
    * File spacing
    * Numbering and calculations
    * Text Conversion or Substitution

#### `cat` unix command in Ruby oneliner

```bash
$ ruby -pe 0 'file'
```

* `-e`: executes one line of ruby command.
* `-p`: iterates into a loop that reads each line and prints them to stdout.
* `-pe 0 'file'`: read 'file' line to line and prints then to stdout, executing 0 command. 

#### `wc` unix command in Ruby onliner

```bash
$ ruby -ne 'END {print "Lines:",$.,"\n"}' file
```

* `-e`: executes one line of Ruby code between single quotes.
* `-n`: puts the code into a loop.
* `print`: prints the following string to stdout without adding a new line at the end.
* `END`: executes the next block of instructions.
* `$.`: global variable that holds the last line number read by ruby interpreter.
* `.`: used to concatenate strings.

#### Replace substrings with Ruby oneliner

```bash
$ ruby -i.bak -pe 'gsub "foo","FOO"' file_name
```

* `-i`: specifies in-place edit mode, making a backup of the original file.
* `gsub`: global substitution.

### Libraries

> There are different sources of libraries, but the most uses is the packaging system [RubyGems](http://rubygems.org), which comes preinstalled with Ruby since version 1.9.

```bash
# Check documentation
gem help

# Search command used to look for gems
gem search <gem>

# Search for HTTP related remote gems
gem search -r http # -r: remote

# Search help options
gem search -h

# Help for install
gem install -h

# List your local installed gems
gem list
```

#### pry

The [pry](https://github.com/pry) library provides an interactive environment with many interesting features such as syntax highlighting.

```bash
gem install pry

# Use the prompt you prefer
pry --simple-prompt
```

### Data Types

We'll cover:

* Numbers
* Strings
* Arrays
* Ranges
* Hashes

#### Numbers

> Keep in mind that _every value_ in Ruby is an object, including the operators `+`, `-`, `/`, used in operations are happening between objects.

{% tabs %}
{% tab title="Integer" %}
```text
>> 2**5
=> 32
>> 10/2
=> 5
>> 4.odd?
=> false
>> 10.next
=> 11
>> 10.pred
=> 9
>> 25.to_s
=> "25"
>> 65.chr
=> "A"
>> -5.abs
=> 5
```
{% endtab %}

{% tab title="Float" %}
```
>> 2.0**3
=> 8.0
>> 2.51.round
=> 3
>> 2.51.ceil
=> 3
>> 2.51.floor
=> 2
```
{% endtab %}

{% tab title="Numeric" %}
**Integer** & **Float** _extend_ `Numeric` wich in turn extends **Object** and so on up to the **Basic Object**.
{% endtab %}

{% tab title="Anticipation" %}
{% code title="ip\_upto.rb" %}
```bash
# $ ruby ip_upto.rb 192.168.1 10 20
# 192.168.1.10
# 191.168.1.11
# ....
# 192.168.1.20

(ARGV[1]..ARGV[2]).each {|i| print ARGV[0],".",i,"\n"}
```
{% endcode %}
{% endtab %}

{% tab title="Comments" %}
```ruby
=begin
 Multiline comment
 with multiple lines :)
=end

# this is a comment too.
```
{% endtab %}
{% endtabs %}

**Strings**

> Another built-in Ruby class. Create strings with single and double quotes.

{% tabs %}
{% tab title="Escape Sequences" %}
```ruby
# Single quotes only support two escape sequences:
>> 'It\'s funny'
=> "It's funny"
>> '\\backslash!'
=> \backslash!
```
{% endtab %}

{% tab title="Second Tab" %}

{% endtab %}
{% endtabs %}





















## Control Structures

## Methods, Variables and Scope

## Classes, Modules and Exceptions

## Pentesters Prerequisites

## Input/Output

## Network and OS Interaction

### Network and OS Interaction

### ▶ Packetfu

### ▶ Packetful Sniffing

### Ruby

## The Web

### The Web

### ▶ Post Flooding

### ▶ Form Extraction

### ▶ Nokogiri

## Exploitation with Ruby

### Exploitation with Ruby

### ▶ Exploitation with Ruby

### 🧪 Exploitation with Ruby


