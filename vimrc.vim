" --- Preliminaries ---
set nocompatible
let mapleader = " "
let g:mapleader = " "
nmap <leader>  :
set shiftwidth=2
set expandtab
set autoindent
" Turn off auto word wrapping
set textwidth=0
filetype plugin indent on

" --- Source other files ---
" Settings for Goog
if filereadable(expand('~/.vimrc.goog'))
    source ~/.vimrc.goog
endif

" --- Load Vundle Plugins ---
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'ConradIrwin/vim-bracketed-paste'
Bundle 'SirVer/ultisnips'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'chrisbra/Recover.vim'
Bundle 'croaker/mustang-vim'
Bundle 'dzy689/vim-addon-mw-utils'
Bundle 'honza/vim-snippets'
Bundle 'junegunn/vim-easy-align'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tlib_vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Bundle 'Valloric/YouCompleteMe'
Bundle 'google/vim-maktaba'
Bundle 'davisking/vim-bazel'

" --- Basic settings ---
nmap <leader>W :wq<cr>
nmap <leader>w :w!<cr>
nmap <leader>! :q!<cr>
nmap <leader>q :q<cr>
nmap <leader>t :tabnew<cr>
set mouse=a
inoremap <C-c> <ESC>
nnoremap <leader>r :redraw!<cr>
" Copy current filename to the unnamed register.
nnoremap cp :let @" = expand("%")<cr>
nnoremap <leader>cw :cwindow<cr>
" Timeout options for partial command input
set ttimeout ttimeoutlen=50

" Set up persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" --- Appearance ---
" Highlight cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
" Highlight 100 chars
if (exists('+colorcolumn'))
    set colorcolumn=100
    highlight ColorColumn ctermbg=9
endif
" 5 lines shown after cursor
set scrolloff=5

set laststatus=2  " show status line for all windows

" Set colors
set t_Co=256 " Enable 256-color palette
syntax enable
set background=dark
colorscheme mustang


" Hybrid numbering
set nu rnu
" autocmd InsertEnter * :set norelativenumber number
" autocmd InsertLeave * :set rnu number

" Line Return
" Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" --- Clipboard ---
" Use system clipboard
if has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" --- Navigation ---
nnoremap H ^
nnoremap L $

" Include angle brackets as enclosing symbols
set matchpairs+=<:>

" Splits
noremap <leader>\ :vsp<cr>
noremap <leader>- :sp<cr>
" Edit within dir
nmap <leader>e :vsp %:p:h

" Inserting empty lines
noremap <leader>O :call append(line('.')-1, '')<cr>
noremap <leader>o :call append(line('.'), '')<cr>

" Pane switching
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" --- Search ---
set incsearch
set hlsearch
set backspace=indent,eol,start
set ic " ignore case
set smartcase "Ignore case in search except when query has capital letter

function! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" --- Sort ---
vnoremap <leader>s :sort<CR>

" --- Paths ---
" Show full path quickly
command Path execute "echo expand('%:p')"
" Copy filepath
nnoremap cp :let @+ = expand('%:p')<cr>

" --- Wildmemu ---
set wildmenu
set wildmode=longest,list
if has("wildmenu")
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
    set wildignore+=*.zip,*.exe,*.class,*.jar
endif

" --- Statusline (Deprecated in favor of powerline) ---
" set statusline=   " clear the statusline for when vimrc is reloaded
" set statusline=%t       "tail of the filename
" set statusline=%-0.100F "full path, left-aligned 0-100 chars
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] "file format
" set statusline+=%h      "help file flag
" set statusline+=%m      "modified flag
" set statusline+=%r      "read only flag
" set statusline+=%y      "filetype
" set statusline+=%=      "left/right separator
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file

" --- Plugins ---
" -- Ack.vim --
" Use Ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" -- CtrlP --
let g:ctrlp_max_files=1000000
let g:ctrlp_working_path_mode = 'ra' " Search under CWD
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

" -- Easy align --
vnoremap <silent> <Enter> :EasyAlign<cr>

" Fugitive mappings
command W execute "Gwrite"
command C execute "Gcommit"

" -- NerdTree --
command Nerd execute "NERDTreeToggle"
noremap \\ :NERDTreeToggle<CR>
let NERDTreeBookmarksFile=expand("~/.vim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2

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
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" -- Syntastic --
" Turn off syntastic by default
let g:syntastic_mode_map = {"mode": "passive"}
command Check execute "SyntasticCheck"

" -- Tags --
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarOpenAutoClose<CR>

" -- Ultisnips --
command Snip execute "UltiSnipsEdit"

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnips#SaveLastVisualSelection = "<c-l>"

" -- Whitespace --
command White execute "FixWhitespace"
autocmd BufWritePre * :White

" --- YCM ---
" Close YCM's documentation window
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter = '/usr/bin/python3'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" bind K to grep word under cursor
nnoremap K :Ggrep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>

noremap <C-b> :make<CR>

