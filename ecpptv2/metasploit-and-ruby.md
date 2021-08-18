---
description: >-
  Exploiting vulnerable applications with Ruby, as well as creating and editing
  Metasploit modules.
---

# Metasploit & Ruby

{% hint style="danger" %}
**This document is still in progress...** 
{% endhint %}

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

{% tab title="Double Quotes" %}
Double quotes support escape sequences. Some of the are:

| Syntax | Escape sequence description |
| :--- | :--- |
| `\"` | Double quote |
| `\r` | Carriage return |
| `\s` | Space |
| `\t` | Tab |
| `\n` | New Line |
| `\\` | Single backslash |
{% endtab %}

{% tab title="Alternative quotes" %}
You can add your custom string delimiter after the first `%q`character to instruct Ruby where the quoted string begins: 

```bash
>> print %q!my string! 
=> my string=> nil
```

{% hint style="info" %}
`%q` works as delimited _single quote_.

`%Q` works as delimited _double quote_.
{% endhint %}

You can make full use of:

* Brackets
* Braces
* Parenthesis
* &lt;&gt; signs

```bash
>> print %q[my string]
my string=> nil
>> print %q<my string>
my string=> nil
>> print %q{my string>}
my string>=> nil
>> print %q(my string)
my string=> nil

```
{% endtab %}

{% tab title="Operations" %}
```bash
# check if string is empty
str.empty?

# clear string
str.clear

# Length
str.length

str.size
str.start_with? "start"
str.end_with? "end"

# ... and many more string methods... 
# Remember: strings are objects in Ruby
```
{% endtab %}

{% tab title="heredoc" %}
```ruby
str = <<END
This is a multiline
string... Enjoy!
END
```
{% endtab %}

{% tab title="String Arithmetics" %}
```ruby
# + notation
"this" + " is " + "a string"

# juxtaposition
"this" " is " "a string too" 

# << notation
"this" << " is" << " a string"

# OO Notation
"this".concat(" is ").concat("a string")

# Do not alter a string
st = "my string"
st.freeze

# Check if string is frozen
st.frozen?

# [index] method
st = "My String"
st["My"]             # => "My"
st[1..6]             # => "y stri"
st[0]                # => "M"

# 'sub' replaces first ocurrence
st = st * 2         # => "My stringMy string"
st.sub('i','1')     # => "My str1ngMy string"

# 'gsub' replaces all ocurrences
st.gsub('g','8')     # => "My strin8My strin8"

# Note: modify the original string with:
# => st.gsub!('g','8')
# => st.sub!('i','1')

# Insert string
st.insert(st.size, " FIN")
```
{% endtab %}

{% tab title="Interpolation" %}
```ruby
>> st = "1234567890"
>> "'st' string has #{st.length} chars"
=> "'st' string has 10 chars"
```
{% endtab %}

{% tab title="More useful methods" %}
```ruby
>> "asdf".upcase
=> "ASDF"
>> "asdf".downcase
=> "asdf"
>> "asdf".capitalize
=> "Asdf"
>> "asdf".reverse
=> "fdsa"
>> "asdf".chop
=> "asd"
```
{% endtab %}
{% endtabs %}

**Array**

> An Array is an Object containing other Objects \(including other Arrays\) accessible through an Index.

{% tabs %}
{% tab title="Creation" %}
```bash
=> arr = Array.new(2)
=> arr = [] 
=> arr = ['uno', 'dos']
=> arr << 'tres'         # ['uno', 'dos', 'tres']

```
{% endtab %}

{% tab title="Accessing" %}
```bash
>> arr = ['uno', 'dos', 'tres']
>> arr[0]                 # => 'uno'
>> arr[-1]                # => 'tres'
>> arr[-2]                # => 'dos'
>> arr.first              # => 'uno'
>> arr.last               # => 'tres'
>> arr[1..2]              # => 'tres' 
```
{% endtab %}

{% tab title="Insert" %}
```ruby
>> arr.insert(0, 'cero')
=> ["cero", "uno", "dos", "tres"]
>> arr.insert(4,"cuatro", "cinco")
=> ["cero", "uno", "dos", "tres", "cuatro", "cinco"]
>> arr << "seis"
=> ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis"]
```
{% endtab %}

