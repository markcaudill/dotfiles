set nocompatible

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\| PlugInstall --sync | source $MYVIMRC
			\| endif

" vim-plug
call plug#begin()
Plug 'huyvohcmc/atlas.vim' " Minimal monochrome theme
Plug 'sainnhe/gruvbox-material' " Theme
Plug 'tpope/vim-fugitive' " Git plugin
Plug 'tpope/vim-rhubarb' " GitHub plugin for fugitive
Plug 'shumphrey/fugitive-gitlab.vim' " GitLab plugin for fugitive
Plug 'editorconfig/editorconfig-vim' " Editorconfig plugin
Plug 'fatih/vim-go' " Go plugin
Plug 'preservim/nerdtree' " File browser plugin
Plug 'hashivim/vim-hashicorp-tools' " Hashicorp plugins (Packer, Terraform, etc.)
Plug 'szw/vim-maximizer' " Maximize Vim windows
Plug 'kristijanhusak/vim-carbon-now-sh'
let g:carbon_now_sh_options =
			\{
				\'t': 'monokai',
				\'bg': '#F5A623',
				\'wt': 'boxy',
				\'wc': 'true',
				\'fm': 'Hack',
				\'fs': '18px',
				\'ln': 'false',
				\'ds': 'true',
				\'dsyoff': '20px',
				\'dsblur': '68px',
				\'wa': 'true',
				\'lh': '133%',
				\'pv': '48px',
				\'ph': '32px',
				\'si': 'false',
				\'wm': 'false',
				\'es': '2x'
			\}
call plug#end()

colorscheme gruvbox-material

set path+=**
set wildmenu

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

" NERDTree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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
