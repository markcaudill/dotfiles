set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin directives go here
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on
" /Vundle

set path+=**
set wildmenu
syntax enable

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
