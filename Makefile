DESTINATION = ~

clean: clean-bash clean-editorconfig clean-fish clean-forecast clean-mintty clean-tmux clean-vim

clean-bash:
	rm -f $(DESTINATION)/.bash_profile
	rm -f $(DESTINATION)/.bashrc
	rm -f $(DESTINATION)/.colors

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

bash:
	ln -sf ${PWD}/.bash_profile $(DESTINATION)/
	ln -sf ${PWD}/.bashrc $(DESTINATION)/
	ln -sf ${PWD}/.colors $(DESTINATION)/

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
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	ln -sf ${PWD}/.vimrc $(DESTINATION)/

all: bash editorconfig fish forecast mintty tmux vim

.PHONY: all clean

help:
	@grep -E '^[a-zA-Z_-]+:.*$$' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
