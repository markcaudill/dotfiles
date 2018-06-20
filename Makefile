BAK=~/.dotfiles-$(shell date '+%Y-%m-%d_%H%M%S').bak
DESTINATION=~

backup:
	mkdir $(BAK)
	for file in bash_profile bashrc colors editorconfig git-prompt.sh tmux.conf todo vim vimrc; do \
		mv $(DESTINATION)/.$$file $(BAK); \
	done

clean:
	rm -f $(DESTINATION)/.bash_profile
	rm -f $(DESTINATION)/.bashrc
	rm -f $(DESTINATION)/.colors
	rm -f $(DESTINATION)/.editorconfig
	rm -f $(DESTINATION)/.tmux.conf
	rm -rf $(DESTINATION)/.vim
	rm -f $(DESTINATION)/.vimrc

bash: bash_profile bashrc
	ln -sf $(shell pwd)/bash_profile $(DESTINATION)/.bash_profile
	ln -sf $(shell pwd)/bashrc $(DESTINATION)/.bashrc
	ln -sf $(shell pwd)/colors $(DESTINATION)/.colors

editorconfig: editorconfig
	ln -sf $(shell pwd)/editorconfig $(DESTINATION)/.editorconfig

tmux: tmux.conf
	ln -sf $(shell pwd)/tmux.conf $(DESTINATION)/.tmux.conf

vim: vim vimrc
	ln -sf $(shell pwd)/vim $(DESTINATION)/.vim
	ln -sf $(shell pwd)/vimrc $(DESTINATION)/.vimrc
	mkdir -p $(DESTINATION)/.vim/bundle
	vim +PluginInstall +qall

install: bash colors editorconfig tmux vim
