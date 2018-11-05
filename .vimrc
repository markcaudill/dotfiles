set shell=/bin/bash
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-fireplace'
Plugin 'dag/vim-fish'
Plugin 'dracula/vim'
Plugin 'vim-scripts/paredit.vim'
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set t_Co=256
colorscheme dracula

set number
set ruler
set laststatus=2
set showcmd
" Autocomplete filenames
set wildmenu
set wildignore=*.o,*.hi,*.pyc

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tabs and indents
set tabstop=4
set softtabstop=4 " Make spaces feel like real tabs
set expandtab " When pressing tab, insert [tabstop] spaces
set shiftwidth=4 " When indenting use x spaces
set autoindent " Keep indentation from previous line

" Folding
set foldmethod=indent
set foldlevel=20

"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

filetype indent on
filetype plugin on

let python_highlight_all=1

" Timestamp macro
ia dt <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
