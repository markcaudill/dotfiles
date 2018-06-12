_os="$(uname)"

export PS1="$ "
umask 0077
export GOPATH=$HOME/src/gocode
export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:$HOME/.rvm/bin:/usr/local/heroku/bin:$GOPATH/bin:$HOME/Downloads/apache-maven-3.5.0-bin/apache-maven-3.5.0/bin:$HOME/src/ansible/bin:/cygdrive/c/HashiCorp/Vagrant/bin:$PATH
export PYTHONPATH=$PYTHONPATH:$HOME/src/ansible/lib
export EDITOR="vim"

# Aliases
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
    case `uname -s` in
        CYGWIN*)
            ps -ef ${SSH_AGENT_PID} | grep ssh-agent > /dev/null && return
            ;;
        *)
            ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null && return
            ;;
    esac
else
     start_agent;
fi


# Functions
mp3() {
    youtube-dl --extract-audio --audio-format mp3 --audio-quality  0 --output "%(title)s.%(ext)s" ${1}
}
