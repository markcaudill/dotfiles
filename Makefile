BAK=~/.dotfiles-$(shell date '+%Y-%m-%d_%H%M%S').bak
TARGET=~

backup:
	mkdir $(BAK)
	for file in bash_profile bashrc colors editorconfig git-prompt.sh tmux.conf todo vim vimrc; do \
		mv $(TARGET)/.$$file $(BAK); \
	done

install:
	mkdir -p $(TARGET)/.vim/bundle; \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	for file in bash_profile bashrc colors editorconfig git-prompt.sh tmux.conf todo vim vimrc; do \
		ln -sf $(shell pwd)/$$file $(TARGET)/.$$file ; \
	done;\
	vim +PluginInstall +qall
