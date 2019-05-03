FILES = $(shell find ./ -maxdepth 1 -name ".*" | sort | grep -vE '(\.swp|\.git)' | sed 's/^\.\///g' | xargs)
DESTINATION=~

clean:
	for file in $(FILES); do \
		rm -rf $(DESTINATION)/$$file; \
	done

bash: .bash_profile .bashrc
	ln -sf $(shell pwd)/.bash_profile $(DESTINATION)/
	ln -sf $(shell pwd)/.bashrc $(DESTINATION)/

colors: .colors
	ln -sf $(shell pwd)/.colors $(DESTINATION)/

editorconfig: .editorconfig
	ln -sf $(shell pwd)/.editorconfig $(DESTINATION)/

mintty: .minttyrc
	ln -sf $(shell pwd)/.minttyrc $(DESTINATION)/

tmux: .tmux.conf
	ln -sf $(shell pwd)/.tmux.conf $(DESTINATION)/

todo: .todo
	ln -sf $(shell pwd)/.todo $(DESTINATION)/

vim: .vimrc
	mkdir -p $(DESTINATION)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	ln -sf $(shell pwd)/.vimrc $(DESTINATION)/

install: bash colors editorconfig tmux vim
