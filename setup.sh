#!/bin/bash

ABSPATH=$(cd "$(dirname "$0")"; pwd)
EMACSD=~/.emacs.d
# You can set EMACSD=~/Desktop/HackerRank/.emacs.d

set -e

sudo apt-get install clang libclang-dev llvm git

cd $EMACSD
mkdir vendor
cd vendor
git clone https://github.com/auto-complete/popup-el.git
git clone https://github.com/auto-complete/auto-complete.git
git clone https://github.com/Golevka/emacs-clang-complete-async.git

cd emacs-clang-complete-async
make
cd ..

cp $ABSPATH/init.el $EMACSD
