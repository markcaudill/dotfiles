include(`include/env-vars.m4')dnl
export `PATH'=PATH
export `SSH_ENV'=SSH_ENV
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
