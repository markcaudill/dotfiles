set fish_greeting # Clear greeting

include(`include/env-vars.m4')dnl
set --export `BROWSER' BROWSER
set --export `EDITOR' EDITOR
set --export `FILE' FILE
set --export `PATH' PATH_FISH
set --export `READER' READER
set --export `SSH_ENV' SSH_ENV
set --export `TERMINAL' TERMINAL

include(`include/aliases.m4')dnl

#  Start SSH Agent if SSH_ENV exists and this is an interactive shell
if status --is-interactive > /dev/null
    start_agent
end
