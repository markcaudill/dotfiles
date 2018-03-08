export PS1="\$ "
umask 0077
export PATH=$PATH:$HOME/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/heroku/bin
export PYTHONPATH=$PYTHONPATH:~/src/ansible/lib
export EDITOR="vim"
export JOURNAL=/cygdrive/k/private/mcaudill/journal
export SSH_ENV=$HOME/.ssh/environment

# Aliases
alias clock='watch --no-title -n 1 "date '+%Y-%m-%d' | figlet -w 69 -f slant -c; date '+%H:%M:%S' | figlet -w 69 -f slant -c"'
alias df='df -h'
alias du='du -shx'
alias la='ls -a'
alias ll='ls -l'
alias minecraft='java -jar ~/Downloads/Minecraft.jar'
alias mount='mount | column -t'
alias nowdate='date +"%Y-%m-%d"'
alias nowtime='date +"%T"'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias timestamp='date +"%Y%m%d%H%M%S"'
alias wget='wget -c'


# Functions
start_agent() {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add;
}

jn() {
    JOURNAL=${JOURNAL-"$HOME/.journal"}
    mkdir -p ${JOURNAL}
    chmod 0700 ${JOURNAL}
    case ${1} in
        "new")
            filename=${JOURNAL}/$(date '+%Y-%m-%d-%H%M%S').md
            touch ${filename}
            chmod 0600 ${filename}
            vim ${filename}
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

sslf() {
    openssl s_client -connect ${1} </dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || start_agent
else
     start_agent;
fi