{% tab title="Deletion" %}
```ruby
>> arr
=> ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis"]
>> arr.delete("cero")
=ruby> "cero"
>> arr
=> ["uno", "dos", "tres", "cuatro", "cinco", "seis"]
>> arr.delete_at(0)
=> "uno"
>> arr
=> ["dos", "tres", "cuatro", "cinco", "seis"]
```
{% endtab %}

{% tab title="Operations" %}
```ruby
>> arr = [1,2,3]
>> arr2 = [3,4,5]
>> arr + arr2            # => [1, 2, 3, 3, 4, 5]
>> arr.concat(arr2)      # => [1, 2, 3, 3, 4, 5]

# Union (|): concatenates two arrays, removing dupes
# Intersection (&): common elements to both arrays
# Difference (-): 1st array without the element contained into the second array

>> arr                     # => [1, 2, 3]
>> arr2                    # => [3, 4, 5]
>> arr | arr2              # => [1, 2, 3, 4, 5]
>> arr & arr2              # => [3]
>> arr - arr2              # => [1, 2]
```
{% endtab %}

{% tab title="Stack" %}
```ruby
>> arr            # => [1, 2, 3]
>> arr.push(4)    # => [1, 2, 3, 4]
>> arr.pop()      # => 4
>> arr            # => [1, 2, 3]
```
{% endtab %}

{% tab title="More methods" %}
```ruby
>> arr = [10,1,1,1,2,3]
>> arr.reverse            # => [3, 2, 1, 1, 1, 10]
>> arr.uniq               # => [10, 1, 2, 3]
>> arr.sort               # => [1, 1, 1, 2, 3, 10]
>> arr.uniq               # => [10, 1, 2, 3]
>> arr.max                # => 10
>> arr.min                # => 1

# Persist changes
>> arr.uniq!.sort!        # => [1, 2, 3, 10]
```
{% endtab %}

{% tab title="Arrays and Strings" %}
```ruby
>> arr = [ 'hi', 'world', '!'] 
>> arr.join(' ')        # => "hi world !"

# Reverse operation
>> "hi world !".split(' ') # => ["hi", "world", "!"]
```
{% endtab %}
{% endtabs %}

**Ranges and Hash**

> **Ranges:** allows data to be represented in the form of a range, consisting in a _start value_ and and _end value_.

{% tabs %}
{% tab title="Ranges" %}
```ruby
>> ('a'..'f').to_a
=> ["a", "b", "c", "d", "e", "f"]

# 3 dots notation excludes last element
>> ('a'...'f').to_a
=> ["a", "b", "c", "d", "e"]

>> ("hi 1".."hi 4").to_a
=> ["hi 1", "hi 2", "hi 3", "hi 4"]

>> (1.1..4.4).step.to_a
=> [1.1, 2.1, 3.1, 4.1]
```
{% endtab %}

{% tab title="Methods" %}
```ruby
>> (1..10).begin        # => 1
>> (1..10).end          # => 10
>> (1..10).max          # => 10
>> (1..10).min          # => 1

# Contains
>> (1..10) === 4        # => true
>> (1..10) === 11       # => false
```
{% endtab %}
{% endtabs %}

> **Hashes:** similar to Arrays but acting as _dictionaries_. This is, they can use an index to reference an object.
>
> This **index can be also an object instead of an integer**. Arrays use integers as index.

{% tabs %}
{% tab title="Hashes" %}
```ruby
>> hash = { "a" => "Hi", "b" => "There"}
>> hash             # => {"a"=>"Hi", "b"=>"There"}
>> hash['a']        # => "Hi"
```
{% endtab %}

{% tab title="Hash keys are Symbols" %}
```ruby
>> website = {:url => 'https://ferx.gitbook.io/wiki/', :title => 'Wiki'}
>> website[:url]
=> "https://ferx.gitbook.io/wiki/"

# Same can be achieved without ':'
>> website = {url: 'https://ferx.gitbook.io/wiki/', title: 'Wiki'}
>> website[:url]
=> "https://ferx.gitbook.io/wiki/"

```
{% endtab %}
{% endtabs %}

## Control Structures

### Conditional structures

{% tabs %}
{% tab title="Comp ops" %}
| Operator | Description |
| :---: | :--- |
| `==` | Equality Operator |
| `.eql?` | Equality Operator \(OO Style\) |
| `!=` | Inequality operator |
| `<` | Less than |
| `>` | Greater than |
| `<=` | Less than or equal to |
| `>=` | Greater than or equal to |
{% endtab %}

