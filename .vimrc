" name of shell to use for external commands
set shell=bash
" Don't behave Vi-compatible as much as possible
set nocompatible
" use GUI colors for the terminal
set termguicolors

" This is only necessary if you use "set termguicolors" and tmux.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif


" Vundle

"disable file type detection; necessary until after Vundle is initialized
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Dracula Theme
Plugin 'dracula/vim', { 'name': 'dracula' }

" Try to setup the colorscheme
set rtp+=~/.vim/bundle/dracula
syntax on
set t_Co=256
try
    colorscheme dracula
catch
    " Meh
endtry


" eunuch.vim: Helpers for UNIX
Plugin 'tpope/vim-eunuch'

" Improved nginx vim plugin (incl. syntax highlighting)
Plugin 'chr4/nginx.vim'

" Highlight insecure SSL configuration in Vim
Plugin 'chr4/sslsecure.vim'

" lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" EditorConfig plugin for Vim
Plugin 'editorconfig/editorconfig-vim'



" Language- and Syntax-specific Plugins and Configurations

" Clojure

" Better Rainbow Parentheses
Plugin 'kien/rainbow_parentheses.vim'
" Enable rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound


" fireplace.vim: Clojure REPL support
Plugin 'tpope/vim-fireplace'

" Extend builtin syntax highlighting to referred and aliased vars in Clojure
" buffers
Plugin 'guns/vim-clojure-highlight'

" projectionist.vim: Granular project configuration
Plugin 'tpope/vim-projectionist'

" salve.vim: static support for Leiningen and Boot
Plugin 'tpope/vim-salve'

" Precision Editing for S-expressions
Plugin 'guns/vim-sexp'

" vim-sexp mappings for regular people
Plugin 'tpope/vim-sexp-mappings-for-regular-people'


" Go
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

" Go development plugin for Vim
Plugin 'fatih/vim-go'


" Vim plugin for Ledger
Plugin 'ledger/vim-ledger'

" Vim script for text filtering and alignment
Plugin 'godlygeek/tabular'

" Markdown Vim Mode
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_new_list_item_indent = 2
au BufRead,BufNewFile *.md setlocal textwidth=80

" Text outlining and task management for Vim based on Emacs' Org-Mode
Plugin 'jceb/vim-orgmode'

" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
Plugin 'tpope/vim-speeddating'

" A calendar application for Vim
Plugin 'itchyny/calendar.vim'

" Univeral Text Linking - Execute URLs, footnotes, open emails, organize ideas
Plugin 'vim-scripts/utl.vim'

" A vim plugin for syntax highlighting Ansible's common filetypes
Plugin 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
au BufRead,BufNewFile */inventory set filetype=yaml.ansible

" Vim syntax file & snippets for Docker's Dockerfile
Plugin 'ekalinin/dockerfile.vim'

" Vim support for editing fish scripts
Plugin 'dag/vim-fish'

" basic vim/terraform integration
Plugin 'hashivim/vim-terraform'

"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" print the line number in front of each line
set number
" show relative line number in front of each line
set relativenumber
" show cursor line and column in the status line
set ruler
" tells when last window has status lines
set laststatus=2
" show (partial) command in status line
set showcmd
" use menu for command line completion
set wildmenu
" files matching these patterns are not completed
set wildignore=*.o,*.hi,*.pyc
" highlight matches with last search pattern
set hlsearch
"highlight match while typing search pattern
set incsearch
" ignore case in search patterns
set ignorecase
" no ignore case when pattern has uppercase
set smartcase
" number of spaces that <Tab> in file uses
set tabstop=4
" number of spaces that <Tab> uses while editing
set softtabstop=4 " Make spaces feel like real tabs
" use spaces when <Tab> is inserted
set expandtab " When pressing tab, insert [tabstop] spaces
" number of spaces to use for (auto)indent step
set shiftwidth=4 " When indenting use x spaces
" take indent for new line from previous line
set autoindent " Keep indentation from previous line
" folding type
set foldmethod=indent
" close folds with a level higher than this
set foldlevel=20
" minimum nr. of lines above and below cursor
set so=999
"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

let python_highlight_all=1

" Timestamp macro
ia dt <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
