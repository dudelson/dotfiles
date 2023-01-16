execute pathogen#infect()
" automatically generate helptags for all plugins
execute pathogen#helptags()

" vim-specific settings
if !has('nvim')
    filetype on
    filetype plugin indent on

    " make backspace behave like it is supposed to
    set backspace=eol,start,indent

    set encoding=utf-8

    set autoindent smarttab

    set hlsearch      " highlight the search term
    set incsearch     " show results incrementally as you type (like google instant search)

    set ttyfast

    set laststatus=2  " always show the statusline

    " enable wildmenu for advanced tab completion in command mode
    set wildmenu
endif

syntax on

" there are many known security issues involving modelines, best to disable them
set modelines=0

" solarized setup
set background=light
colorscheme solarized

" turn on relative line numbers
" but show the absolute line number for the line the cursor is on
set relativenumber
set number

" display a line at 80 characters
set colorcolumn=80

" highlight the line the cursor is on (can be toggled with unimpaired)
set cursorline

" allows me to move to another buffer without abandoning the previous buffer
" see :h hidden, :h abandon
set hidden

" text wrap settings
"set textwidth=79 " automatically break lines after this many chars
"set formatoptions=??

" search options
set ignorecase
set smartcase     " overrides ignorecase if there are capital letters in the search string
set gdefault      " apply substitutions globally on lines by default

" get rid of the annoying popping sound on errors
set noerrorbells
set visualbell

" keep 10 lines of context when moving vertically
set so=10

" make sure tab width is 4 when displaying, editing, and indenting text
" but keep actual tab width at default (8) to preserve formatting in
" other text editors
set softtabstop=4 shiftwidth=4 expandtab shiftround

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" this feature does not appear to work in nvim as of 7/25/16
if !has('nvim')
    " preserve code folds between sessions
    autocmd BufWinLeave * if expand("%") != "" | mkview | endif
    autocmd BufWinEnter * if expand("%") != "" | loadview | endif
    " but don't preserve the current .vimrc settings
    set viewoptions-=options
endif

" autosave
au FocusLost * nested silent! wa

set showtabline=2
set noshowmode
" show partial commands (in visual mode, shows size of selected area)
set showcmd

set wildmode=list:longest

" make vim create "undo files" whenever we edit a file
" these allow us to undo changes, even after closing and reopening a file
set undofile

" allow project-specific .vimrc files to be sourced
set exrc
set secure

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
" these three were not playing well with airline, see :h airline-syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '!'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler_options = "-std=c++11 -fsyntax-only"

" airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
" disable powerline.vim (because I'm using airline instead)
let g:powerline_loaded = 1

" rainbow parentheses settings
let g:rainbow_active = 0 " only active when explicitly activated via :RainbowToggle
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'NavyBlue', 'lightgreen', 'darkmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold',
    \                   'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick',
    \                      'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/',
    \                           'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody',
    \                           'start=/\[/ end=/\]/ containedin=vimFuncBody',
    \                           'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

"""""""""""""""""""
"" Abbreviations ""
"""""""""""""""""""
abbr Flase False

"""""""""""""""""""""
"" Custom Fuctions ""
"""""""""""""""""""""

" Implements the window movement keybindings
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
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

let maplocalleader = "`"
let g:maplocalleader = "`"

" Escape to return to normal mode is probably the command issued the most,
" so why move your hands from the home row to do it?
inoremap jk <ESC>
inoremap kj <ESC>
vnoremap jk <ESC>
vnoremap kj <ESC>
" Also ween myself off of the old way of escaping
"inoremap <c-[> <NOP>
"vnoremap <c-[> <NOP>
" Fast save
nmap <leader>fs :w!<CR>
" Quick quit w/o saving
nnoremap ZX ZQ
nnoremap XZ ZQ
" Quick close all buffers
nnoremap <leader>z :qa<CR>
" Quick close all buffers w/o saving
nnoremap <leader>Z :qa!<CR>
" Quick shell cmd execution
nnoremap :: :!
" Clear highlighting from last search
nnoremap <silent> <F3> :let @/ = ""<CR>

" Easy window movement, opening, closing, and swapping
" lowercase asdf to move to a window in that direction
" if there is no window in that direction, create one
map <leader>wh        :call WinMove('h')<cr>
map <leader>wj        :call WinMove('j')<cr>
map <leader>wk        :call WinMove('k')<cr>
map <leader>wl        :call WinMove('l')<cr>
" uppercase ASDF to swap windows
map <leader>wH        :wincmd H<cr>
map <leader>wJ        :wincmd J<cr>
map <leader>wK        :wincmd K<cr>
map <leader>wL        :wincmd L<cr>
" close a window
map <leader>wc       :wincmd q<cr>
" rotate windows
map <leader>wR        <C-W>r

" Close buffer (depends on bbye plugin)
nnoremap <leader>bd      :Bdelete<cr>

" Intuitive movement, even with wrapped lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
"noremap <buffer> <silent> 0 g0
"noremap <buffer> <silent> $ g$
" Yank to system clipboard. Text to be yanked should be selected with visual
" mode
vnoremap gy "+y
" Paste from system clipboard. This overwrites a builtin vim movement!
nnoremap gp "+p
nnoremap gP "+P
" Easy paste that is never overridden by delete
nnoremap <leader>p "0p
nnoremap <leader>P "0P
" repeat the last normal mode command in visual mode
vnoremap . :norm.<CR>
" toggle rainbow parens
nnoremap cop :RainbowToggle<CR>
" open ctags definitions in new horizontal split
nnoremap <C-\> <C-w><C-]>
