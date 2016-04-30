emacs
=====

.emacs.d content, etc.

## Emacs Version 

24.4.1 on Raspbian

## Setup
       cd
       git clone https://github.com/esmanchik/emacs.git
       emacs/setup.sh

## Debug C++ App
 * compile it with -g
 * M-x gdb
 * C-x b to switch back to file
 * M-x gud-break to set breakpoint
 * C-x b to GDB buffer
 * r <program_args>
 * n
 * other usual GDB commands
 * type (global-set-key (kbd "<f8>") 'gud-next) in *scratch* and press C-x C-e