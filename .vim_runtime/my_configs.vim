" Mapping <C-J> to split line
nmap <C-J> a<CR><Esc>k$

" Mapping <F3> to bash current line
nnoremap <F3> :.w !bash<CR>

" Mapping <C-S> to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>


set clipboard=unnamedplus

