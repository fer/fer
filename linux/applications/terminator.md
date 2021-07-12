---
description: 'https://terminator-gtk3.readthedocs.io/en/latest/'
---

# Terminator

## Plugin: CustomCommandsMenu

### Upgrade Reverse Shell to Fully Interactive TTY

![](../../.gitbook/assets/image%20%2814%29.png)

| Name | Command |
| :--- | :--- |
| TTY/Upgrade TTY Python | `python -c "import pty;pty.spawn('/bin/bash')"` |
| TTY/Fix TTY 1 | `printf "\n\n(Rows,Cols)\n ";printf '\e[1;91m%-6s\e[m' $(stty size);printf "\n\nTerm= \e[91m$TERM\e[0m\n\n";stty raw -echo;fg;` |
| TTY/Fix TTY 2 | `export SHELL=bash;export TERM=xterm-256color;stty rows 20 columns 100;\echo ;echo ;read -p "Enter Rows:" ROWS;read -p "Enter Cols:" COLS;stty rows $ROWS columns $COLS && clear` |

#### Once you get a reverse shell:

1. Right click → Custom Commands → TTY → Upgrade TTY Python  
2. Press `ctrl+z` to background  
3. Right click → Custom Commands → TTY → Fix TTY 1  
4. Right click → Custom Commands → TTY → Fix TTY 2  
5. Enter the `row` and `col` values as prompted from step 2

