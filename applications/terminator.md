# Terminator

Something handy for me is setting this up in the custom commands plugin for terminator.  
i have 3 commands, one to pty.spawn bash, one to print and set stty info locally, and one to set stty on the actual rev shell. they are quick and dirty one liners but it works pretty well here are my commands:

Terminator Custom Commands

name: Upgrade TTY Python  
Command: python -c "import pty;pty.spawn\('/bin/bash'\)"

name: Fix TTY 1  
command: printf "\n\n\(Rows,Cols\)\n ";printf '\e\[1;91m%-6s\e\[m' $\(stty size\);printf "\n\nTerm= \e\[91m$TERM\e\[0m\n\n";stty raw -echo;fg;

name: Fix TTY 2  
command: export SHELL=bash;export TERM=xterm-256color;stty rows 20 columns 100;\echo ;echo ;read -p "Enter Rows:" ROWS;read -p "Enter Cols:" COLS;stty rows $ROWS columns $COLS && clear

once you get a reverse shell  
1. right click &gt; custom commands &gt; Upgrade TTY Python  
2. Press Ctrl+z to background  
3. right click &gt; custom commands &gt; Fix TTY 1  
4. right click &gt; custom commands &gt; Fix TTY 2  
5. enter the row and col values when prompted \(should still be on screen from step 2, so long as no reset is used\).



[https://blog.ropnop.com/upgrading-simple-shells-to-fully-interactive-ttys/](https://blog.ropnop.com/upgrading-simple-shells-to-fully-interactive-ttys/)

