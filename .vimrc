" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.vim/plugged')

Plug 'zivyangll/git-blame.vim'
Plug 'dense-analysis/ale'
Plug 'pacha/vem-tabline'
Plug 'vim-airline/vim-airline'
Plug 'gmoe/vim-espresso'
Plug 'vim-python/python-syntax'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py' }

call plug#end()

"------------------------------------------------------------
" General
"------------------------------------------------------------
set fileformats=unix,dos
set clipboard=unnamedplus
set hidden
set mouse=a
set confirm
set visualbell t_vb=

set background=dark
"colorscheme espresso

"------------------------------------------------------------
" UI
"------------------------------------------------------------
syntax on
filetype plugin indent on

set number
set ruler
set laststatus=2
set cmdheight=2
set wildmenu
set showcmd

"------------------------------------------------------------
" Search
"------------------------------------------------------------
set hlsearch
set ignorecase
set smartcase

"------------------------------------------------------------
" Editing
"------------------------------------------------------------
set backspace=indent,eol,start
set autoindent
set nostartofline
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

set shiftwidth=4
set softtabstop=4
set expandtab

"------------------------------------------------------------
" Keymaps
"------------------------------------------------------------
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

nnoremap Y y$
nnoremap <C-L> :nohl<CR><C-L>

"------------------------------------------------------------
" Plugin settings
"------------------------------------------------------------
let g:python_highlight_all = 1

let g:airline#extensions#tabline#enabled = 1

let g:ale_linters = {
\  'python':     ['ruff', 'mypy'],
\  'sh':         ['shellcheck'],
\  'javascript': ['eslint'],
\}
let g:ale_fixers = {
\  '*':          ['trim_whitespace'],
\  'python':     ['ruff', 'ruff_format'],
\  'javascript': ['eslint', 'prettier'],
\  'css':        ['prettier'],
\  'cpp':        ['clang-format'],
\}
let g:ale_fix_on_save = 1
let g:ale_echo_cursor = 0
