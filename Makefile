FILES = $(shell find ./ -maxdepth 1 -name ".*" | sort | grep -vE '(\.swp|\.git)' | sed 's/^\.\///g' | xargs)
DESTINATION = ~

clean:
	for file in $(FILES); do \
		rm -rf $(DESTINATION)/$$file; \
	done

bash: .bash_profile .bashrc .colors
	ln -sf ${pwd}/.bash_profile $(DESTINATION)/
	ln -sf ${pwd}/.bashrc $(DESTINATION)/
	ln -sf ${pwd}/.colors $(DESTINATION)/

editorconfig: .editorconfig
	ln -sf ${pwd}/.editorconfig $(DESTINATION)/

fish: .config/fish
	mkdir -p $(DESTINATION)/.config
	ln -sf ${pwd}/.config/fish $(DESTINATION)/.config/

forecast: .forecast.io
	ln -sf ${pwd}/.forecast.io $(DESTINATION)/.forecast.io.example

mintty: .minttyrc
	ln -sf ${pwd}/.minttyrc $(DESTINATION)/

tmux: .tmux.conf
	ln -sf ${pwd}/.tmux.conf $(DESTINATION)/

vim: .vimrc
	mkdir -p $(DESTINATION)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	ln -sf ${pwd}/.vimrc $(DESTINATION)/

install: bash editorconfig fish forecast mintty tmux vim