{% tab title="if" %}
```bash
>> x = 6
?> if x > 3 then
?>   puts "greater!!"
>> end
greater!!

# else
>> x = 2
?> if x > 3 then
?>   puts "greater!!"
?> else
?>   puts "lower!!"
>> end
lower!!

>> puts "greater!!" if x > 1
greater!!
```
{% endtab %}

{% tab title="unless" %}
```ruby
# Opposite of 'if' statement
>> x = 5
=> unless x == 10 then print "#{x}" end
=> print "#{x}" unless x == 10
```
{% endtab %}

{% tab title="case" %}
```ruby
=> x = 5
>> case x
 | when 1 print "one"
 | when 2 print "two" 
 | when 3 print "three"
 | else print "no idea"
 | end
 
# Assign the return value to a variable
>> id = 2000
>> name = case
 | when id == 1111 then "Mark"
 | when id == 1112 then "Bob"
 | when id >= 2000 then "Other"
>> id
=> 2000
>> name
=> Other 
```
{% endtab %}

{% tab title="Comparisons in Ranges" %}
```ruby
(1..10) === 4 # Use triple equal sign
```
{% endtab %}

{% tab title="Ternary Operators" %}
```ruby
name = "Bob"
name == "Bob" ? "Hi Bob" : "Who are you?"
```
{% endtab %}
{% endtabs %}

### Loops

{% tabs %}
{% tab title="while" %}
```ruby
#  Repeats a block of code until the test expression is evaluated to false

>> i = 0 
?> while i < 5 do
?>   print i = i + 1,"\s"
>> end
1 2 3 4 5
=> nil

>> i = 0
>> print i = i + 1,"\s"  while i < 5
1 2 3 4 5
```
{% endtab %}

{% tab title="until" %}
```ruby
# Repeats a block of code until the test expression is evaluated to true
>> i = 5
?> until i == 0
?>   print i-=1,"\s"
>> end
4 3 2 1 0 => nil

>> i = 5
>> print i-=1,"\s" until i == 0
4 3 2 1 0 => nil

```
{% endtab %}

{% tab title="for" %}
```ruby
# iterates through the elements of an enumerable object

?> for i in [10,20,4] do
?>     print i,"\s"
>> end
10 20 4 => [10, 20, 4]

```
{% endtab %}

{% tab title="for with collections" %}
```ruby
>> hash = {:name => "fer", :gender => "maple" }
?> for key, value in hash
?>     print "#{key}:#{value}\n"
>> end
name:fer
gender:maple
```
{% endtab %}

{% tab title="for with ranges" %}
```ruby
?> for i in 1..10
?>     print "#{i}\s"
>> end
1 2 3 4 5 6 7 8 9 10 => 1..10
```
{% endtab %}
{% endtabs %}

### Iterators & Enumerators

{% tabs %}
{% tab title="each" %}
```ruby
>> (1..5).each {|i| print "#{i}\s" }
1 2 3 4 5 => 1..5

# Blocks!
?> ('a'..'h').each do |c|
?>   print "#{c}\n"
>> end
a
b
c
d
e
f
g
h
=> "a".."h"
```
{% endtab %}

{% tab title="times, upto, downto" %}
```ruby
>> 5.downto(1) { |i| print "#{i}\s" }
5 4 3 2 1 => 5

>> 1.upto(5) { |i| print "#{i}\s" }
1 2 3 4 5 => 1

>> 5.times { |i| print "#{i}\s" }
0 1 2 3 4 => 5
```
{% endtab %}
{% endtabs %}

{% tabs %}
{% tab title="map" %}
```ruby
>> array = [1, 2, 3, 4, 5]
>> array.map { |x| x**2 }
=> [1, 4, 9, 16, 25]
>> array.map! { |x| x**2 }
=> [1, 4, 9, 16, 25]
>> array
=> [1, 4, 9, 16, 25]
```
{% endtab %}

{% tab title="select" %}
```ruby
>> array
=> [1, 4, 9, 16, 25]
>> array.select { |x| x > 10 }
=> [16, 25]
```
{% endtab %}

{% tab title="reject" %}
```ruby
# oposite of select

>> array
=> [1, 4, 9, 16, 25]
>> array.reject { |x| x > 10 }
=> [1, 4, 9]
```
{% endtab %}

