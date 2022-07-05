# shellcheck shell=bash

# source ~/.git-prompt.sh if it exists
if [ -f ~/.git-prompt.sh ]; then
	export GIT_PS1_SHOWDIRTYSTATE=true
	export GIT_PS1_SHOWSTASHSTATE=true
	export GIT_PS1_SHOWUNTRACKEDFILES=true
	export GIT_PS1_SHOWUPSTREAM="auto"
	export GIT_PS1_HIDE_IF_PWD_IGNORED=true
	export GIT_PS1_SHOWCOLORHINTS=true
	# shellcheck source=/dev/null
	. ~/.git-prompt.sh
	export PROMPT_COMMAND='__git_ps1 "\n\W" "\\\$ "'
else
	export PS1='\n\W\$ '
fi


PS2="; "
export PS2

