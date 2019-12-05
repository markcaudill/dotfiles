# shellcheck shell=bash
shopt -s histappend

umask 0027

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

include(`include/env-vars.m4')dnl
export `BROWSER'=BROWSER
export `EDITOR'=EDITOR
export `FILE'=FILE
export `READER'=READER
export `TERMINAL'=TERMINAL

export CDPATH=".:~"
export HISTSIZE=-1
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

include(`include/aliases.m4')dnl

# Functions
mp3() {
    youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --output "%(title)s.%(ext)s" ${1}
}

start_agent() {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${`SSH_ENV'}
     . ${`SSH_ENV'} > /dev/null
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
if [[ -f ${`SSH_ENV'} && $- == *i* ]]; then
    . ${`SSH_ENV'} > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep 'ssh-agent$' > /dev/null || start_agent
else
    start_agent
fi

source <(kitty + complete setup bash)

eval "$(starship init bash)"
