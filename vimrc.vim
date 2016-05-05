set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Vundle Plugins
Bundle 'croaker/mustang-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'dzy689/vim-addon-mw-utils'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-commentary'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tpope/vim-surround'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'honza/vim-snippets'
Bundle 'tomtom/tlib_vim'
Bundle 'scrooloose/syntastic'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'junegunn/vim-easy-align'

if filereadable(expand('~/.vimrc.orig'))
    source ~/.vimrc.orig
endif

" " Pathogen
" " To disable a plugin, add it's bundle name to the following list
" let g:pathogen_disabled = []
" call pathogen#infect()
" call pathogen#helptags()

" Pane switching
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnips#SaveLastVisualSelection = "<c-l>"

nnoremap H ^
nnoremap L $

"Define map leader to be space key
let mapleader = " "
let g:mapleader = " "
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>  :
set incsearch
set nohlsearch
set backspace=indent,eol,start

"Tags
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>
inoremap <C-c> <ESC>

" Splits
noremap <leader>\ :vsp<cr>
noremap <leader>- :sp<cr>

noremap <C-y> :set paste!<cr>

" Opening newlines in normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Have manual folds saved and reopened (use ?* to prevent matching empty
" filenames)
" au BufWinLeave ?* mkview
" au BufWinEnter ?* silent loadview

set mouse=a
filetype plugin indent on
set tabstop=4 " Set tabs to 3 spaces to match python "
set shiftwidth=4
set expandtab
set autoindent
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

filetype on
filetype indent on

set ic
set scs
set scrolloff=5

" Hybrid numbering
set nu rnu
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set rnu number


set ttimeout ttimeoutlen=50

nnoremap <leader>t :tabnew<CR>
" Remove underscore from keywords for navigation
" set iskeyword-=_


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
    set wildignore+=*.zip,*.exe,*.class,*.jar
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
if has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Copy-paste from system clipboard
" nnoremap <C-y> "*y
" vnoremap <C-y> "*y
" nnoremap <C-p> "*gP
" vnoremap <C-p> "*gP

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

"CtrlP
let g:ctrlp_max_files=1000000
let g:ctrlp_working_path_mode = 'a' " Search under CWD
let g:ctrlp_root_markers = ['.gitignore']
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'
let g:ctrlp_follow_symlinks=1

" Set up NerdTree
command Nerd execute "NERDTreeToggle"
noremap \\ :NERDTreeToggle<CR>
let NERDTreeBookmarksFile=expand("~/.vim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" Fugitive mappings
command W execute "Gwrite"
command C execute "Gcommit"

" temp
set tags=./tags,~/Dropbox/Projects/trajopt
set tags+=tags;/

" Show full path quickly
command Path execute "echo expand('%:p')"

command Snip execute "UltiSnipsEdit"
command White execute "FixWhitespace"
" Compile Latex
" command Latex execute "silent !pdflatex % > /dev/null && open %:r.pdf > /dev/null 2>&1 &" | redraw!
command Latex execute "silent !pdflatex %" | redraw!
noremap <c-a> :Latex<cr>

" Let syntastic be passive for python, manually check with
" let g:syntastic_mode_map = { 'mode': 'active',
"     \ 'active_filetypes': [],
"     \ 'passive_filetypes': ['python'] }


" Resize splits quickly
nnoremap <silent> <Leader>> :vertical resize +10 <CR>
nnoremap <silent> <Leader>< :vertical resize -10 <CR>
nnoremap <silent> <Leader><Down> :resize -10 <CR>
nnoremap <silent> <Leader><Up> :resize +10 <CR>

" Ack.vim uses Ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" Turn off syntastic by default
let g:syntastic_mode_map = {"mode": "passive"}
command Check execute "SyntasticCheck"
