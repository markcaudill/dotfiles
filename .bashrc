shopt -s histappend
umask 0077

export EDITOR="vim"
export PATH=$PATH:$HOME/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/heroku/bin
export PYTHONPATH=$PYTHONPATH:~/src/ansible/lib
export SSH_ENV=$HOME/.ssh/environment
export CLEANPROMPT=""

[[ -f ~/.todo_completion ]] && source ~/.todo_completion && complete -F _todo t


# Prompt
gen_prompt() {
    ## Looks like:
    ## ╭─┤pty0├─╢mark@bender:~/src╟─┤(✿◠‿◠)├─╮
    ## ╰>
    local __last_exit=$?
    [[ -f ~/.colors ]] && source ~/.colors

    local __line_color=${Red}
    local __prompt_color=${White}
    local __text_color=${White}

    local __clean_prompt="\n\u@\h:\w\n\$ "
    local __success_string="${Green}(✿◠‿◠)"
    local __failure_string="${Red}(◡﹏◡✿)"
    local __exit_string=$(if [[ $__last_exit -ne 0 ]]; then echo $__failure_string; else echo $__success_string; fi)
    local __prompt="> "

    if [[ -n ${CLEANPROMPT} ]]; then
        PS1="${__clean_prompt}"
    else
        PS1="\n${__line_color}╭─┤${__text_color}\l${__line_color}├─╢${__text_color}\u@\h:\w${__line_color}╟─┤${__exit_string}${__line_color}├─╮\n╰${__prompt}\[$(tput sgr0)\]"
    fi
}
#export PROMPT_COMMAND=gen_prompt
export PS1="\u@\h:\w\$ "


# Aliases
alias df='df -h'
alias du='du -shx'
alias la='ls -a'
alias ll='ls -l'
alias mount='mount | column -t'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias t='todo.sh -Ant'
alias timestamp='date +"%Y%m%d%H%M%S"'
alias wget='wget -c'


# Functions
mp3() {
    youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --output "%(title)s.%(ext)s" ${1}
}

sslf() {
    openssl s_client -connect ${1} </dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin
}

start_agent() {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add;
}

transfer() {
    # write to output to tmpfile because of progress bar
    tmpfile=$(mktemp -t transferXXX)
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}


# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || start_agent
else
     start_agent;
fi
