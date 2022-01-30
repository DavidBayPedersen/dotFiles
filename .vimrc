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

"install vim-plug if it's not already
augroup PLUGGED
	if empty(glob('~/.vim/autoload/plug.vim'))  " Vim
		silent !curl -fo ~/.vim/autoload/plug.vim --create-dirs
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
augroup end

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'

"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'lervag/vimtex'

"Coloring: 
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark



"Code completing: 
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect

"Should install coc language servers"


filetype plugin indent on


    
:command Exportpdf hardcopy > tmpExport.ps | !ps2pdf tmpExport.ps Digi1Eksame2021.pdf && rm tmpExport.ps
:command Ep Exportpdf

"Get Different syntax highligting within regons of a file 
"https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ keepend
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

:command Highlightc call TextEnableCodeSnip(  'c',   'BEGIN_c',   'END_c', 'SpecialComment')
:command Highlightvhdl call TextEnableCodeSnip(  'vhdl',   'BEGIN_vhdl', 'END_vhdl', 'SpecialComment')

:command TapB ! cd ../TapSystemEmbedded.Skia.Gtk && dotnet run 

"Snipets 
"let g:UltiSnipsExpandTrigger=""
"let g:UltiSnipsJumpForwardTrigger="<C-s>"
"let g:UltiSnipsJumpBackwardTrigger="<C->"

" Use <C-l> for trigger snippet expand.
"imap <> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<tab>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-k>'


"mappings :
let mapleader=' ' 

"coc"
"Tap completion: 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
nnoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <leader>dn :call CocAction('diagnosticNext')<CR>
nnoremap <leader>dp :call CocAction('diagnosticPrevious')<CR>
nnoremap <leader>dgd :call CocAction('jumpDefinition')<CR> 
nnoremap <leader>dgc :call CocAction('jumpDeclaration')<CR> 
nnoremap <leader>gb <C-t>


"To use tab to pick coc popup, as wanted 
inoremap <Tab> <XDown>
inoremap <S-Tab> <XUp>
inoremap <leader><Tab> <Tab>

" Show Documentaion in different window:
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction



" from coc:
" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"window movement
nnoremap <leader>n :NERDTree<CR>

nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wl :wincmd l<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>

nnoremap <leader>wH :wincmd H<CR>
nnoremap <leader>wL :wincmd L<CR>
nnoremap <leader>wJ :wincmd J<CR>
nnoremap <leader>wK :wincmd K<CR>

nnoremap <leader>w\| :wincmd \|<CR>
nnoremap <leader>w_ :wincmd _<CR>
nnoremap <leader>w= :wincmd =<CR>

"Normal navigation 
nnoremap <leader>e <C-e>
nnoremap <leader>y <C-y>

"YCM goto 
"nnoremap <leader>gd :YcmCompleter GoTo<CR>
