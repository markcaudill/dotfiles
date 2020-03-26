# shellcheck shell=bash

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

# If this is an interactive shell and SSH_ENV exists as a file, source it
# shellcheck source=/dev/null
test -f "${SSH_ENV}" -a "$-" == "*i*" && . "${SSH_ENV}" >/dev/null
# Make sure there's actually an ssh-agent running with SSH_AGENT_PID
# or else start a new one
test "$(ps -p "${SSH_AGENT_PID}" -o comm -h 2>/dev/null)" = "ssh-agent" || \
    start_agent "${SSH_ENV}"

# shellcheck source=/dev/null
hash kitty &>/dev/null && source <(kitty + complete setup bash)
