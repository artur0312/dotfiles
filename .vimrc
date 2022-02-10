"Local: ~/.vimrc
"Basic settings ------------------{{{
set nocompatible
set rnu
set number 
set numberwidth=4
set ruler
set wrap
set termguicolors
if &term=="alacritty"
	let &term="xterm-256color"
endif
syntax on
set backspace=indent,eol,start
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set scrolloff=3
set matchpairs+=<:> "use % to jump between pairs
set linebreak
set hidden
set autoindent
set cindent

set ttyfast
set laststatus=2


filetype plugin indent on
"}}}

"Leader settings-----------{{{
let mapleader=","
let maplocalleader="\\"
"}}}

"Mappings --------------------------{{{
inoremap jk <Esc>
"disable esc for exiting insert mode
:inoremap <esc> <nop>
"Put current word in uppercase
nnoremap <leader>u  mavawU`a
"Move a line one line down
nnoremap <leader>-	ddp
"Move a line one line up
nnoremap <leader>_ ddkP
"Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"Save vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
"Put current selection between double quotes
vnoremap <leader>' <esc>`<i"<esc>`>la"<esc>
"Put current word between double quotes
nnoremap <leader>' viw<esc>a"<esc>bi"<esc>lel
"Clear highlighting of the search
nnoremap <leader>h :nohlsearch<cr>
"Remap : to ;
nnoremap ; :
vnoremap ; :
"Remap ; to :
nnoremap : ;
vnoremap : ;
"Make the current word uppercase
nnoremap ,U gUiw
"Problems of using alt +tab on alacritty
inoremap [O a<backspace>
inoremap [I a<backspace>
"}}}


"Plug settings --------------------------{{{

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'tomlion/vim-solidity'
call plug#end()

Plug 'arcticicestudio/nord-vim'
colorscheme nord

"}}}

"Nerdtree settings ------------------------{{{
nnoremap  <leader>n :NERDTree<CR>
"	}}}

"Vimscript file settings ------------------{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

"Latex files settings-------------------{{{
"Search for the last ^ and put everything until this point in {}
augroup latex
	autocmd!
	autocmd FileType tex inoremap <leader>b <esc>?\^\\|_<cr>:nohlsearch<cr>a{<esc>``la}
augroup END 
"}}}

function C_Comment()
	execute "normal! I//\<esc>j"
endfunction
augroup c
	autocmd!
	"Comment current line
	autocmd FileType c nnoremap <leader>c :call C_Comment()<CR>
	"Indent all the file
	autocmd FileType c nnoremap <leader>i magg=G`a
	"Insert printf
	autocmd FileType c nnoremap <leader>p iprintf()<esc>i
	
augroup END

function! SwitchSourceHeader()
    if (expand("%:e") == "cpp")
        execute 'tag' join([expand("%:t:r"), "h"], ".")
    else
        execute 'tag' join([expand("%:t:r"), "cpp"], ".")
    endif
endfunction
 
nnoremap <Leader>j :call SwitchSourceHeader()<CR>
nnoremap <Leader>i :vert belowright split<CR>:call SwitchSourceHeader()<CR> " Open alt file in a right pane



if &term =~ '^xterm'
	"solid underscore
	let &t_SI .= "\<Esc>[4 q"
	" solid block
	let &t_EI .= "\<Esc>[2 q"
	" 1 or 0 -> blinking block
	" 3 -> blinking underscore
	" Recent versions of xterm (282 or above) also support
	" 5 -> blinking vertical bar
	" 6 -> solid vertical bar
endif
