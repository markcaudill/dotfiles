function fish_prompt
    set_color e9c46a
    echo -n '['
    set_color 2a9d8f
    echo -n (whoami)
    set_color e9c46a
    echo -n '@'
    set_color f4a261
    echo -n (hostname)
    set_color e9c46a
    echo -n ':'
    set_color e76f51
    echo -n (prompt_pwd)
    set_color e9c46a
    echo -n ']'
    set_color e9c46a
    echo -n '> '
    set_color normal
end
