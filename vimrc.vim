set nocompatible

" Plugins {{{
" Pathogen
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'supertab')
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

" Allow gnome-term to recognize Alt
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set ttimeout ttimeoutlen=50

" Delete/insert blank line below/above, sorry for weird key mappings,
" correspond to Dvorak home row
nnoremap <silent><A-n> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-d> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-h> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-t> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Window management shortcuts
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l

" Tab navigation like Chrome
nnoremap <S-C-Tab> :tabprevious<CR>
" nnoremap <C-Tab> :tabnext<CR>
" nnoremap <A-]> :!echo 'hello' <CR>

" Set up ConqueTerm
command Ct execute "ConqueTermVSplit bash"
command Cht execute "ConqueTermSplit bash"
command Cct execute "ConqueTerm bash"

" Remove underscore from keywords for navigation
set iskeyword-=_

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

" Jedi options
autocmd FileType python setlocal completeopt-=preview
let g:jedi#rename_command = "<leader>r"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#documentation_command = "K"

"Define map leader to be space key
let mapleader = " "
let g:mapleader = " "
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>  :

" Copy-paste from system clipboard
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" Use system clipboard
" set clipboard=unnamedplus

"if exists('$TMUX')
"  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
"    let previous_winnr = winnr()
"    silent! execute "wincmd " . a:wincmd
"    if previous_winnr == winnr()
"      call system("tmux select-pane -" . a:tmuxdir)
"      redraw!
"    endif
"  endfunction
"
"  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
"  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
"  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
"
"  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
"  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
"  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
"  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
"else
"  map <C-h> <C-w>h
"  map <C-j> <C-w>j
"  map <C-k> <C-w>k
"  map <C-l> <C-w>l
"endif

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

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

" Set up persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Set colors
set t_Co=256 " Enable 256-color palette
syntax enable
set background=dark
" colorscheme solarized
colorscheme mustang
" colorscheme badwolf
"

" Add support for golang
" Clear filetype flags before changing runtimepath to force Vim to reload
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on

" Statusline
" hi User1 ctermbg=green ctermfg=red
" hi User2 ctermbg=red   ctermfg=blue
" hi User3 ctermbg=blue  ctermfg=green

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
