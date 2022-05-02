# shellcheck shell=bash

# Shortcuts around filesystem
alias src='cd ~/src'
alias d='cd ~/Downloads'

# Docker
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcl='docker-compose logs'
alias d='docker'

# Prompt before overwriting files
alias cp='cp -i'
alias mv='mv -i'

# Quickly copy public key
alias pubkey='cat ${HOME}/.ssh/id_ed25519.pub | xclip -selection clipboard | echo "=> Public key copied to pasteboard."'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# URL-encode strings
alias urlencode='python3 -c '\''import sys, urllib.parse; print(urllib.parse.quote_plus(str(" ".join(sys.argv[1:]))));'\'''

# Colorful cat
alias ccat='highlight -O ansi'

# Show filesystem space in human-readable format
alias df='df -hP'

# Summarize disk usage in human-readable terms and don't jump filesystems
alias du='du -shx'

# Start an HTTP server out of the current directory
alias fs='python -m SimpleHTTPServer'

# List files with color, human-readable units, and file type hints
uname | grep Linux &>/dev/null && alias ls='ls --color=auto --human-readable --file-type'

# List all files, including hidden, except . and ..
alias la='ls -A'

# List files in long format
alias ll='ls -l'

# Make mount output more readable
alias mount='mount | column -t'

# Limit ping to 5 packets
alias ping='ping -c 5'

# Password
alias pw="tr -dc 'A-Za-z0-9!\"#$%&'\''()*+,-./:;<=>?@[\]^_\`{|}~' </dev/urandom | head -c 16  ; echo"

# Terraform helpers
alias tf='terraform'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfp='tf plan'
alias tfs='tf show'

# Timestamp
alias ts='date --iso-8601=seconds'

# Filename-friendly timestamp
alias tsf='date --iso-8601=seconds | sed "s/://g"'

# Try to continue
alias wget='wget -c'

# Git aliases
alias g='git'
__git_complete g git
alias ga='git add'
__git_complete ga git_add
alias gaa='git add .'
__git_complete gaa git_add
alias gaaa='git add --all'
__git_complete gaaa git_add
alias gabr='alias | grep git'
alias gau='git add --update'
__git_complete gau git_add
alias gb='git branch'
__git_complete gb git_branch
alias gbd='git branch --delete'
__git_complete gbd git_branch
alias gc='git commit'
__git_complete gc git_commit
alias gca='git commit --all --message'
__git_complete gca git_commit
alias gcl='git clone'
__git_complete gcl git_clone
alias gcm='git commit --message'
__git_complete gcm git_commit
alias gcf='git commit --fixup'
__git_complete gcf git_commit
alias gco='git checkout'
__git_complete gco git_checkout
alias gcob='git checkout -b'
__git_complete gcob git_checkout
alias gcom='git checkout main'
__git_complete gcom git_checkout
alias gcos='git checkout staging'
__git_complete gcos git_checkout
alias gcod='git checkout develop'
__git_complete gcod git_checkout
alias gd='git diff'
__git_complete gd git_diff
alias gda='git diff HEAD'
__git_complete gda git_diff
alias gds='git diff --staged'
__git_complete gds git_diff
alias gl='git log'
__git_complete gl git_log
alias glg='git log --graph --oneline --decorate --all'
__git_complete glg git_log
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
__git_complete gld git_log
alias gm='git merge --no-ff'
__git_complete gm git_merge
alias gma='git merge --abort'
__git_complete gma git_merge
alias gmc='git merge --continue'
__git_complete gmc git_merge
alias gp='git pull'
__git_complete gp git_pull
alias gpr='git pull --rebase'
__git_complete gpr git_pull
alias gr='git rebase'
__git_complete gr git_rebase
alias gs='git status --branch'
__git_complete gs git_status
alias gss='git status --branch --short'
__git_complete gss git_status
alias gst='git stash'
__git_complete gst git_stash
alias gsta='git stash apply'
__git_complete gsta git_stash
alias gstd='git stash drop'
__git_complete gstd git_stash
alias gstl='git stash list'
__git_complete gstl git_stash
alias gstp='git stash pop'
__git_complete gstp git_stash
alias gsts='git stash save'
__git_complete gsts git_stash

alias path='echo $PATH | sed "s/:/\n/g"'

# Use Podman instead of Docker if it's installed
command -v podman >/dev/null && alias docker=podman

# todo.txt
alias t='todo.sh'

alias dot='dot -Ncolor="#E2E2E1" -Ecolor="#e1e1e1" -Nfontcolor="#e1e1e1" -Efontcolor="#e1e1e1" -Gbgcolor="#282828" -Efontname="Fira Code" -Nfontname="Fira Code" -Gfontname="Fira Code" -Efontsize=12 -Nfontsize=12 -Gfontsize=12'
alias icat='kitty +kitten icat --align=left --silent'
