# shellcheck shell=bash

export CDPATH=".:~"
export HISTCONROL=""
export HISTFILE=${HOME}/.bash_history
export HISTFILESIZE=-1
export HISTSIZE=1
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${HOME}/.local/bin:${GOBIN}:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
export BROWSER=firefox
export EDITOR=vim
export FILE=ranger
export READER=zathura
export SSH_ENV=$HOME/.ssh/environment
export TERMINAL=kitty
