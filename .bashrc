# shellcheck shell=bash

set -o vi

# shellcheck disable=SC1091
test -f /etc/profile && source /etc/profile

shopt -s checkwinsize histappend hostcomplete

umask 0027

for i in "${HOME}/.config/bash.d"/*.bash; do
    # shellcheck source=/dev/null
    . "${i}"
done

# shellcheck source=/dev/null
test -f "${SSH_ENV}" && start_agent "${SSH_ENV}"

# shellcheck source=/dev/null
test -x /home/linuxbrew/.linuxbrew/bin/brew && source <(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# shellcheck source=/dev/null
test -f ~/.cargo/env && source ~/.cargo/env

# shellcheck source=/dev/null
test -s "${NVM_DIR}/nvm.sh" && source "${NVM_DIR}/nvm.sh" # This loads nvm
