SHELL = /bin/sh

BINS_SH =          \
	bin/battery    \
	bin/compress   \
	bin/dinfo      \
	bin/example    \
	bin/extract    \
	bin/gh         \
	bin/mb         \
	bin/notes      \
	bin/sysinfo    \
	bin/update_dns \
	bin/wlpop

LIBS =                     \
    lib/healthchecks.io.sh

FISH_FUNCTIONS =                             \
    .config/fish/functions/ans-role.fish     \
    .config/fish/functions/bash-example.fish \
    .config/fish/functions/fish_prompt.fish  \
    .config/fish/functions/path.fish         \
    .config/fish/functions/ppjson.fish       \
    .config/fish/functions/s.fish            \
    .config/fish/functions/start_agent.fish  \
    .config/fish/functions/ytdl.fish         \
    .config/fish/functions/ytmp3.fish

GIT_NAME = 'Mark Caudill'
GIT_EMAIL = mark@mrkc.me
GIT_SIGNINGKEY = 0x5B8069859601013F


.POSIX:

.PHONY: all install install-bash install-bins install-editors install-fish install-git install-shells install-tmux install-vim uninstall uninstall-bash uninstall-bins uninstall-editors uninstall-fish uninstall-git uninstall-shells uninstall-tmux uninstall-vim

.gitignore:
	curl -s https://gitignore.io/api/vim,visualstudiocode > .gitignore

all: bins editors git libs shells terminals

clean: clean-bins clean-editors clean-git clean-libs clean-shells clean-terminals

install: install-bins install-editors install-git install-libs install-shells install-terminals

uninstall: uninstall-bins uninstall-editors uninstall-git uninstall-libs uninstall-shells uninstall-terminals

##
## Scripts
##
bins: $(BINS_SH)

clean-bins:

install-bins: bins
	mkdir -v -p $(HOME)/.local/bin
	cp -v -p -t $(HOME)/.local/bin $(BINS_SH)
	@echo Make sure $(HOME)/.local/bin is in your PATH.

uninstall-bins:
	for bin in $(BINS_SH); do \
		rm -fv $(HOME)/.local/$$bin ;\
	done


##
## Editors
##
editors: .editorconfig vim

clean-editors: clean-vim

install-editors: install-vim
	cp -p .editorconfig $(HOME)/.editorconfig

uninstall-editors: uninstall-vim
	rm -f $(HOME)/.editorconfig

###
### Vim
###
vim: .vimrc

clean-vim:

install-vim: vim
	cp -p .vimrc $(HOME)/.vimrc
	mkdir -p $(HOME)/.vim/bundle
	test -d $(HOME)/.vim/bundle/Vundle.vim || \
		git clone https://github.com/VundleVim/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	cd $(HOME)/.vim/bundle/Vundle.vim && git pull && cd -
	vim +PluginInstall +qall

uninstall-vim:
	rm -rf $(HOME)/.vimrc $(HOME)/.vim/bundle


##
## Git Shit
##
git: .gitconfig

clean-git:
	rm -f .gitconfig

install-git: git
	cp -p .gitconfig $(HOME)/.gitconfig

uninstall-git:
	rm -f $(HOME)/.gitconfig

.gitconfig: .gitconfig.m4
	m4 \
		--define=GIT_NAME="$(GIT_NAME)" \
		--define=GIT_EMAIL=$(GIT_EMAIL) \
		--define=GIT_SIGNINGKEY=$(GIT_SIGNINGKEY) \
		.gitconfig.m4 > .gitconfig


##
## Libs
##
libs: $(LIBS)

clean-libs:

install-libs: libs
	mkdir -v -p $(HOME)/.local/lib
	cp -v -p -t $(HOME)/.local/lib $(LIBS)

uninstall-libs:
	for lib in $(LIBS); do \
		rm -fv $(HOME)/.local/$$lib ;\
	done


##
## Shells
##
shells: .profile bash fish

clean-shells: clean-bash clean-fish
	rm -f .profile

install-shells: .profile install-bash install-fish
	cp -p .profile $(HOME)/.profile
	cp -p .colors $(HOME)/.colors

uninstall-shells: uninstall-bash uninstall-fish
	rm -f $(HOME)/.profile
	rm -f $(HOME)/.colors

.profile: .profile.m4 include/env-vars.m4
	m4 < .profile.m4 > .profile

###
### Bash
###
bash: .bash_profile .bashrc

clean-bash:
	rm -f .bashrc

install-bash: bash
	cp -p .bash_profile $(HOME)/.bash_profile
	cp -p .bashrc $(HOME)/.bashrc

uninstall-bash:
	rm -f $(HOME)/.bash_profile
	rm -f $(HOME)/.bashrc

.bashrc: .bashrc.m4 include/aliases.m4 include/env-vars.m4
	m4 < .bashrc.m4 > .bashrc

###
### Fish
###
fish: .config/fish/config.fish $(FISH_FUNCTIONS)

clean-fish:
	rm -f .config/fish/config.fish

install-fish: fish
	mkdir -p $(HOME)/.config
	cp -pr .config/fish $(HOME)/.config/

uninstall-fish:
	rm -rf $(HOME)/.config/fish

.config/fish/config.fish: .config/fish/config.fish.m4 include/env-vars.m4
	m4 < .config/fish/config.fish.m4 > .config/fish/config.fish

##
## Terminals
##
terminals: kitty mintty tmux xresources

clean-terminals: clean-kitty clean-mintty clean-tmux clean-xresources

install-terminals: install-kitty install-mintty install-tmux install-xresources

uninstall-terminals: uninstall-kitty uninstall-mintty uninstall-tmux uninstall-xresources

###
### kitty
###
kitty: .config/kitty/kitty.conf

clean-kitty:

install-kitty:
	mkdir -p $(HOME)/.config/kitty
	cp -p .config/kitty/kitty.conf $(HOME)/.config/kitty/kitty.conf

uninstall-kitty:
	rm -rf $(HOME)/.config/kitty

###
### mintty
###
mintty: .minttyrc

clean-mintty:
	rm -f .minttyrc

install-mintty:
	cp -p .minttyrc $(HOME)/.mintty

uninstall-mintty:
	rm -f $(HOME)/.minttyrc

.minttyrc:
	cp -p include/dracula/mintty/dracula.minttyrc .minttyrc


###
### tmux
###
tmux: .tmux.conf

clean-tmux:

install-tmux: tmux
	cp -p .tmux.conf $(HOME)/.tmux.conf

uninstall-tmux:
	rm -f $(HOME)/.tmux.conf


###
### Xresources
###
xresources: .Xresources .xinitrc

clean-xresources:
	rm -f .Xresources

install-xresources:
	cp -p .Xresources $(HOME)/.Xresources
	cp -p .xinitrc $(HOME)/.xinitrc

uninstall-xresources:
	rm -f $(HOME)/.Xresources
	rm -f $(HOME)/.xinitrc

.Xresources:
	cp -p include/dracula/xresources/Xresources .Xresources
