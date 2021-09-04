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















## 

## 

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

{% tab title="Class Methods" %}
```ruby
# use self for declaring own class methods
# these methods won't be visible per class instance

class C1
    def self.say
        print "hello!"
    end
end

>> C1.say
=> "hello!"
>> obj = C1.new
>> obj.say => # !!!! error
```
{% endtab %}
{% endtabs %}

Exercise:











```ruby
class ClassObj
  # class object @a constructor
  @a = 100
  
  # Instance object getter/setter for @a
  attr_accessor :a
 
  # class object setter for @a
  def self.a=(val)
   @a = val
  end
  
  # class object getter for @a  
  def self.a 
   @a 
  end
  
  # instance object @a constructor
  def initialize(a)
   @a = a 
  end
end
```

> Class methods may be defined in a few other ways
>
> * Using the class name instead of `self` keyword
> * Using the `<<` notation









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



