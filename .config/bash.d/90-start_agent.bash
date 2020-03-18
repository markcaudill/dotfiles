# shellcheck shell=bash
start_agent() {
    local ssh_env="${1}"
    echo "Initialising new SSH agent at ${ssh_env}..." 1>&2
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${ssh_env}"
    echo succeeded 1>&2
    chmod 600 "${ssh_env}"
    # shellcheck source=/dev/null
    . "${ssh_env}" > /dev/null
    /usr/bin/ssh-add;
 }
