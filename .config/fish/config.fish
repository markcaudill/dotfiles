set fish_greeting # Clear greeting

source ~/.config/fish/aliases.fish
source ~/.config/fish/env-vars.fish

#  Start SSH Agent if SSH_ENV exists and this is an interactive shell
if status --is-interactive > /dev/null
    start_agent
end

command -v starship >/dev/null; and starship init fish | source
