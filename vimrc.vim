set nocompatible 

" Plugins {{{
" Pathogen
call pathogen#infect()
call pathogen#helptags()

 
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
filetype plugin indent on
 
" Nerdtree
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
command Nerd execute "NERDTreeToggle"

" }}}

" Line Return {{{

" Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

" Set up wildmenu
set wildmenu
set wildmode=longest,list
if has("wildmenu")
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
endif

set tabstop=4 " Set tabs to 3 spaces to match python "
set shiftwidth=4
set expandtab
set autoindent
set mouse=a

filetype on
filetype indent on

set ic
set scs
set nu

" Window management shortcuts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

command Ct execute "ConqueTermVSplit bash"
command Cct execute "ConqueTerm bash"

filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Turn on omnicompletion
filetype plugin on
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"Define map leader to be space key
let mapleader = " "
let g:mapleader = " "
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>  :

"Copy-paste from system clipboard
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" Set colors
set t_Co=256 " Enable 256-color palette
syntax enable 
set background=dark
colorscheme solarized
" colorscheme badwolf
