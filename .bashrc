# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#
# Last thing below is like above for local. Consider putting peculiar
# stuff in .bashrc_local instead of adding things to this.
#

alias sudo='sudo env PATH=$PATH'

set -o vi

PS1='\h:\w [\!] '

export EDITOR=vi

alias ls='ls -p --color'
alias myps='ps aux | grep $USER'
alias myipcs='ipcs | grep $USER'
alias dir='ls -lh'
alias cls=clear
alias md=mkdir
alias rd=rmdir
alias ll='ls -latr'

function apath()
    {
    export PATH=$PATH:$1
    }

function ppath()
    {
    export PATH=$1:$PATH
    }


function mktl()
    {
    /bin/ls $@ | sed -e 's/\.[^\.]*//g'
    }

function cp_nodots()
{
    rsync -a --exclude='.*' "$1" "$2"
}

if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi


