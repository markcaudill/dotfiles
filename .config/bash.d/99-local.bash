# Include local non-checked-in config
# shellcheck source=/dev/null
test -f "${HOME}/.local/config.bash" && . "${HOME}/.local/config.bash"