{% tab title="accumulator" %}
```ruby
>> array = [1, 2, 3, 4, 5]
>> array.inject { |sum, x| sum + x}
=> 15
>> array.inject(100) { |sum, x| sum + x}
=> 115
```
{% endtab %}
{% endtabs %}

> **Enumerator**: object whose purpose is to enumerate another enumerable ojbect. This means that enumerators are _enumerable_ too.
>
> If you have a method that uses an enumerable object, you may not want to pass the enumerable collection object because it is mutable and the method may modify it.
>
> So you can pass an enumerator created with **to\_enum** and nothing will happen to the original enumerable collection

{% tabs %}
{% tab title="Ruby" %}
```ruby
>> a = [1,2,3,4]
>> a.each 
=> #<Enumerator: ...>
>> a.map 
=> #<Enumerator: ...>
>> a.select 
=> #<Enumerator: ...>
```
{% endtab %}

{% tab title="External Iterators" %}
```ruby
>> a = [1, 2, 3, 4]
=> enum = a.to_enum
>> enum.next
=> 1
>> enum.next
=> 2
```
{% endtab %}
{% endtabs %}

## Methods, Variables and Scope

### Methods

> **Methods** are a common structure. Define code abstraction, providing specific semantic and hiding implementation.
>
> * Parameterized Block code with a name: can be used with different parametric values per invocation.

{% tabs %}
{% tab title="Simple method" %}
```ruby
def double(x)
    return x*2
end    
```
{% endtab %}

{% tab title="Alias" %}
```ruby
def spit_it_out
    puts "arghhhh!!"
end

alias arg spit_it_out
```
{% endtab %}

{% tab title="Variable length arguments" %}
```ruby
def vl_method(first, *others)
    puts "First is: " + first.to_s
    puts "Others: " + others.to_s
end

vl_method(1,2)
vl_method(1,2,3,4,5,6)
```
{% endtab %}

{% tab title="VLA in method invocation" %}
```ruby
def sum(a,b)
    a+b
end

>> sum *[1,2]
=> 3
>> sum *[10,20]
=> 30
```
{% endtab %}

{% tab title="Hash as ARG" %}
```ruby
def printPerson(hash)
    puts hash["name"]
    puts hash["age"]
end

printPerson({"name"=>"Jon", "age"=>25})

# Improved:

def printPerson(hash)
    name = hash[:name] || 'Unknown'
    name = hash[:age] || 'Unknown'
    name = hash[:gender] || 'Unknown'
    print "#{name} #{age} #{gender}"
end

>> printPerson name:"Jon", age:25
=> Jon 25 Unknown
```
{% endtab %}

{% tab title="yield" %}
```ruby
def method
    puts "uno"
    yield
    puts "dos"
    yield
end

>> method { puts "check!" }
uno
check!
dos
check!

# Another example
def double(x)
    yield 2*x
end

>> double(5) { |x| puts x }
=> 10
```
{% endtab %}

{% tab title="call" %}
```ruby
# Ruby allows you to pass a block as an argument.
# With this strategy, the block becomes an instance of the Proc class and you have
# to use call instead of yield to transfer the control to it.
#
# To specify that an argument will be a Proc object that encapsulates a block
# you must use ampersand (&) in method definition.

def square_cube(n,&p)
    for i in 1..0
        p.call(i**2)
        p.call(i**3)
    end
end

>> square_cube(5) { |x| print x, "\s" }
1 1 4 8 9 27 16 64 25 125

>> square_cube(5) { |x| print x-1, "\s" }
0 0 3 7 8 26 15 63 24 124

# Using Proc
>> square = Proc.new {|x| print x**2, "\s"}
>> (1..10).each(&square)
1 4 9 16 25 36 49 64 81 100

>> summ = Proc.new{|sum,x| sum+x**2}
>> (1..5).inject(0,&summ)
=> 55
```
{% endtab %}
{% endtabs %}

### Variables and Scope

> **Variable:** name for a mutable value
>
> * Ruby is a dynamically typed language, you can create a variable without specifying its type.
> * 4 types: **local**, **global**, **instance**, **class**.
> * Ruby allows the definitions of **constant** too.

{% tabs %}
{% tab title="local" %}
```ruby
# Local scope is the area where code that can use the binding 
#  between the name and the object ref value.
```

