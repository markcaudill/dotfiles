set fish_greeting # Clear greeting

#set --export PATH $HOME/bin $HOME/.local/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin
set --export BROWSER firefox
set --export EDITOR vim
set --export FILE ranger
set --export GIT_EDITOR vim
set --export PYTHONPATH $PYTHONPATH ~/src/ansible/lib
set --export TERMINAL st

alias ccat='highlight -O ansi'
alias df='df -h'
alias du='du -shx'
alias la='ls -a'
alias ll='ls -l'
alias mount='mount | column -t'
alias path='echo $PATH | sed "s/ /\n/g"'
alias ping='ping -c 5'
alias timestamp='date +"%Y%m%d%H%M%S"'
alias wget='wget -c'

gpgconf --launch gpg-agent
