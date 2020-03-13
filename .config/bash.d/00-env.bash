# shellcheck shell=bash

export CDPATH=".:~"
export HISTCONTROL=ignoredups
export HISTSIZE=2147483648
export HISTFILESIZE="${HISTSIZE}"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date:* --help"
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${HOME}/.local/bin:${GOBIN}:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
export BROWSER=firefox
export EDITOR=vim
export FILE=ranger
export READER=zathura
export SSH_ENV=$HOME/.ssh/environment
export TERMINAL=kitty
