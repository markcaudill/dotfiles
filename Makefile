DESTINATION = ~
DESTINATION_BIN = ~/bin

clean: clean-bash clean-bin clean-editorconfig clean-fish clean-forecast clean-mintty clean-tmux clean-vim

clean-bash:
	rm -f $(DESTINATION)/.bash_profile
	rm -f $(DESTINATION)/.bashrc
	rm -f $(DESTINATION)/.colors

clean-bin:
	rm -f $(DESTINATION_BIN)/battery
	rm -f $(DESTINATION_BIN)/dinfo
	rm -f $(DESTINATION_BIN)/extract
	rm -f $(DESTINATION_BIN)/notes
	rm -f $(DESTINATION_BIN)/sysinfo
	rm -f $(DESTINATION_BIN)/uua

clean-editorconfig:
	rm -f $(DESTINATION)/.editorconfig

clean-fish:
	rm -rf $(DESTINATION)/.config/fish

clean-forecast:
	rm -f $(DESTINATION)/.forecast.io.example

clean-mintty:
	rm -f $(DESTINATION)/.minttyrc

clean-tmux:
	rm -f $(DESTINATION)/.tmux.conf

clean-vim:
	rm -rf $(DESTINATION)/.vim/bundle
	rm -f $(DESTINATION)/.vimrc

clean-xresources:
	rm -f $(DESTINATION)/.Xresources

bash:
	ln -sf ${PWD}/.bash_profile $(DESTINATION)/
	ln -sf ${PWD}/.bashrc $(DESTINATION)/
	ln -sf ${PWD}/.colors $(DESTINATION)/

bin:
	ln -sf ${PWD}/bin/battery $(DESTINATION_BIN)/battery
	ln -sf ${PWD}/bin/dinfo $(DESTINATION_BIN)/dinfo
	ln -sf ${PWD}/bin/extract $(DESTINATION_BIN)/extract
	ln -sf ${PWD}/bin/notes $(DESTINATION_BIN)/notes
	ln -sf ${PWD}/bin/sysinfo $(DESTINATION_BIN)/sysinfo
	ln -sf ${PWD}/bin/uua $(DESTINATION_BIN)/uua

editorconfig:
	ln -sf ${PWD}/.editorconfig $(DESTINATION)/

fish:
	mkdir -p $(DESTINATION)/.config
	ln -sf ${PWD}/.config/fish $(DESTINATION)/.config/

forecast:
	ln -sf ${PWD}/.forecast.io $(DESTINATION)/.forecast.io.example

mintty:
	ln -sf ${PWD}/.minttyrc $(DESTINATION)/

tmux:
	ln -sf ${PWD}/.tmux.conf $(DESTINATION)/

vim:
	mkdir -p $(DESTINATION)/.vim/bundle
	ln -sf ${PWD}/.vimrc $(DESTINATION)/
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

xresources:
	ln -sf ${PWD}/.Xresources $(DESTINATION)/

all: bash bin editorconfig fish forecast mintty tmux vim

.PHONY: all bash bin clean clean-bash clean-bin clean-editorconfig clean-fish clean-forecast clean-mintty clean-tmux clean-vim clean-xresources editorconfig fish forecast help mintty tmux vim xresources

help:
	@grep -E '^[a-zA-Z_-]+:.*$$' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
