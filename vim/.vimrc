execute pathogen#infect() 

filetype on
syntax on 
filetype plugin indent on 

" solarized setup
set background=dark
colorscheme solarized

" turn on line numbers
set nu

" search options 
set hlsearch
set incsearch
set ignorecase

" get rid of the annoying popping sound on errors
set noerrorbells

" make backspace behave like it is supposed to
set backspace=eol,start,indent

" keep 10 lines of context when moving vertically
set so=10

" make sure tab width is 4 when displaying, editing, and indenting text
" but keep actual tab width at default (8) to preserve formatting in 
" other text editors 
set softtabstop=4 shiftwidth=4 noexpandtab smarttab shiftround autoindent

" preserve code folds between sessions
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview

" options for syntax/python.vim
let python_version_2=1
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_string_formatting=1
let python_print_as_function=1

"""""""""""""""""""
"" Abbreviations ""
"""""""""""""""""""
abbr Flase False


""""""""""""""""""
"" Key Bindings ""
""""""""""""""""""

" set a mapleader that doesn't suck :3
let mapleader = ","
let g:mapleader = ","

" Fast save
nmap <leader>w :w!<CR>
" Quick quit w/o saving 
nnoremap ZX ZQ 
nnoremap XZ ZQ
" Quick shell cmd execution
nnoremap :: :!
" Press F3 to clear highlighting from last search
nnoremap <F3> :let @/ = ""<CR>
" Easy movement from buffer to buffer
map <leader><c-h> <c-w>h
map <leader><c-j> <c-w>j
map <leader><c-k> <c-w>k
map <leader><c-l> <c-w>l
" Intuitive movement, even in the face of wrapped lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0 
noremap <buffer> <silent> $ g$ 
" Fast vertical movement (probably temporary solution)
nmap <c-j> 10j
nmap <c-k> 10k
" Open nerdtree
nnoremap <leader>t :NERDTree<CR>
" Easy paste that is never overridden by delete
nnoremap <leader>p "0p
