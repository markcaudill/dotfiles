alias adno='arduino-cli'
alias ccat='highlight -O ansi'
alias df='df -h'
alias du='du -shx'
alias fs='python -m SimpleHTTPServer'
if command -sq lsd
    alias ls='lsd'
    alias la='lsd -a'
    alias ll='lsd -l'
    alias lt='lsd --tree'
else
    alias la='ls -a'
    alias ll='ls -l'
end
if command -sq kitty
	alias ssh='kitty +kitten ssh'
end
alias mount='mount | column -t'
alias mol=molecule
alias ping='ping -c 5'
alias t='todo.sh -ctan'
alias ta='todo.sh -ctan add'
alias td='todo.sh -ctan do'
alias tf='terraform'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfp='terraform plan'
alias tfs='terraform show'
alias tl='todo.sh -ctan ls'
alias tw='todo.sh -ctan ls @work'
alias tnw='todo.sh -ctan ls | grep -v @work'
alias today='date -d "today" "+%Y-%m-%d"'
alias tomorrow='date -d "next week" "+%Y-%m-%d"'
alias aweek='date -d "next week" "+%Y-%m-%d"'
alias amonth='date -d "next month" "+%Y-%m-%d"'
alias ayear='date -d "next year" "+%Y-%m-%d"'
alias ts='date --iso-8601=seconds'
alias tsf='date --iso-8601=seconds | sed "s/://g"'
alias wget='wget -c'
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
