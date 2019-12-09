# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory beep nomatch
unsetopt autocd extendedglob notify
bindkey -e
bindkey "^[[3~" delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

include(`include/env-vars.m4')dnl
export `PATH'=PATH
export `BROWSER'=BROWSER
export `EDITOR'=EDITOR
export `FILE'=FILE
export `READER'=READER
export `TERMINAL'=TERMINAL

include(`include/aliases.m4')dnl

command -v starship &>/dev/null && eval "$(starship init zsh)"
