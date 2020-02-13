abbr --add ccat highlight -O ansi
abbr --add df df -h
abbr --add du du -shx
abbr --add fs python -m SimpleHTTPServer
abbr --add la ls -a
abbr --add ll ls -l
abbr --add mount 'mount | column -t'
abbr --add ping ping -c 5
abbr --add t todo.sh -ctan
abbr --add ta todo.sh -ctan add
abbr --add td todo.sh -ctan do
abbr --add tl todo.sh -ctan ls
abbr --add tw todo.sh -ctan ls @work
abbr --add tnw 'todo.sh -ctan ls | grep -v @work'
abbr --add today 'date -d "today" "+%Y-%m-%d"'
abbr --add tomorrow 'date -d "next week" "+%Y-%m-%d"'
abbr --add aweek 'date -d "next week" "+%Y-%m-%d"'
abbr --add amonth 'date -d "next month" "+%Y-%m-%d"'
abbr --add ayear 'date -d "next year" "+%Y-%m-%d"'
abbr --add ts date --iso-8601=seconds
abbr --add tsf 'date --iso-8601=seconds | sed "s/://g"'
abbr --add wget wget -c
abbr --add g    git
abbr --add ga   git add
abbr --add gaa  git add .
abbr --add gaaa git add --all
abbr --add gabr 'abbr | grep git'
abbr --add gau  git add --update
abbr --add gb   git branch
abbr --add gbd  git branch --delete
abbr --add gc   git commit
abbr --add gcl  git clone
abbr --add gcm  git commit --message
abbr --add gcf  git commit --fixup
abbr --add gco  git checkout
abbr --add gcob git checkout -b
abbr --add gcom git checkout master
abbr --add gcos git checkout staging
abbr --add gcod git checkout develop
abbr --add gd   git diff
abbr --add gda  git diff HEAD
abbr --add gds  git diff --staged
abbr --add glg  git log --graph --oneline --decorate --all
abbr --add gld  git log --pretty=format:"%h %ad %s" --date=short --all
abbr --add gm   git merge --no-ff
abbr --add gma  git merge --abort
abbr --add gmc  git merge --continue
abbr --add gp   git pull
abbr --add gpr  git pull --rebase
abbr --add gr   git rebase
abbr --add gs   git status --branch
abbr --add gss  git status --branch --short
abbr --add gst  git stash
abbr --add gsta git stash apply
abbr --add gstd git stash drop
abbr --add gstl git stash list
abbr --add gstp git stash pop
abbr --add gsts git stash save
