" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" ---------- Vundle settings --------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'

" Themes and colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'notpratheek/vim-luna'

" Python related plugins
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'nvie/vim-flake8'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'python-mode/python-mode'

call vundle#end()  
filetype plugin indent on 
" -----------------------------------------------------------------------------

" allow backspacing in insert mode --------------
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
" ------------------------------------------------

" Enable Mouse -----------------------------------
if has('mouse')
  set mouse=a
endif
" ------------------------------------------------

" Switch syntax highlighting on ------------------
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" ------------------------------------------------

" General settings -------------------------------
set history=50		   " keep 50 lines of command line history
set incsearch	   	   " do incremental searching
set scrolloff=4        " 4 lines buffer for scroll
set hidden             " allow buffers to be open in background
filetype plugin on     " update for nerdcommenter plugin
set noshowmode         " hide default status line
set nonu               " hide linenumber column
set encoding=utf8
" set cpoptions+=$       " add $ at end of c command
" set clipboard=unnamed
set tabstop=4
set softtabstop=4
set shiftwidth=4
 
" ------------------------------------------------

" Python related settings ------------------------
let python_highlight_all = 1
" set tab to 4 
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

set expandtab
" highlight extra whitespaces
" highlight ExtraWhitespace ctermbg=darkgreen
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match ExtraWhitespace /\s\+$/
" au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertLeave * match ExtraWhitespace /\s\+$/

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
" let g:syntastic_python_checkers = ['pep8', 'flake8']
let g:syntastic_python_checkers = ['pep8']

" ------------------------------------------------

" Colorscheme ------------------------------------
" Enable 256 color schemes
set term=screen-256color
set t_Co=256
colorscheme luna-term
let g:airline_theme='customtheme'
" ------------------------------------------------

" Keymappings ------------------------------------
let mapleader = ","    " set <leader> to ,

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" shortcut for multiple indents on same visual group
vnoremap <s-tab> <gv
vnoremap <tab> >gv

" save current file by <leader>s
noremap <Leader>s :update<CR>

" map semicolon to colon
nmap ; :

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
"nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
"nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
"nnoremap <CR> :set paste<CR>m`o<Esc>``:set nopaste<CR>
"nnoremap <C-CR> :set paste<CR>m`O<Esc>``:set nopaste<CR>
" ------------------------------------------------

" vim-airline statusline--------------------------
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 0
set timeoutlen=1000 ttimeoutlen=0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#default#section_truncate_width = {'y':0,'a':0}
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create(['%t%r'])
  let g:airline_section_x = airline#section#create(['%Y'])
  let g:airline_section_y = airline#section#create(['%m'])
  let g:airline_section_z = airline#section#create(['%03l:%03c[%p%%]'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" -------------------------------------------------

" git-gutter settings -----------------------------
"highlight clear SignColumn
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=233
highlight GitGutterAdd ctermfg=green ctermbg=233
highlight GitGutterChange ctermfg=yellow ctermbg=233
highlight GitGutterDelete ctermfg=red ctermbg=233
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=233
let g:gitgutter_sign_column_always=1
set updatetime=250
" -------------------------------------------------

" nerdcommenter -----------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" -------------------------------------------------

" YouCompleteMe -----------------------------------
" autoclose preview window
let g:ycm_autoclose_preview_window_after_completion=1
" goto declaration shortcut
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" -------------------------------------------------

" add colorcolumn at 80 chars for python PEP8 ----
set cc=80
hi ColorColumn ctermbg=233
" ------------------------------------------------


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit
