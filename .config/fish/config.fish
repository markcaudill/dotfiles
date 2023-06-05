fish_add_path -g ~/.local/bin

command -q rtx && source (rtx activate fish | psub)

if command -q rtx
  set -x GOPATH (rtx where go)/go
else
  set -x GOPATH ~/.local/share/go
end
set -x GOBIN $GOPATH/bin
fish_add_path -g $GOBIN

set -x NVM_DIR ~/.nvm

set -xp PATH ~/.cargo/bin

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Perl
set -x PERL_HOME $HOME/perl5
set -x PATH $PERL_HOME/bin $PATH 2>/dev/null;
set -q PERL5LIB; and set -x PERL5LIB $PERL_HOME/lib/perl5:$PERL5LIB;
set -q PERL5LIB; or set -x PERL5LIB $PERL_HOME/lib/perl5;
set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT $PERL_HOME:$PERL_LOCAL_LIB_ROOT;
set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT $PERL_HOME;
set -x PERL_MB_OPT --install_base $PERL_HOME;
set -x PERL_MM_OPT INSTALL_BASE=$PERL_HOME;

if status is-interactive
  # Commands to run in interactive sessions can go here

  # Completions (also check .config/fish/completions/)
  command -q helm && source (helm completion fish | psub)
  command -q kind && source (kind completion fish | psub)
  command -q kubectl && source (kubectl completion fish | psub)
  command -q molecule && source (_MOLECULE_COMPLETE=fish_source molecule | psub)
  command -q rtx && source (rtx completion fish | psub)
  command -q starship && source (starship init fish --print-full-init | psub)
  command -q zellij && source (zellij setup --generate-completion fish | psub)

  # Abbreviations
  command -q bat && abbr --add cat bat
  abbr --add cp cp -i
  abbr --add df df -hP
  abbr --add du du -shx
  command -q exa \
    && abbr --add ls exa \
    && abbr --add ll exa -l
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
