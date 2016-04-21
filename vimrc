set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Vundle/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()


syntax on
set t_Co=256
colorscheme slate

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
