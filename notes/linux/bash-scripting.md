# Bash Scripting

## Examples

### `watch` command implemented in bash

```bash
#!/bin/sh
# watch.sh - own flavour of linux watch command

usage(){
 echo "Usage: $0 [-t seconds] <command>"
}

my_watch(){
 while true
 do
   clear; $1
   if [ -z $2 ]; then sleep 1
   else sleep $2
   fi
 done;
}

while getopts 't:' OPTION
do
  case $OPTION in
    t)	time="$OPTARG"
 	case $time in
    	  ''|*[!0-9]*)
	     exec >&2; echo "error: -t argument is not a number!"
 	     usage; exit 1
          ;;
   	  *) if [ -z $3 ]; then
	      exec >&2; echo "error: missing command argument"
 	      usage; exit 1
	     else
 	      my_watch $3 $time
	     fi
	  ;;
	esac
      	;;
    ?)	usage
	exit 2
	;;
  esac
done

my_watch $1
```

### `screen` wrapper

```bash
#!/bin/sh
# screens.sh - create and attach to screen sessions easily

SCREENLS=`screen -ls | sed -ne 's|^['$'\t'']\+\('$cur'[^'$'\t'']\+\).*Attached.*$|\1 ?|p'`

create_session(){
	dialog --yesno 'There is no screen to be resumed. Create?' 0 0
	if [ $? = 0 ]; then
	   s_name=$(dialog --stdout --inputbox 'Session name:' 0 0)
	   screen -S $s_name
	fi
}

if [ -z $SCREENLS]; then
	create_session
else
	# Attach
	result=$( dialog --stdout --menu 'Select screen session (or press Cancel to create a new one):' 0 70 0 $SCREENLS)
	[ -z $result ] && create_session || screen -x $result
fi
```

### Fibonacci

```bash
#!/bin/sh

fibonacci() {
	if [ $# -lt 1 ];
	then
		echo "fibonacci: specify an index"
		return;
	fi;

	if [ $1 == 0 ]; then echo 0; return; fi;
	if [ $1 == 1 ]; then echo 1; return; fi;

	echo $(expr $(fibonacci $(expr $1 - 1)) + $(fibonacci $(expr $1 - 2)));
}
```

## References

- https://devhints.io/bash