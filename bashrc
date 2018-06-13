shopt -s histappend
umask 0077

export EDITOR="vim"
export PATH=$PATH:$HOME/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/heroku/bin
export PYTHONPATH=$PYTHONPATH:~/src/ansible/lib
export SSH_ENV=$HOME/.ssh/environment

[[ -f ~/.colors ]] && source ~/.colors
if [[ -f ~/.todo_completion ]]; then
    source ~/.todo_completion
    complete -F _todo t
fi


# Prompt
gen_prompt() {
    ## Looks like (without Git stuff if .git-prompt.sh is missing):
    ## ╭─mark@bender:~/src/dotfiles (master *%)
    ## ╰$
    local GIT_COLOR="$White"
    if [[ -f ~/.git-prompt.sh ]]; then
        GIT_PS1_HIDE_IF_PWD_IGNORED=true
        GIT_PS1_SHOWCOLORHINTS=true
        GIT_PS1_SHOWDIRTYSTATE=true
        GIT_PS1_SHOWUNTRACKEDFILES=true
        source ~/.git-prompt.sh
        local GIT_STATUS=$(__git_ps1)
        if [[ "$GIT_STATUS" =~ "*" ]]; then     # if repository is dirty
            GIT_COLOR="$Red"
        elif [[ "$GIT_STATUS" =~ "%" ]]; then   # if there is something stashed
            GIT_COLOR="$Cyan"
        elif [[ "$GIT_STATUS" =~ "+" ]]; then  # if there are staged files
            GIT_COLOR="$Yellow"
        fi
        PS1="$GIT_COLOR╭─$Color_Off\u@\h:\w$GIT_COLOR$GIT_STATUS$Color_Off\n$GIT_COLOR╰$Color_Off\\$\[$(tput sgr0)\] "
    else
        PS1="$GIT_COLOR╭─$Color_Off\u@\h:\w\n$GIT_COLOR╰$Color_Off\\$\[$(tput sgr0)\] "
    fi
}
export PROMPT_COMMAND=gen_prompt


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


# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || start_agent
else
     start_agent;
fi
