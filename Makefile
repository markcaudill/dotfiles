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

GIT_NAME = 'Mark Caudill'
GIT_EMAIL = mark@mrkc.me
GIT_SIGNINGKEY = 0x5B8069859601013F


.POSIX:

.PHONY: all install install-bins install-editors install-fish install-git install-tmux install-vim uninstall uninstall-bins uninstall-editors uninstall-fish uninstall-git uninstall-tmux uninstall-vim .gitignore

.gitignore:
	curl -s https://gitignore.io/api/vim,visualstudiocode > .gitignore

all: bins editors git libs fish terminals

clean: clean-bins clean-editors clean-git clean-libs clean-fish clean-terminals

install: install-bins install-editors install-git install-libs install-fish install-terminals

uninstall: uninstall-bins uninstall-editors uninstall-git uninstall-libs uninstall-fish uninstall-terminals

##
## Scripts
##
bins:

clean-bins:

install-bins:
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
editors:

clean-editors: clean-vim

install-editors: install-vim
	cp -p .editorconfig $(HOME)/.editorconfig

uninstall-editors: uninstall-vim
	rm -f $(HOME)/.editorconfig

###
### Vim
###
vim:

clean-vim:

install-vim:
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
libs:

clean-libs:

install-libs:
	mkdir -v -p $(HOME)/.local/lib
	cp -v -p -t $(HOME)/.local/lib $(LIBS)

uninstall-libs:
	for lib in $(LIBS); do \
		rm -fv $(HOME)/.local/$$lib ;\
	done


###
### Fish
###
fish:

clean-fish:

install-fish: fish
	mkdir -p $(HOME)/.config
	cp -pr .config/fish $(HOME)/.config/

uninstall-fish:
	rm -rf $(HOME)/.config/fish


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
	cp -p .minttyrc $(HOME)/.minttyrc

uninstall-mintty:
	rm -f $(HOME)/.minttyrc

.minttyrc: .minttyrc.m4
	m4 < .minttyrc.m4 > .minttyrc


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
