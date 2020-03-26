# shellcheck shell=bash

# Shortcuts areound filesystem
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias src='cd ~/src'
alias d='cd ~/Downloads'

# Prompt before overwriting files
alias cp='cp -i'
alias mv='mv -i'

# Quickly copy public key
alias pubkey='cat ${HOME}/.ssh/id_ed25519.pub | xclip -selection clipboard | echo "=> Public key copied to pasteboard."'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Alias HTTP methods
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    # shellcheck disable=SC2139,SC2140
	alias "${method}"="curl -s -X ${method}"
done

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

# List filesin long format
alias ll='ls -l'

# Make mount output more readable
alias mount='mount | column -t'

# Limit ping to 5 packets
alias ping='ping -c 5'

# Todo.txt helpers
alias t='todo.sh -ctan'
alias ta='todo.sh -ctan add'
alias td='todo.sh -ctan do'
alias tl='todo.sh -ctan ls'
alias tw='todo.sh -ctan ls @work'
alias tnw='todo.sh -ctan ls | grep -v @work'

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
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gabr='abbr | grep git'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit'
alias gca='git commit --all --message'
alias gcl='git clone'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gds='git diff --staged'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status --branch'
alias gss='git status --branch --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# Use Podman instead of Docker if it's installed
command -v podman >/dev/null && alias docker=podman
