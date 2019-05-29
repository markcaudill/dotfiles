shopt -s histappend

umask 0077

export BROWSER=firefox
export EDITOR=vim
export FILE=ranger
export READER=zathura
export TERMINAL=st

export CDPATH=".:~"
export HISTSIZE=-1
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

if [ -f ~/.colors ]; then
    . ~/.colors
    col_bracket=$(fromhex e9c46a)
    col_user=$(fromhex 2a9d8f)
    col_at=$(fromhex e9c46a)
    col_host=$(fromhex f4a261)
    col_colon=$(fromhex e9c46a)
    col_dir=$(fromhex e76f51)
    col_prompt=$(fromhex e9c46a)
    export PS1="\[$(tput setaf ${col_bracket})\][\[$(tput setaf ${col_user})\]\u\[$(tput setaf ${col_at})\]@\[$(tput setaf ${col_host})\]\h\[$(tput setaf ${col_colon})\]:\[$(tput setaf ${col_dir})\]\W\[$(tput setaf ${col_bracket})\]]\[$(tput setaf ${col_prompt})\]\$${Color_Off} "
else
    export PS1="[\u@\h:\W]\$ "
fi

# Aliases
alias ccat='highlight -O ansi'
alias df='df -h'
alias du='du -shx'
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias mount='mount | column -t'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias timestamp='date +"%Y%m%d%H%M%S"'
alias wget='wget -c'


# Functions
mp3() {
    youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --output "%(title)s.%(ext)s" ${1}
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

# Start SSH Agent if SSH_ENV exists and this is an interactive shell
if [[ -f ${SSH_ENV} && $- == *i* ]]; then
    . ${SSH_ENV} > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep 'ssh-agent$' > /dev/null || start_agent
else
    start_agent
fi
