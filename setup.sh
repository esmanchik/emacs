#!/bin/bash

set -e

sudo apt-get install clang libclang-dev llvm git

cd ~/.emacs.d
mkdir vendor
cd vendor
git clone https://github.com/auto-complete/popup-el.git
git clone https://github.com/auto-complete/auto-complete.git
git clone https://github.com/Golevka/emacs-clang-complete-async.git

cd emacs-clang-complete-async
make
cd ..
