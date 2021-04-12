set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin directives go here
Plugin 'tpope/vim-fugitive' " Git plugin
Plugin 'tpope/vim-rhubarb.git' " GitHub plugin for fugitive
Plugin 'shumphrey/fugitive-gitlab.vim' " GitLab plugin for fugitive
Plugin 'editorconfig/editorconfig-vim' " Editorconfig plugin
Plugin 'fatih/vim-go.git' " Go plugin
call vundle#end()
filetype plugin indent on
" /Vundle

set path+=**
set wildmenu
syntax enable

" Enable line numbers
set number
set relativenumber

" Enable undo history
set undofile
set undodir=~/.vim/undo

" Disable arrow keys (easier for Ducky mini which has arrows as Fn keys at
" kl;o)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Run goimports every save
let g:go_fmt_command = "goimports"

" Markdown preview generator using pandoc (via STDIN) and xdg-open
" Essentially: `cat <tmp_markdown> | pandoc > <tmp_html>; xdg-open <tmp_html>`
function MarkdownPreview()
	:let TMPIN = systemlist("mktemp --suffix .md")[0]
	:let TMPOUT = systemlist("mktemp --suffix .html")[0]
	:execute "w! " . TMPIN
	:silent execute "!cat " . TMPIN . " | pandoc -s -f markdown -t html 2>/dev/null 1> " . TMPOUT
	:silent execute "!xdg-open " . TMPOUT . " &>/dev/null"
	:redraw!
endfunction
:nmap <Leader>p :call MarkdownPreview()<CR>

" Create vertical split terminal to the right (and below if applicable)
nnoremap <silent> <Leader>t :rightbelow vertical terminal<CR>

" Resize vertical splits
nnoremap <silent> <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