* If the outside scope has some binding for variables with the same name used in the block scope, they are hidden inside the block and reactivated outside.
* Note that statements like for, while, if, etc... do not define a new scope. Variables defined inside them are still accessible outside.

```ruby
for i in 1..0
    a = i + 1
end

a === 11 # True
```

* Methods does define its own scope and variables.
* Generally, the following control structures define a new scope:
  * `def ... end`
  * `class ... end`
  * `module ... end`
  * `loop {...}`
  * `proc {...}`
  * iterators/method blocks
  * the entire script
* You can also verify the scope of a variable using the `defined?` method.
* 
{% endtab %}

{% tab title="global" %}
* Global variables begins with the **$** special character.
* Accessible anywhere in the program.
* Nor recommendable. Global vars can be changed anywhere in the code.
* Their overuse can make tracking and handling bugs difficult.

```ruby
$*        # array of command line arguments
$0        # name of the script being executed
$_        # last string reads by gets
```
{% endtab %}

{% tab title="instance /  class" %}
* Instance and class variables can be defined within a class definition.
* **Class variables** begin with `@@` ****and they are visible by all instances of a class.
* **Instance variables** begin with `@` and they are local to specific instances of a class.
{% endtab %}

{% tab title="constants" %}
* Constants begin with **uppercase letters**. 
* Ruby allows you to change uppercased variables but a _warning is raised_. 
* Constants belong to their namespace in their scope:

```ruby
A=100
module B
    A = 200
end

>> A         # 100
>> B:A       # 200
```

* Ruby has a lot of predefined constants:
  * `ARGV`: holds command line arguments.
  * `ENV`: holds info about the environment.
{% endtab %}
{% endtabs %}

### Some tricks

```ruby
# Multiple variable assignment
>> a,b,c = "a", "b", "c"

# Swap values
>> x = 10; y = 20
>> [x, y] = [y, x]

# Multi-variable assignment via a function
def ret_value
    return 1,2,3
end

one, two, three = ret_value
```

## Classes, Modules and Exceptions

### Class Principles

> **Classes** define what an object will look like.

{% tabs %}
{% tab title="class" %}
```ruby
class MyClass
    def hello
        print "Hello"
    end
end

>> myObj = MyClass.new
>> myObj.hello
```
{% endtab %}

{% tab title="Instance Variables" %}
```ruby
class Myclass
    # Constructor
    def initialize(a)
        @a = a
    end
    
    # Setter
    def a=(value)
        @a = value
    end 

    # Getter
    def a
        @a
    end
end

>> obj1 = MyClass.new(20)
>> obj2 = MyClass.new(3)
>> obj1.a = 400
```
{% endtab %}

{% tab title="Instance Vars 2" %}
```ruby
class WrongClass
    @a = 4000
    
    def a 
        @a
    end
    
    def a=(val)
        @a = val
    end
end

>> wobj = WrongClass.new
>> wobj.a                     # nil
>> wobj.instance_variables    # [ ]
>> wobj.a = 100
>> wobj.instance_variables    # [:@a]
>> wobj.a                     # 100

```
{% endtab %}

{% tab title="Metaprogramming" %}
```ruby
# Getter/Setter via metaprogramming
# Metaprogramming allows to write, manipulate and
# generate programs at runtime.

class QuickClass
    attr_accessor :x, :y
    # attr_accessor defines a getter and setter 
end

>> obj = QuickClass.new
>> obj.x, obj.y = 100, 300

# with attr_reader, a getter is defined

class QuickClass
    attr_reader :x, :y
    
    def initialize(x, y)
        @x, @y = x, y
    end
end

>> obj.x = 123 # !!!! Error

# Attr 
# if used alone, it defines a getter, while 
# with 'True' it defines a setter too.

class QuickClass
    attr :x, true
    attr :y
    
    def initialize(x,y)
        @x, @y = x,y
    end
end

>> my_class = QuickClass.new(10,20)
>> obj.x = 100
>> obj.y = 200    # error
```
{% endtab %}
{% endtabs %}











### Method Visibility

### Subclassing and Inheritance

### Modules

### Exceptions

### Conclusion

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

## Metasploit

### Metasploit - Study Guide

### Meterpreter API

### Metasploit Write Custom Modules

### Meterpreter Scripting



