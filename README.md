dotfiles
========

[![ShellCheck](https://github.com/markcaudill/dotfiles/actions/workflows/shellcheck.yml/badge.svg?branch=main)](https://github.com/markcaudill/dotfiles/actions/workflows/shellcheck.yml)

muh dots

Install/Update
--------------

1. Backup anything in your `$HOME` that you don't want overwritten. Review
   [Makefile](Makefile) to see which files will be affected.

2. Install

    1. Using `install` (copies files into place)

        ```bash
        make install
        ```

    2. Using `stow` (symlink files instead of copy)

        ```bash
        make stow
        ```

3. Uninstall using `make uninstall` or `make unstow` (as applicable)
