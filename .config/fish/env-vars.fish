set -x GOPATH $HOME/go
set PATHS $HOME/.local/bin $HOME/.local/go/bin $GOPATH/bin $HOME/.cask/bin $HOME/.gem/ruby/2.5.0/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin
set -e PATH
for p in $PATHS;
    test -d $p
    and not contains $p $PATH
    and set -x PATH $PATH $p
end
set -x BROWSER firefox
set -x EDITOR vim
set -x FILE ranger
set -x READER zathura
set -x SSH_ENV $HOME/.ssh/environment
set -x TERMINAL kitty
set -x GPG_TTY (tty)
