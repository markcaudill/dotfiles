# shellcheck shell=bash

# Prompt before overwriting files
alias cp='cp -i'
alias mv='mv -i'

# Quickly copy public key
alias pubkey='cat ${HOME}/.ssh/id_rsa_yubikey.pub | xclip -selection clipboard | echo "=> Public key copied to pasteboard."'

# URL-encode strings
alias urlencode='python3 -c '\''import sys, urllib.parse; print(urllib.parse.quote_plus(str(" ".join(sys.argv[1:]))));'\'''

# Colorful cat
alias ccat='highlight -O ansi'

command -v batcat &>/dev/null && alias bat='batcat'

# Show filesystem space in human-readable format
alias df='df -hP'

# Summarize disk usage in human-readable terms and don't jump filesystems
alias du='du -shx'

alias env='env | sort'

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

alias t='tmux a -d -t main || tmux new -s main'

# Terraform
alias tf='terraform'

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
# From bash(1): If the last character of the alias value is a blank, then the
# next command word following the alias is also checked for alias expansion.
alias sudo='sudo '
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean && sudo apt-get autoremove'
alias zzz='systemctl suspend'


command -v molecule &>/dev/null && alias mol='molecule'

command -v trash &>/dev/null && alias rm=trash

# shellcheck shell=bash
start_agent() {
    local ssh_env="${1}"

    test -z "${ssh_env}" && echo "Argument required for start_agent()!" && return

    # Bail if this isn't an interactive shell
    test "$-" == "*i*" || return

    # Attempt to load an existing ssh environment
    # shellcheck source=/dev/null
    test -f "${ssh_env}" && . "${ssh_env}" &> /dev/null

    # Check to see if there's an agent running in the existing
    # env. This will fail if there's no env so it's safe.
    test "$(ps -p "${SSH_AGENT_PID}" -o comm -h 2> /dev/null)" = "ssh-agent" && return

    # If we get here then we need to initialize a new env. Note: we redirect
    # this output to STDERR since a polluted STDOUT breaks lots of stuff like
    # rsync. Execution _shouldn't_ reach this point in those cases but ...
    echo "Initialising new SSH agent at ${ssh_env}..." 1>&2
    /usr/bin/ssh-agent > "${ssh_env}"
    echo succeeded 1>&2
    chmod 600 "${ssh_env}"
    # shellcheck source=/dev/null
    . "${ssh_env}" 1>&2 > /dev/null
    /usr/bin/ssh-add;
 }

secret () {
	output=~/"${1}".$(date +%s).enc
	gpg --encrypt --armor --output "${output}" -r 250113B256B542E9 -r mark@cdll.me "${1}" && echo "${1} -> ${output}"
}

reveal () {
	output=$(echo "${1}" | rev | cut -c16- | rev)
	gpg --decrypt --output "${output}" "${1}" && echo "${1} -> ${output}"
}

alias k=kubectl

# bump_*
#
# $ echo 1.2.3 | bump_minor
# 1.3.3
# $ echo 1.2.3 | bump_z
# 1.2.4
bump_major() {
	awk -F'.' '{print $1+1"."$2"."$3}'
}
alias bump_x=bump_major

bump_minor() {
	awk -F'.' '{print $1"."$2+1"."$3}'
}
alias bump_y=bump_minor

bump_patch() {
	awk -F'.' '{print $1"."$2"."$3+1}'
}
alias bump_z=bump_patch
