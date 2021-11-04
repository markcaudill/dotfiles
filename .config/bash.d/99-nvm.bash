# shellcheck shell=bash

# shellcheck source=/dev/null
test -s "${NVM_DIR}/nvm.sh" && source "${NVM_DIR}/nvm.sh" # This loads nvm
# shellcheck source=/dev/null
test -s "${NVM_DIR}/bash_completion" && source "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion

