shopt -s histappend

umask 0077

export PS1="\$ "

# Aliases
alias ccat='highlight -O ansi'
alias df='df -h'
alias du='du -shx'
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

gpgconf --launch gpg-agent
