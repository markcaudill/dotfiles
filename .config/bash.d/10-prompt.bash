# shellcheck shell=bash

# prompt_git() returns a string based on the current direrctory's git state
prompt_git() {
    # From https://github.com/jessfraz/dotfiles/blob/ef58ce25495459a1a3599c09881285b7f6a4576a/.bash_prompt#L16
    local s='';
    local branchName='';
    local branchColor="${1}";
    local statusColor="${2}";

    # Check if the current directory is in a Git repository.
    if [ "$(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}")" == '0' ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

            if [[ -O "$(git rev-parse --show-toplevel)/.git/index" ]]; then
                git update-index --really-refresh -q &> /dev/null;
            fi;

            # Check for uncommitted changes in the index.
            if ! git diff --quiet --ignore-submodules --cached; then
                s+='+';
            fi;

            # Check for unstaged changes.
            if ! git diff-files --quiet --ignore-submodules --; then
                s+='!';
            fi;

            # Check for untracked files.
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s+='?';
            fi;

            # Check for stashed files.
            if git rev-parse --verify refs/stash &>/dev/null; then
                s+='$';
            fi;

        fi;

        # Get the short symbolic ref.
        # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
        # Otherwise, just give up.
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            echo '(unknown)')";

        [ -n "${s}" ] && s=" [${s}]";

        echo -e "${branchColor}${branchName}${statusColor}${s}";
    else
        return;
    fi;
}

# __hexcolor() sets the foreground color based on a hex value approximation
__hexcolor() {
    # Source: https://unix.stackexchange.com/a/269085
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' "${hex#??}")
    b=$(printf '0x%0.2s' "${hex#????}")
    printf '\[\e[38;5;%03dm\]' \
        "$(( (r<75?0:(r-35)/40)*6*6 +
             (g<75?0:(g-35)/40)*6   +
             (b<75?0:(b-35)/40)     + 16 ))"
}

# __colorreset() resets the foreground color
__colorreset() {
    printf '\[\e[0m\]'
}

# Dracula colors <https://draculatheme.com/>
cyan="$(__hexcolor "8be9fd")"
#green="$(__hexcolor "50fa7b")"
orange="$(__hexcolor "ffb86c")"
pink="$(__hexcolor "ff79c6")"
#purple="$(__hexcolor "bd93f9")"
red="$(__hexcolor "ff5555")"
#yellow="$(__hexcolor "f1fa8c")"

PS1="\n"
PS1+="${orange}\u"
PS1+="${cyan}@"
PS1+="${orange}\h"
PS1+="${cyan}:"
PS1+="${orange}\w"
PS1+=" \$(prompt_git \"${pink}\" \"${red}\")"
PS1+="\n"
PS1+="${cyan}\$ "
PS1+="$(__colorreset)"
export PS1

PS2="${cyan}> $(__colorreset)"
export PS2

