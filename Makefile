BAK=~/.dotfiles-$(shell date '+%Y-%m-%d_%H%M%S').bak

backup:
	mkdir $(BAK)
	for file in bash_profile bashrc tmux.conf vim vimrc; do \
		mv ~/.$$file $(BAK); \
	done

install:
	for file in bash_profile bashrc tmux.conf vim vimrc; do \
		ln -sf $(shell pwd)/$$file ~/.$$file ; \
	done
