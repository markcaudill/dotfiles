set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" plugins go here
Bundle 'wting/rust.vim'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
