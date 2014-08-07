_os="$(uname)"

export PS1="\u@\h:\w\$ "
umask 0077
export PATH=$HOME/bin:$HOME/perl5/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/pkg/bin:/usr/local/bin
export EDITOR="vim"

# Aliases
## GNU vs non-GNU
case $_os in
    Linux)
        alias ls='ls --color=auto'
        alias ll='ls -la --color=auto'
        alias l.='ls -d .* --color=auto'
        alias la='ls -a --color=auto'
        alias chown='chown --preserve-root'
        alias chmod='chmod --preserve-root'
        alias chgrp='chgrp --preserve-root'
        alias nstat='netstat -ltunep'
        alias rm='rm -I --preserve-root'
        alias ps='ps fax | grep -v "ps fax" | less'
        ;;
    Darwin)
        alias ll='ls -la'
        alias l.='ls -d .*'
        alias la='ls -a'
        alias nstat='netstat -lnp'
        alias rm='rm -i'
        alias ps='ps aux | grep -v "ps aux" | less'
        ;;
    *)
        ;;
esac
## Generic
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias path='echo -e ${PATH//:/\\n}'
alias nowtime='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
alias timestamp='date +"%Y%m%d%H%M%S"'
alias ping='ping -c 5'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias wget='wget -c'
alias du='du -shx'
alias df='df -h'
alias psg='ps aux | head -n1; ps aux | grep -v grep | grep '

# Functions
mkcd() {
    # Make a directory and cd into it.
    mkdir "$1"
    cd "$1"
}

weather() {
    # Check the weather. Source: https://coderwall.com/p/uhj-2a
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-"$1"}" | perl -ne '/<title>([^<]+)/&&printf "\x1B[0;34m%s\x1B[0m: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';
}

nfl() {
    # Original script by Kyle R. Jones (kr.jones@me.com)
    # Modified to minimize network requests and for clarity.

    # teams=(WAS BUF DAL)
    teams=(WAS)
    xml=`mktemp`
    # Cleanup on exit (not sure if this works as expected within a BASH function; zsh does though, I think).
    trap "{ rm -f $xml; exit 255; }" EXIT SIGINT SIGTERM
    # Grab the XML and cache it in a temporary file.
    curl -s http://www.nfl.com/liveupdate/scorestrip/ss.xml > $xml

    for i in ${teams[@]}; do
        if ! echo $xml | grep $i; then
            echo "No games for $i."
            continue
        fi
        home_city=$(cat $xml | grep ${i} | sed -e 's/.*h="\([^"]*\)".*/\1/')
        visiting_city=$(cat $xml | grep ${i} | sed -e 's/.*v="\([^"]*\)".*/\1/')
        home_team=$(cat $xml | grep ${i} | sed -e 's/.*hnn="\([^"]*\)".*/\1/')
        visiting_team=$(cat $xml | grep ${i} | sed -e 's/.*vnn="\([^"]*\)".*/\1/')
        first=$(echo ${home_team} | sed 's/\(.\).*/\1/')
        last=$(echo ${home_team} | sed 's/.\(.*\)/\1/')
        upper=$(echo ${first} | tr '[a-z]' '[A-Z]')
        home_team="$upper$last"
        first=$(echo ${visiting_team} | sed 's/\(.\).*/\1/')
        last=$(echo ${visiting_team} | sed 's/.\(.*\)/\1/')
        upper=$(echo ${first} | tr '[a-z]' '[A-Z]')
        visiting_team="$upper$last"
        home_score=$(cat $xml | grep ${i} | sed -e 's/.*hs="\([^"]*\)".*/\1/')
        visiting_score=$(cat $xml | grep ${i} | sed -e 's/.*vs="\([^"]*\)".*/\1/')
        quarter=$(cat $xml | grep ${i} | sed -e 's/.*q="\([^"]*\)".*/\1/')
        time_left=$(cat $xml | grep ${i} | sed -e 's/.*k="\([^"]*\)".*/\1/')
        day=$(cat $xml | grep ${i} | sed -e 's/.*d="\([^"]*\)".*/\1/')
        time=$(cat $xml | grep ${i} | sed -e 's/.* t="\([^"]*\)".*/\1/')
    
        if [[ $quarter == "F" ]]; then
            echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} FINAL 
        elif [[ $quarter == "P" ]]; then
            echo ${visiting_city} ${visiting_team} at ${home_city} ${home_team} on $day at $time Eastern
        elif [[ $quarter == "H" ]]; then
            echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} HALFTIME
        else
            if [[ $quarter == "1" ]]; then
                echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}st
            elif [[ $quarter == "2" ]]; then
                echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}nd
            elif [[ $quarter == "3" ]]; then
                echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}rd
            else
                echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}th
            fi
        fi
    done
    # Delete the cached scores.
    rm -f $xml
}
