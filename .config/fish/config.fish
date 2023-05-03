set -xp PATH ~/.local/bin

set -x GOPATH ~/.local/share/go
set -xp PATH $GOPATH
set -x GOBIN $GOPATH/bin

set -x NVM_DIR ~/.nvm

set -xp PATH ~/.cargo/bin

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

command -q rtx && source (rtx activate fish | psub)

if status is-interactive
  # Commands to run in interactive sessions can go here

  # Completions (also check .config/fish/completions/)
  command -q helm && source (helm completion fish | psub)
  command -q kind && source (kind completion fish | psub)
  command -q kubectl && source (kubectl completion fish | psub)
  command -q molecule && source (_MOLECULE_COMPLETE=fish_source molecule | psub)
  command -q rtx && source (rtx completion fish | psub)
  command -q starship && source (starship init fish --print-full-init | psub)

  # Abbreviations
  command -q bat && abbr --add cat bat
  abbr --add cp cp -i
  abbr --add df df -hP
  abbr --add du du -shx
  command -q exa && abbr --add ls exa
  abbr --add fs python -m SimpleHTTPServer
  abbr --add g git
  abbr --add ga git add
  abbr --add gb git branch
  abbr --add gc git commit
  abbr --add gca git commit --all --message
  abbr --add gcm git commit --message
  abbr --add gcob git checkout -b
  abbr --add gd git diff
  abbr --add gl git log
  abbr --add gld 'git log --pretty=format:"%h %ad %s" --date=short --all'
  abbr --add glg git log --graph --oneline --decorate --all
  abbr --add gm git merge --no-ff
  abbr --add gp git pull
  abbr --add gs git status --branch
  abbr --add mount 'mount | column -t'
  abbr --add mv mv -i
  abbr --add path 'echo $PATH | sed "s/ \//\n\//g"'
  abbr --add ping ping -c 5 -W 5
  abbr --add tf terraform
  abbr --add update 'sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean && sudo apt-get autoremove'
  abbr --add wget wget -c
  abbr --add zzz systemctl suspend
end

set -x GOPATH ~/.local/share/go
set -x GOBIN $GOPATH/bin
set -xp PATH $GOBIN
set -x NVM_DIR ~/.nvm


set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

command -q rtx && source (rtx activate fish | psub)
set -xp PATH ~/.local/share/rtx/shims

set -xp PATH ~/.cargo/bin
