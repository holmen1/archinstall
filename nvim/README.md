# neovim

## Custom keymap

### neo-tree
C + n - Neotree filesystem  
leader gs - Neotree git_status  
leader bf - Neotree buffers   

### gitsigns
leader hs - stage hunk   
leader hr - reset hunk  
leader hp - preview hunk  
leader hd - diff

### LSP
K - vim.lsp.buf.hover  
leader gd - vim.lsp.buf.definition  
leader gr - vim.lsp.buf.references  
leader ca - vim.lsp.buf.code_action  

### Telescope
C + p - builtin.find_files  
leader fg - builtin.live_grep


## vim-cheat

w - jump forwards to the start of a word

b - jump backwards to the start of a word

e - jump forwards to the end of a word

0 - jump to the start of the line

$ - jump to the end of the line

gg - go to the first line of the document

G - go to the last line of the document

5gg - go to line 5



Search and replace

/pattern - search for pattern

n - repeat search in same direction

N - repeat search in opposite direction

Ctrl + o - go back to where you came from

% - move cursor to matching character (default supported pairs: '()', '{}', '[]')

:s/old/new - replace first occurrence of old

:s/old/new/g - replace  substitute globally in the line

:#,#s/old/new/g - where #,# are the line numbers of the range of lines

:%s/old/new/g - replace all old with new throughout file

:%s/old/new/gc - replace all old with new throughout file with confirmations



I - insert at the beginning of the line

a - insert (append) after the cursor

A - insert (append) at the end of the line

o - append (open) a new line below the current line

O - append (open) a new line above the current line



Editing

r - replace a single character

R - replace more than one character

cc - change (replace) entire line

ciw - change (replace) entire word

cw or ce - change (replace) to the end of the word

u - undo

U - restore (undo) last changed line



Cut and paste

yy - yank (copy) a line

2yy - yank (copy) 2 lines

yw - yank (copy) the characters of the word from the cursor position to the start of the next word

dd - delete (cut) a line

2dd - delete (cut) 2 lines

dw - delete (cut) the characters of the word from the cursor position to the start of the next word

d$ or D - delete (cut) to the end of the line

p - put (paste) the clipboard after cursor

P - put (paste) before cursor



Write and read files

v motion :w FILENAME - saves the Visually selected lines in file FILENAME

:r FILENAME - retrieves disk file FILENAME and puts it below the cursor position


Windows

:vs [file_path] - split the screen vertically
:sp [file_path] - split the window horizontally
Ctrl + w and press h - move to the split window on the left
Ctrl + w and press j - move to the split window on the down
Ctrl + w and press k - move to the split window on the up
Ctrl + w and press l - move to the split window on the right




## Nerd-fonts
```
$ sudo pacman -S nerd-fonts
```
select 42) ttf-jetbrains-mono-nerd  
Add font to terminal profile

