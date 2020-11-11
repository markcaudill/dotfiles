# shellcheck shell=bash
start_agent() {
    local ssh_env="${1}"

    test -z "${ssh_env}" && echo "Argument required for start_agent()!" && return

    # Bail if this isn't an interactive shell
    test "$-" == "*i*" || return

    # Attempt to load an existing ssh environment
    # shellcheck source=/dev/null
    test -f "${ssh_env}" && . "${ssh_env}" &> /dev/null

    # Check to see if there's an agent running in the existing
    # env. This will fail if there's no env so it's safe.
    test "$(ps -p "${SSH_AGENT_PID}" -o comm -h 2> /dev/null)" = "ssh-agent" && return

    # If we get here then we need to initialize a new env. Note: we redirect
    # this output to STDERR since a polluted STDOUT breaks lots of stuff like
    # rsync. Execution _shouldn't_ reach this point in those cases but ...
    echo "Initialising new SSH agent at ${ssh_env}..." 1>&2
    /usr/bin/ssh-agent > "${ssh_env}"
    echo succeeded 1>&2
    chmod 600 "${ssh_env}"
    # shellcheck source=/dev/null
    . "${ssh_env}" 1>&2 > /dev/null
    /usr/bin/ssh-add;
 }
