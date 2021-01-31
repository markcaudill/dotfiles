function __is_ssh_agent_running
    # Verify an SSH agent (defined by SSH_AGENT_PID) is running
    if kill -0 "$SSH_AGENT_PID" ^/dev/null >/dev/null
        return 0
    else
        return 1
    end
end

function __load_ssh_env
	# Return if $SSH_ENV does not exist
	test ! -r "$SSH_ENV"; and return 0

    # If the $SSH_ENV file is in C-shell format
    if grep -E '^setenv' "$SSH_ENV" ^/dev/null >/dev/null
        eval (cat "$SSH_ENV" | sed 's/^setenv/set -gx/' | sed 's/^echo/#echo/') >/dev/null
    # If the $SSH_ENV is in the default format
    else if grep 'export' "$SSH_ENV" ^/dev/null >/dev/null
        eval (cat "$SSH_ENV" | sed 's/^\([^=]*\)=\([^;]*\).*/set -gx \1 \2; /g' | sed 's/^echo/#echo/g') >/dev/null
    else
    # Fall through: eval and hope for the best
        eval (cat $SSH_ENV) ^/dev/null >/dev/null
    end
end

function start_ssh_agent
    # Try to load or start an agent
    __load_ssh_env
    if not __is_ssh_agent_running
        command ssh-agent > "$SSH_ENV"
        __load_ssh_env
        if not __is_ssh_agent_running
            return 1
        end
    end

    # Load keys
    ssh-add -l >/dev/null; or ssh-add ^/dev/null
end
