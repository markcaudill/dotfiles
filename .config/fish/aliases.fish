abbr --add ccat highlight -O ansi
abbr --add df df -h
abbr --add du du -shx
abbr --add fs python -m SimpleHTTPServer
abbr --add ls ls -1
abbr --add la ls -a
abbr --add ll ls -l
abbr --add mount 'mount | column -t'
abbr --add ping ping -c 5
abbr --add t todo.sh -ctan
abbr --add ta t add
abbr --add td t do
abbr --add tl t ls
abbr --add tw tl @work
abbr --add tnw 'tl | grep -v @work'
abbr --add today 'date -d "today" "+%Y-%m-%d"'
abbr --add tomorrow 'date -d "next week" "+%Y-%m-%d"'
abbr --add aweek 'date -d "next week" "+%Y-%m-%d"'
abbr --add amonth 'date -d "next month" "+%Y-%m-%d"'
abbr --add ayear 'date -d "next year" "+%Y-%m-%d"'
abbr --add ts date --iso-8601=seconds
abbr --add tsf 'ts | sed "s/://g"'
abbr --add wget wget -c