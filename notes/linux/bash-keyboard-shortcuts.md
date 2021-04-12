# Bash Keyboard Shortcuts

| Category      | Command           | Description                                                                   | Example                |
|:--------------|:------------------|:------------------------------------------------------------------------------|:-----------------------|
| Directory     | cd -              | return to the last directory I was before                                     | cd -                   |
| History       | ctrl + r          | search in history                                                             | ctrl + r               |
| History       | ![number]         | execute the command number in history                                         | !99                    |
| History       | !!                | run last command                                                              | sudo !!                |
| History       | !-n               | run what I’ve typed 'n' commands ago                                          | !-7                    |
| History       | ctrl + p          | previous command in history                                                   | ctrl + p               |
| History       | ctrl + n          | next command in history                                                       | ctrl + n               |
| Last cmd      | !*                | get the arguments of the previous command                                     | cp a b ; mv !* (mv a b)|
| Last cmd      | !^                | get the first argument of the previous command                                | cp a b ; rm !^ (rv a)  |
| Last cmd      | !$                | get the last argument of the previous command                                 | cp a b ; rm !$ (rv b)  |
| Jobs          | [command]&        | run a process in background                                                   | node app.js &          |
| Jobs          | ctrl + z          | suspend current job (fg/bg)                                                   | ctrl + z (app running) |
| Execution     | cmd1 ; cmd2       | will execute cmd2 after cmd1                                                  | cmd1 ; cmd2            |
| Execution     | cmd1 && cmd2      | cmd2 will be executed if cmd1 exited successfully                             | cmd1 && cmd2           |
| Execution     | cmd1 || cmd2      | cmd2 will be executed if cmd1 failed                                          | cmd1 || cmd2           |
| Shortcuts     | tab               | auto-complete files and folder names                                          | tab                    |
| Shortcuts     | ctrl + u          | deletes chars till the beginning of line                                      | ctrl + u               |
| Shortcuts     | ctrl + w          | erase word by word before the cursor                                          | ctrl + w               |
| Shortcuts     | ctrl + k          | remove rest of line from the right of the cursor                              | ctrl + k               |
| Shortcuts     | ctrl + y          | UNDO what was deleted by shortcut                                             | ctrl + y               |
| Shortcuts     | ctrl + a          | beginning of the line                                                         | ctrl + a               |
| Shortcuts     | ctrl + e          | end of the line                                                               | ctrl + e               |
| Shortcuts     | ctrl + l          | clears the screen, similar to the clear command                               | ctrl + l               |
| Shortcuts     | ctrl + d          | exit the current shell                                                        | ctrl + d               |
| Shortcuts     | ctrl + z          | send current cmd to suspended bckgrnd (fg to restore)                         | ctrl + z               |
| Shortcuts     | ctrl + h          | same as backspace                                                             | ctrl + h               |
| Shortcuts     | ctrl + t          | swap the last two characters before the cursor                                | ctrl + t               |
| Shortcuts     | ctrl + x ctrl + e | opens file in vi (exit git :cq for not post execution)                        | ctrl + x ctrl + e      |
| Shortcuts     | ctrl + x ctrl + v | displays shell version                                                        | ctrl + x ctrl + v      |
| Shortcuts     | ctrl + xx         | move between start and current cursor position                                | ctrl + xx              |
| Shortcuts     | ctrl + s          | stops the output to the screen (for long running verbose command)             | top (press ctrl + s)   |
| Shortcuts     | ctrl + q          | allow output to the screen (if previously stopped using command above)        | resume top -> ctrl + q |
| Display       | [command]:p       | prints out the command instead of running it                                  | !!:p                   |
| Display       | <space>cmd        | write on the console without being registered                                 |  ls                    |