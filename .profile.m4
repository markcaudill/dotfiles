include(`include/env-vars.m4')dnl
export `PATH'=PATH
export `SSH_ENV'=SSH_ENV
test -f /home/linuxbrew/.linuxbrew/bin/brew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
