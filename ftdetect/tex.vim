au BufRead,BufNewFile *.tex set filetype=tex
" au BufWritePost *.tex :Latex
vnoremap <c-w> :Latex<cr>
nnoremap <c-w> :Latex<cr>
