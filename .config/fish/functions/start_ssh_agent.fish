function __start_ssh_agent
    command ssh-agent -c | sed 's/^setenv/set -gx/' | sed 's/^echo/#echo/'
end

function __is_ssh_agent_running
    # Verify an SSH agent (defined by SSH_AGENT_PID) is running
    kill -0 $SSH_AGENT_PID; or return 1

    # Verify the SSH_AUTH_SOCK is present
    test -S $SSH_AUTH_SOCK; or return 1

    return 0
end

function __load_ssh_env
    eval (cat $SSH_ENV) >/dev/null
end

function start_ssh_agent
    # Try to load or start an agent
    test -f $SSH_ENV; and __load_ssh_env
    if not __is_ssh_agent_running
        __start_ssh_agent > $SSH_ENV
        __load_ssh_env
        if not __is_ssh_agent_running
            echo "Unable to start SSH agent!"
            env | grep SSH
            return 1
        end
    end
    # Load keys
    ssh-add -l >/dev/null; or ssh-add ^/dev/null
end
