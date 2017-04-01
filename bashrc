_os="$(uname)"

export PS1="$ "
umask 0077
export GOPATH=$HOME/src/gocode
export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:$HOME/.rvm/bin:/usr/local/heroku/bin:$GOPATH/bin:$PATH
export PYTHONPATH=$PYTHONPATH:~/src/ansible/lib
export EDITOR="vim"
export JOURNAL=/cygdrive/k/private/mcaudill/journal
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Aliases
alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias clock='watch --no-title -n 1 "date '+%Y-%m-%d' | figlet -w 69 -f slant -c; date '+%H:%M:%S' | figlet -w 69 -f slant -c"'
alias cp='cp -i'
alias df='df -h'
alias du='du -shx'
alias grep='grep --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -la --color=auto'
alias l.='ls -d .* --color=auto'
alias ln='ln -i'
alias ls='ls --color=auto'
alias minecraft='java -jar ~/Downloads/Minecraft.jar'
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias mv='mv -i'
alias nowdate='date +"%Y-%m-%d"'
alias nowtime='date +"%T"'
alias nstat='netstat -ltunep'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias psg='/bin/ps aux | head -n1; /bin/ps aux | grep -v grep | grep '
alias rm='rm -I --preserve-root'
alias st='ssh -qt bender.mrkc.me todo'
alias t='todo -t'
alias tt='t ls +today'
alias timestamp='date +"%Y%m%d%H%M%S"'
alias wget='wget -c'


# setup ssh-agent (from http://mah.everybody.org/docs/ssh)
SSH_ENV=$HOME/.ssh/environment

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi


# Functions
mkcd() {
    # Make a directory and cd into it.
    mkdir "$1"
    cd "$1"
}

nfl() {
    # Original script by Kyle R. Jones (kr.jones@me.com)
    # Modified to minimize network requests and for clarity.

    if [ "$#" -lt 1 ]; then
        echo "Usage: nfl [TEAM]..."
        echo "Example: nfl WAS DAL"
        return
    fi
    teams=($@)
    xml=`mktemp`
    # Cleanup on exit (not sure if this works as expected within a BASH function; zsh does though, I think).
    trap "{ rm -f $xml; exit 255; }" EXIT SIGINT SIGTERM
    # Grab the XML and cache it in a temporary file.
    curl -s http://www.nfl.com/liveupdate/scorestrip/ss.xml > $xml

    for i in ${teams[@]}; do
        if ! grep -i $i $xml &>/dev/null; then
            echo "No games found this week for $i."
            continue
        fi
        home_city=$(cat $xml | grep -i ${i} | sed -e 's/.*h="\([^"]*\)".*/\1/')
        visiting_city=$(cat $xml | grep -i ${i} | sed -e 's/.*v="\([^"]*\)".*/\1/')
        home_team=$(cat $xml | grep -i ${i} | sed -e 's/.*hnn="\([^"]*\)".*/\1/')
        visiting_team=$(cat $xml | grep -i ${i} | sed -e 's/.*vnn="\([^"]*\)".*/\1/')
        first=$(echo ${home_team} | sed 's/\(.\).*/\1/')
        last=$(echo ${home_team} | sed 's/.\(.*\)/\1/')
        upper=$(echo ${first} | tr '[a-z]' '[A-Z]')
        home_team="$upper$last"
        first=$(echo ${visiting_team} | sed 's/\(.\).*/\1/')
        last=$(echo ${visiting_team} | sed 's/.\(.*\)/\1/')
        upper=$(echo ${first} | tr '[a-z]' '[A-Z]')
        visiting_team="$upper$last"
        home_score=$(cat $xml | grep -i ${i} | sed -e 's/.*hs="\([^"]*\)".*/\1/')
        visiting_score=$(cat $xml | grep -i ${i} | sed -e 's/.*vs="\([^"]*\)".*/\1/')
        quarter=$(cat $xml | grep -i ${i} | sed -e 's/.*q="\([^"]*\)".*/\1/')
        time_left=$(cat $xml | grep -i ${i} | sed -e 's/.*k="\([^"]*\)".*/\1/')
        day=$(cat $xml | grep -i ${i} | sed -e 's/.*d="\([^"]*\)".*/\1/')
        time=$(cat $xml | grep -i ${i} | sed -e 's/.* t="\([^"]*\)".*/\1/')

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

jn() {
    JOURNAL=${JOURNAL-"$HOME/.journal"}
    mkdir -p ${JOURNAL}
    case ${1} in
        "new")
            vim ${JOURNAL}/$(date '+%Y-%m-%d-%H%M%S').md
            ;;
        "find")
            egrep -i ${2-"."} ${JOURNAL}/*
            ;;
        "ls")
            ls ${JOURNAL} | xargs -l1
            ;;
        *)
            echo "Usage: ${0} [COMMAND...] [ARGS...]"
            echo
            echo " new             create a new entry"
            echo " find REGEX      find REGEX matches"
            echo " ls              list all entries"
            ;;
    esac
}

mp3() {
    youtube-dl --extract-audio --audio-format mp3 --audio-quality  0 --output "%(title)s.%(ext)s" ${1}
}
