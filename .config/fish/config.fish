set fish_greeting # Clear greeting

set --export PATH $HOME/bin $HOME/.local/bin /usr/bin /usr/sbin /bin /sbin
set --export BROWSER firefox
set --export EDITOR vim
set --export FILE ranger
set --export GIT_EDITOR vim
set --export PYTHONPATH $PYTHONPATH ~/src/ansible/lib
set --export TERMINAL gnome-terminal

ssh_agent
