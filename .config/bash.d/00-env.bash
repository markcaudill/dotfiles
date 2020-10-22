# shellcheck shell=bash

export CDPATH=".:~"
export HISTCONTROL=ignoredups
export HISTSIZE=2147483648
export HISTFILESIZE="${HISTSIZE}"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date:* --help:pony:pony *"
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
for p in ${HOME}/.local/bin ${GOBIN} /usr/local/go/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin; do
    [[ ":${PATH}:" != *":${p}:"* ]] && PATH="${PATH:+"${PATH}:"}${p}"
done
export PATH
export BROWSER=brave-browser
export EDITOR=vim
export FILE=ranger
export READER=zathura
export SSH_ENV=$HOME/.ssh/environment
export TERMINAL=kitty
GPG_TTY=$(tty)
export GPG_TTY
