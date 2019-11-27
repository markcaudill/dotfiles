set shell=bash
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Dracula Theme
Plugin 'dracula/vim', { 'name': 'dracula' }

" vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" EditorConfig
Plugin 'editorconfig/editorconfig-vim'

" Clojure Plugins
Plugin 'guns/vim-clojure-highlight'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'tpope/vim-salve'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fireplace'

" Ledger Plugins
Plugin 'ledger/vim-ledger'

" Markdown Plugins
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Ansible Plugins
Plugin 'pearofducks/ansible-vim'

" Dockerfile Plugins
Plugin 'ekalinin/dockerfile.vim'

" Shell Plugins
Plugin 'dag/vim-fish'

"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Try to setup the colorscheme
set rtp+=~/.vim/bundle/dracula
syntax on
set t_Co=256
try
    colorscheme dracula
catch
    " Meh
endtry

set number relativenumber
set nu rnu
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

" Keep cursor in vertically centered if possible
set so=999

"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

filetype indent on
filetype plugin on

let python_highlight_all=1

let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
au BufRead,BufNewFile */inventory set filetype=yaml.ansible

let g:vim_markdown_new_list_item_indent = 2
au BufRead,BufNewFile *.md setlocal textwidth=80

" Timestamp macro
ia dt <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
