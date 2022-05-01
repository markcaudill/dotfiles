# shellcheck shell=bash

export CDPATH=".:~"
export HISTCONTROL=ignoredups
export HISTSIZE=2147483648
export HISTFILESIZE="${HISTSIZE}"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GOBIN="${GOPATH}/bin"
export NVM_DIR="${HOME}/.nvm"
PATHS=("${HOME}/.local/bin" "${HOME}/bin" "${GOBIN}" "${GOBIN}" "${HOME}/.pulumi/bin/" "/snap/bin" "/usr/local/go/bin" "/cygdrive/c/Go/bin" "/usr/local/bin" "/usr/local/sbin" "/usr/bin" "/usr/sbin" "/bin" "/sbin" "/usr/games")
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
export EDITOR=vim
export SSH_ENV=$HOME/.ssh/environment
GPG_TTY=$(tty)
export GPG_TTY
