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

# shellcheck disable=SC1091
test -f /etc/bash_completion && source /etc/bash_completion

# shellcheck source=/dev/null
test -f "${SSH_ENV}" && start_agent "${SSH_ENV}"

# shellcheck source=/dev/null
hash kitty &>/dev/null && source <(kitty + complete setup bash)

# shellcheck source=/dev/null
hash kind &>/dev/null && source <(kind completion bash)

# shellcheck source=/dev/null
hash kubectl &>/dev/null && source <(kubectl completion bash)

test -f ~/.cargo/env && source ~/.cargo/env
