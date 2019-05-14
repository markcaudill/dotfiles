set fish_greeting # Clear greeting

add_to_user_path ~/bin
add_to_user_path /usr/bin
add_to_user_path /usr/sbin
set --export BROWSER firefox
set --export EDITOR vim
set --export GIT_EDITOR vim
set --export PYTHONPATH $PYTHONPATH ~/src/ansible/lib
set --export TERMINAL gnome-terminal

ssh_agent
