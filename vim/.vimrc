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
set softtabstop=4 shiftwidth=4 noexpandtab autoindent shiftround smarttab

" preserve code folds between sessions
autocmd BufWinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview
" but don't preserve the current .vimrc settings
set viewoptions-=options

" always show the statusline
set laststatus=2
set showtabline=2
set noshowmode

" the sweet spot for timeoutlen
" low enough that the transition from insert mode to normal mode feels
" seamless, high enough that key combos can be executed at a reasonable
" speed without timing out
set timeoutlen=150

" options for syntax/python.vim
let python_version_2=1
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_string_formatting=1
let python_print_as_function=1

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler_options = "-std=c++11"

" NERDTree settings
let NERDTreeDirArrows = 0

" airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

"""""""""""""""""""
"" Abbreviations ""
"""""""""""""""""""
abbr Flase False

"""""""""""""""""""""
"" Custom Fuctions ""
"""""""""""""""""""""

" Complements the window movement keybindings
function! WinMove(key) 
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else 
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

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

" Easy window movement, opening, closing, and swapping
" lowercase asdf to move to a window in that direction
" if there is no window in that direction, create one
map <leader>a        :call WinMove('h')<cr>
map <leader>s        :call WinMove('j')<cr>
map <leader>d        :call WinMove('k')<cr>
map <leader>f        :call WinMove('l')<cr>
" uppercase ASDF to swap windows
map <leader>A        :wincmd H<cr>
map <leader>S        :wincmd J<cr>
map <leader>D        :wincmd K<cr>
map <leader>F        :wincmd L<cr>
" close a window
map <leader>c        :wincmd q<cr>
" rotate windows
map <leader>r        <C-W>r

" Intuitive movement, even in the face of wrapped lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
"noremap <buffer> <silent> 0 g0
"noremap <buffer> <silent> $ g$
" Fast vertical movement (probably temporary solution)
nmap <c-j> 10j
nmap <c-k> 10k
" Open nerdtree
nnoremap <leader>t :NERDTree<CR>
" Easy paste that is never overridden by delete
nnoremap <leader>p "0p
" Experimental unimpaired rebindings
nnoremap [j :lprev<cr>
nnoremap ]j :lnext<cr>
" Close buffer
nmap <leader>q :Bdelete<cr>
