#!/usr/bin/env bash

if [[ $1 == "-f" ]]; then FORCE=true; fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for f in bin .vim .bashrc .bash_profile .vimrc; do
    if [[ -z "$FORCE" &&  -e $HOME/$f ]]; then
        echo "$HOME/$f exists, run with -f to force overwrite"
        exit 1
    fi
    cp -r $DIR/$f $HOME
done
