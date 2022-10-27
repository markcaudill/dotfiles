# shellcheck shell=bash

export CDPATH=".:~"
export EDITOR=vim
export FLYCTL_INSTALL="${HOME}/.fly"
export GOBIN="${GOPATH}/bin"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HISTCONTROL=ignoredups
export HISTFILESIZE="${HISTSIZE}"
export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date:pony:pony *"
export HISTSIZE=2147483648
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LEDGER_FILE="${HOME}/Documents/main.journal"
export NVM_DIR="${HOME}/.nvm"

GPG_TTY=$(tty)
export GPG_TTY
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export SSH_AUTH_SOCK
gpgconf --launch gpg-agent

PATHS=("${HOME}/.krew/bin" "${HOME}/.local/bin" "${HOME}/bin" "${FLYCTL_INSTALL}/bin" "${GOBIN}" "${GOBIN}" "${HOME}/.pulumi/bin/" "/snap/bin" "/usr/local/go/bin" "/cygdrive/c/Go/bin" "/usr/local/bin" "/usr/local/sbin" "/usr/bin" "/usr/sbin" "/bin" "/sbin" "/usr/games" "/cygdrive/c/Program Files/Git/cmd")
VALID_PATHS=
# Only add a path to PATH if it it exists and isn't already in PATH. VALID_PATHS is used as intermediary variable
for p in "${PATHS[@]}"; do
	if [[ -d "${p}" ]]; then
		if [[ ":${VALID_PATHS}:" != *":${p}:"* ]]; then
			VALID_PATHS="${VALID_PATHS:+"${VALID_PATHS}:"}${p}"
		fi
	fi
done
export PATH=${VALID_PATHS}
