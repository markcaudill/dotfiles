# Source: https://superuser.com/a/966942/40900
function start_agent --description 'launch the ssh-agent and add the id_rsa identity'
  if begin
      set -q SSH_AGENT_PID
      and kill -0 $SSH_AGENT_PID ^/dev/null
      and grep -q '^ssh-agent' /proc/$SSH_AGENT_PID/cmdline
    end
  else
    set -e SSH_AGENT_PID
    set -e SSH_AUTH_SOCK
    eval (command ssh-agent -c | sed 's/^setenv/set -Ux/') >/dev/null
  end
  set -l identity $HOME/.ssh/id_rsa
  set -l fingerprint (ssh-keygen -lf $identity | awk '{print $2}')
  ssh-add -l | grep -q $fingerprint ^/dev/null
    or ssh-add $identity ^/dev/null
end
