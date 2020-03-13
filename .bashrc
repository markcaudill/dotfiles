# shellcheck shell=bash
shopt -s checkwinsize histappend hostcomplete

umask 0027

for i in "${HOME}/.config/bash.d"/*.bash; do
    # shellcheck source=/dev/null
    . "${i}"
done

# shellcheck disable=SC1091
test -f /etc/bash_completion && source /etc/bash_completion

# Start SSH Agent if SSH_ENV exists and this is an interactive shell
if [[ -f "${SSH_ENV}" && $- == *i* ]]; then
    # shellcheck source=/dev/null
    . "${SSH_ENV}" > /dev/null
    test "$(ps -p "${SSH_AGENT_PID}" -o comm -h)" = "ssh-agent" || start_agent "${SSH_ENV}"
else
    start_agent "${SSH_ENV}"
fi

# shellcheck source=/dev/null
hash starship && source <(starship init bash --print-full-init)

# shellcheck source=/dev/null
hash kitty &>/dev/null && source <(kitty + complete setup bash)
