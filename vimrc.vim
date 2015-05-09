set runtimepath+=~/vim

set nocompatible
" Pathogen
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
call pathogen#infect()
call pathogen#helptags()


"Define map leader to be space key
let mapleader = " "
let g:mapleader = " "
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>  :

"Tags
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>


set mouse=a
filetype plugin indent on
set tabstop=4 " Set tabs to 3 spaces to match python "
set shiftwidth=4
set expandtab
set autoindent

filetype on
filetype indent on

set ic
set scs
set nu

set ttimeout ttimeoutlen=50

" Remove underscore from keywords for navigation
" set iskeyword-=_


" Set up NerdTree
command Nerd execute "NERDTreeToggle"

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction


" Line Return
" Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END


" Set up wildmenu
set wildmenu
set wildmode=longest,list
if has("wildmenu")
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
endif


" Set up ConqueTerm
command Ct execute "ConqueTermVSplit bash"
command Cht execute "ConqueTermSplit bash"
command Cct execute "ConqueTerm bash"

" Turn on omnicompletion
filetype plugin on
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Use system clipboard
set clipboard=unnamed
" Copy-paste from system clipboard
nnoremap <C-y> "*y
vnoremap <C-y> "*y
nnoremap <C-p> "*gP
vnoremap <C-p> "*gP

" Close Jedi's documentation window
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Set up persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Set colors
set t_Co=256 " Enable 256-color palette
syntax enable
set background=dark
colorscheme mustang


" Add support for golang
" Clear filetype flags before changing runtimepath to force Vim to reload
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on

" Avoid having to manually set paste
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline=%t       "tail of the filename
" set statusline=%-0.100F "full path, left-aligned 0-100 chars
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" temp
set tags=./tags,~/Dropbox/Projects/trajopt
set tags+=tags;/
