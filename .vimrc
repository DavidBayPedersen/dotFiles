syntax on

set t_Co=256
set incsearch
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase

call plug#begin('~/.vim/plugged')

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'valloric/youcompleteme'


"Coloring: 
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark

"mappings :

let mapleader=' ' 

"window movement
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>

"Normal navigation 
nnoremap <leader>e <C-e>
nnoremap <leader>y <C-y>

"YCM goto 
nnoremap <leader>gd :YcmCompleter GoTo<CR>



