dotfiles
========

[![ShellCheck](https://github.com/markcaudill/dotfiles/actions/workflows/shellcheck.yml/badge.svg?branch=main)](https://github.com/markcaudill/dotfiles/actions/workflows/shellcheck.yml)

muh dots

Install/Update
--------------

1. Backup anything in your `$HOME` that you don't want overwritten. Review
   [Makefile](Makefile) to see which files will be affected.

2. Ensure no build artifacts are present.

    ```bash
    make clean
    ```

3. Update submodules

    ```bash
    git submodule update --init --recursive
    ```

4. Build and install

    ```bash
    make all
    make install
    ```
