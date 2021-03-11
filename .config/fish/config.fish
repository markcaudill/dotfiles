set fish_greeting # Clear greeting

source ~/.config/fish/aliases.fish
source ~/.config/fish/env-vars.fish

#  Start SSH Agent if this is an interactive shell
if status is-interactive > /dev/null
    start_ssh_agent
end

if command -v starship >/dev/null
    starship init fish | source
end

if command -v helm >/dev/null
	helm completion fish | source
end

if command -v minikube >/dev/null
	minikube completion fish | source
end

if command -v gh >/dev/null
	gh completion -s fish | source
end

fish_vi_key_bindings
