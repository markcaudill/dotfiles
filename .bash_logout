# If this is the last shell then clear the screen. `SHLVL` is incremented each
# time `bash` is run and decremented when it exits. So if you run `bash`
# within `bash` within `bash`, `$SHLVL` will be 3.
test "${SHLVL}" = "1" && command -v clear_console && clear_console -q
