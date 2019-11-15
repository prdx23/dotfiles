"
"
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
" Plugin 'scrooloose/syntastic'
Plugin 'dense-analysis/ale'

" Themes and colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'notpratheek/vim-luna'

" Python related plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'tweekmonster/braceless.vim'
" Plugin 'nvie/vim-flake8'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'python-mode/python-mode'

" Javascript related
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'posva/vim-vue'

" Lisp/Scheme related
" Plugin 'kien/rainbow_parentheses.vim'

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
set history=200		   " keep 200 lines of command line history

set incsearch	   	   " do incremental searching
set ignorecase
set smartcase

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
" set expandtab
filetype plugin on     " update for nerdcommenter plugin
packadd matchit        " Add optional packages.

set completeopt=menuone,noinsert,noselect
set list listchars=trail:·,nbsp:·,tab:\ \ 

set signcolumn=yes     " enable sign col to be always enabled
set updatetime=250

set backupdir^=$HOME/.vim/backup//
set directory^=$HOME/.vim/swap//
set undodir^=$HOME/.vim/undo//

" auto source .vimrc on saving this file
" autocmd! bufwritepost .vimrc source %
" ------------------------------------------------

" Python related settings ------------------------

" braceless settings
autocmd FileType python BracelessEnable +indent

" ------------------------------------------------

" vue synatax
let g:vue_disable_pre_processors=1


" Colorscheme ------------------------------------
set term=screen-256color " Enable 256 color schemes
set t_Co=256
colorscheme luna-term
highlight normal ctermbg=none
highlight NonText ctermbg=none
highlight todo ctermbg=233 ctermfg=208
" ------------------------------------------------


" add colorcolumn at 80 chars for python PEP8 ----
setlocal textwidth=80
set cc=80
hi ColorColumn ctermbg=233
" ------------------------------------------------


" syntastic settings -----------------------------

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_flake8_post_args='--ignore=E731,E402'
" let g:airline#extensions#syntastic#enabled = 0

" ------------------------------------------------

" ALE settings -----------------------------------

" open loc list on finding error
" let g:ale_open_list = 1

" loc list length
let g:ale_list_window_size = 5

" dont run linters while typing text
" let g:ale_lint_on_text_changed = 'never'

" dont run linters when opening the file
" let g:ale_lint_on_enter = 0

" dont run linters when leaving insert mode
" let g:ale_lint_on_insert_leave = 0

" dont run linters on file save
" let g:ale_lint_on_save = 0

" error msg format
let g:ale_echo_msg_format = '[%severity%] %code%: %s'
highlight ALEError ctermbg=red ctermfg=black
highlight ALEErrorSign ctermbg=red ctermfg=black
" highlight ALEErrorLine ctermbg=238
highlight ALEWarning ctermbg=208 ctermfg=black
highlight ALEWarningSign ctermbg=208 ctermfg=black
" highlight ALEWarningLine ctermbg=238

" dont display errors on statusline
let g:airline#extensions#ale#enabled = 0

" disable certain warnings in python
let g:ale_python_flake8_options='--ignore=E731,E402'

" ------------------------------------------------

" vim-airline statusline--------------------------
set laststatus=2
let g:airline_theme='customtheme'
let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ' '
" let g:airline_left_alt_sep = '|'
" let g:airline_right_sep = ' '
" let g:airline_right_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set timeoutlen=1000 ttimeoutlen=0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#default#section_truncate_width = {'y':0,'a':0}
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create(['%f%r%h%w'])
  let g:airline_section_x = airline#section#create(['%Y | B:%n'])
  let g:airline_section_y = airline#section#create(['%m'])
  let g:airline_section_z = airline#section#create(['%03l:%03c[%p%%]'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" -------------------------------------------------

" git-gutter settings -----------------------------
let g:gitgutter_override_sign_column_highlight = 0
"highlight clear SignColumn
highlight SignColumn ctermbg=233
highlight GitGutterAdd ctermfg=green ctermbg=233
highlight GitGutterChange ctermfg=yellow ctermbg=233
highlight GitGutterDelete ctermfg=red ctermbg=233
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=233

" -------------------------------------------------

" nerdcommenter -----------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" -------------------------------------------------

" YouCompleteMe -----------------------------------

" settings for working with python virtual environments
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.config/ycm/global_extra_conf.py'

" autoclose preview window
let g:ycm_autoclose_preview_window_after_completion=1

" goto declaration shortcut
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" -------------------------------------------------

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
