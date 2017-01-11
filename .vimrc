" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" Vundle settings ---------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'notpratheek/vim-luna'
Plugin 'python-mode/python-mode'
call vundle#end()            " required
filetype plugin indent on    " required
" -----------------------------------------------

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
set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
"set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set noshowmode
set nonu
set clipboard=unnamed
" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" ------------------------------------------------


" Colorscheme ------------------------------------
" Enable 256 color schemes
set term=screen-256color
set t_Co=256
colorscheme luna-term
let g:airline_theme='customtheme'
" ------------------------------------------------

" Keymappings ------------------------------------
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
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
"nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
"nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <CR> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <C-CR> :set paste<CR>m`O<Esc>``:set nopaste<CR>
" ------------------------------------------------

" vim-airline statusline--------------------------
set laststatus=2
let g:airline_powerline_fonts = 1
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
highlight clear SignColumn
highlight SignColumn ctermbg=233
highlight GitGutterAdd ctermfg=green ctermbg=233
highlight GitGutterChange ctermfg=yellow ctermbg=233
highlight GitGutterDelete ctermfg=red ctermbg=233
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=233
let g:gitgutter_sign_column_always=1
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
