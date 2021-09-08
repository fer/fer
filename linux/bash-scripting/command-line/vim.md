---
description: >-
  This is a list of reminders to myself when using vim and attempting to learn
  at least one text-based editor well.
---

# vim

## Write on a file that needs root permission

```text
:w !sudo tee %
```

## Start vim

| Run it! | And get this |
| :--- | :--- |
| vim | Start with an empty window |
| vim file.txt | Start with an file.txt loaded and ready to edit |
| vim +23 file.txt | Start with an file.txt loaded and ready to edit at line 23 |
| vimtutor | Start in tutorial mode. This is a good idea |
| vimdiff oldfile.txt newfile.txt | Start VIM as a really fancy code merge tool |
| vimdiff . | Start VIM as a file explorer |
| vim -u NORC | To start vim without using this .vimrc file |

## Tips

| Section | Keys | Action |
| :--- | :--- | ---: |
| Tabs | ⌘ + Left | Switch Tab Left |
| Tabs | ⌘ + Right | Switch Tab Right |
| Tabs | ⌘ + 1-9 | Switch Tab Left |
| Tabs | ⌘ + 0 | Last tab |
| Tabs | gt | Go to next opened tab |
| Tabs | gT | Go to previous opened tab |
| Custom Mapping | ,v | Open .vimrc in a tab for editing |
| Command T | T | Just 'T' |
| Indentation | == | Indent line |
| Quitting | :q | Quit the current window if there are no unsaved changes. |
| Quitting | :q! | Quit the current window even if there are unsaved changes. |
| Quitting | :qa | Quit all windows unless there are unsaved changes. |
| Quitting | :qa! | Quit all windows even if there are unsaved changes. |
| Quitting | :wq | Save changes and quit the current window. |
| Quitting | ZZ | Save changes and quit current window |
| Sessions | :mksession! ~/.vim/today.session | Create a session. Load a session with `vim -S ~/.vim/today.session` |
| AutoComplete | Ctrl+P | Match previous tokens |
| AutoComplete | Ctrl+N | Match tokens ahead/next |
| Code folding | za | Toggles |
| Code folding | zc | Closes |
| Code folding | zo | Opens |
| Code folding | zR | Open all |
| Code folding | zM | close all |
| Search Text | \# | Searches for current selected word |
| Line | D | Delete until the end of the line |
| Search for matches in files | `:vim[grep][!] /{pattern}/[g][j] {file}` | Searches for matches inside files |

The 'g' option specifies that all matches for a search will be returned instead of just one per line, and the 'j' option specifies that Vim will not jump to the first match automatically.

## Insert text at beginning of a multi-line selection

Use `Ctrl+V` to select the first column of text in the lines you want to comment.

Then hit `Shift+I` and type the text you want to insert.

Then hit `Esc`, wait 1 sec and the inserted text will appear on every line.

## Spelling

Activate spelling with:

```text
:set spell
```

And select a language:

```text
:set spelllang=es
```

See suggested words for word under the cursor with `z=`

## Inserting a file

`:r[ead] [name]` Insert the file \[name\] below the cursor.

`:r[ead] !{cmd}` Execute {cmd} and insert its standard output below the cursor.

## Selecting Text \(Visual Mode\)

To select text, enter visual mode with one of the commands below, and use motion commands to highlight the text you are interested in. Then, use some command on the text. The operators that can be used are:

* `~` switch case
* `d` delete
* `c` change
* `y` yank
* `>` shift right
* `<` shift left
* `!` filter through external command
* `=` filter through 'equalprg' option command
* `gq` format lines to 'textwidth' length

## Replace \(with confirmation\)

:%s/'/gc

v Start highlighting characters. Use the normal movement keys and commands to select text for highlighting. V Start highlighting lines.

## Find in files

Vim provides these commands for searching files: :grep :lgrep :vimgrep :lvimgrep :vim\[grep\]\[!\] /{pattern}/\[g\]\[j\] {file} ... :vimgrep /dostuff\(\)/j ../_\*/_.c

## Exploring the filesystem

The file explorer is just another Vim buffer, so you can navigate up and down with k and j keys, or jump to the bottom with G, etc. If it is a large file listing, you may be quicker finding your target by searching for it.

There are a handful of useful commands for opening the file explorer - either in the current window or a split, focussing on the project root, or the directory of the most recent file edited. This table summarizes:

| lazy | mnemonic | open file explorer |
| :--- | :--- | :--- |
| `:e.` | `edit .` | at current working directory |
| `:sp.` | `:split .` | in split at current working directory |
| `:vs.` | `:vsplit .` | in vertical split at current working directory |
| `:E` | `:Explore` | at directory of current file |
| `:Se` | `:Sexplore` | in split at directory of current file |
| `:Ve` | `:Vexplore` | in vertical split at directory of current file |
| `:Sex` |  |  |
| `:Te` | `:Texplore` | Open new explorer tab with the directory of the file you're currently on |

## Vimcasts

```text
curl -f http://media.vimcasts.org/videos/index.json | grep m4v | awk {'print $2'} | sed 's/\"//g' | sed 's/,//g' | sort -t '/' -k5,5g
```

## Links

* [https://spacevim.org/](https://spacevim.org/)
* [Tern](http://usevim.com/2013/05/24/tern/)
* [Search and replace](http://vim.wikia.com/wiki/Search_and_replace)
* [Time traveling with Vim](https://coderwall.com/p/twr_bw/time-traveling-in-vim)
* [CSS editing in Vim](https://leonard.io/blog/2011/10/editing-less-and-css3-with-vim/)
* [Open file under cursor](http://vim.wikia.com/wiki/Open_file_under_cursor)
* [vim-copy-selection-to-os-x-clipboard](http://stackoverflow.com/questions/677986/vim-copy-selection-to-os-x-clipboard)
* [Detect file change, offer to reload file](http://stackoverflow.com/questions/923737/detect-file-change-offer-to-reload-file)
* [learn vimscript the hardway](http://learnvimscriptthehardway.stevelosh.com/)
* [sample vimrc](http://phuzz.org/vimrc.html)
* [http://www.viemu.com/a\_vi\_vim\_graphical\_cheat\_sheet\_tutorial.html](http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html)
* [https://grox.net/doc/unix/vitips.php](https://grox.net/doc/unix/vitips.php)

