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
Plugin 'tmhedberg/SimpylFold'
Plugin 'tweekmonster/braceless.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'python-mode/python-mode'

" Javascript related
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Lisp/Scheme related
" Plugin 'kien/rainbow_parentheses.vim'

" vue syntax
Plugin 'posva/vim-vue'

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
set noshowmode         " hide default status line
set nonu               " hide linenumber column
set encoding=utf8
set showcmd
" set cpoptions+=$       " add $ at end of c command
" set clipboard=unnamed
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
filetype plugin on     " update for nerdcommenter plugin
packadd matchit        " Add optional packages.
" ------------------------------------------------

" Python related settings ------------------------

" braceless settings
autocmd FileType python BracelessEnable +indent

" let python_highlight_all = 1
" set tab to 4 
" au BufNewFile,BufRead *.py
"     \ set tabstop=4 |
"     \ set softtabstop=4 |
"     \ set shiftwidth=4 |
"     \ set expandtab |
"     \ set textwidth=79 |
"     \ set autoindent |
"     \ set fileformat=unix
"
" set expandtab
" highlight extra whitespaces
" highlight ExtraWhitespace ctermbg=darkgreen
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match ExtraWhitespace /\s\+$/
" au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertLeave * match ExtraWhitespace /\s\+$/

" vue synatax
let g:vue_disable_pre_processors=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
" let g:syntastic_python_checkers = ['pep8', 'flake8']
" let g:syntastic_python_checkers = ['pep8']
let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_quiet_messages = {'regex': '(E731|E402)'}
let g:syntastic_python_flake8_post_args='--ignore=E731,E402'
" ------------------------------------------------

" Colorscheme ------------------------------------
set term=screen-256color " Enable 256 color schemes
set t_Co=256
colorscheme luna-term
highlight normal ctermbg=none
highlight NonText ctermbg=none
" ------------------------------------------------

" vim-airline statusline--------------------------
set laststatus=2
let g:airline_theme='customtheme'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 0
set timeoutlen=1000 ttimeoutlen=0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#default#section_truncate_width = {'y':0,'a':0}
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create(['%f%r%h%'])
  let g:airline_section_x = airline#section#create(['%Y B:%n'])
  let g:airline_section_y = airline#section#create(['%m'])
  let g:airline_section_z = airline#section#create(['%03l:%03c[%p%%]'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" -------------------------------------------------

" git-gutter settings -----------------------------
"highlight clear SignColumn
let g:gitgutter_override_sign_column_highlight = 0
" highlight SignColumn ctermbg=none
" highlight GitGutterAdd ctermfg=green ctermbg=none
" highlight GitGutterChange ctermfg=yellow ctermbg=none
" highlight GitGutterDelete ctermfg=red ctermbg=none
" highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none
highlight SignColumn ctermbg=233
highlight GitGutterAdd ctermfg=green ctermbg=233
highlight GitGutterChange ctermfg=yellow ctermbg=233
highlight GitGutterDelete ctermfg=red ctermbg=233
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=233
" let g:gitgutter_sign_column_always=1
set signcolumn=yes
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


" Keymappings ------------------------------------
" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" tab and shift-tab to do multiple indents for visual groups
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" tab and shift-tab to do multiple indents for single line
nnoremap <tab> >>
nnoremap <s-tab> <<

" save current file by double spacebar
nnoremap <space><space> :w<cr>

" map enter to cmd mode
nnoremap <cr> :
vnoremap <cr> :

" map spacebar to leader
map <space> <leader>

" map leader+hh to temporarly turn of highlighting until next search
nnoremap <leader>hh :noh<cr>

" use ? to toggle comments in single line and visual groups
nnoremap <silent> ? :call NERDComment(0,"toggle")<CR>
vnoremap <silent> ? :call NERDComment(0,"toggle")<CR>gv

" map ;; to find <++>, remove it and start insert mod
" inoremap <leader>f<space> <Esc>/<++><Enter>"_c4l
nnoremap <leader>f<space> <Esc>/<++><Enter>"_c4l
nnoremap ;; <Esc>/<++><Enter>"_c4l
inoremap ;; <Esc>/<++><Enter>"_c4l

" map ;p to print()
autocmd FileType python inoremap ;p print()<Enter><++><Esc>k0f(a
autocmd FileType python nnoremap ;p iprint()<Enter><++><Esc>k0f(a

" map ;d to def
autocmd FileType python inoremap ;d def (<++>):<Enter><++><Esc>k0f(i
autocmd FileType python nnoremap ;d idef (<++>):<Enter><++><Esc>k0f(i

" map ;c to class
autocmd FileType python inoremap ;c class (<++>):<Enter><Enter>def __init__(<++>):<Enter><++><Esc>kkk0f(i
autocmd FileType python nnoremap ;c iclass (<++>):<Enter><Enter>def __init__(<++>):<Enter><++><Esc>kkk0f(i

" map ;d to <div>
autocmd FileType html inoremap ;d <div class=''><Enter><++><Enter></div><Esc>kk0f'a
autocmd FileType html nnoremap ;d i<div class=''><Enter><++><Enter></div><Esc>kk0f'a

" map ;p to <p>
autocmd FileType html inoremap ;p <p class=''><Enter><++><Enter></p><Esc>kk0f'a
autocmd FileType html nnoremap ;p i<p class=''><Enter><++><Enter></p><Esc>kk0f'a

" map ;f to function
autocmd FileType javascript inoremap ;f function (<++>) {<Enter><++><Enter>}<Esc>kkof(i
autocmd FileType javascript nnoremap ;f ifunction (<++>) {<Enter><++><Enter>}<Esc>kkof(i
" ------------------------------------------------
