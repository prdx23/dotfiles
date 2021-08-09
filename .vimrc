" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" ---------- Vundle settings --------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" General
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'suy/vim-context-commentstring'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dense-analysis/ale'
Plugin 'ap/vim-buftabline'

" Themes and colorschemes
" Plugin 'flazz/vim-colorschemes'
" Plugin 'notpratheek/vim-luna'

" Plugin 'Rigellute/rigel'
" Plugin 'ghifarit53/tokyonight-vim'
" Plugin 'sainnhe/sonokai'
" Plugin 'cocopon/inspecthi.vim'

" Plugin 'ajh17/spacegray.vim'
" Plugin 'joshdick/onedark.vim'
" Plugin 'mhartington/oceanic-next'


" Python
Plugin 'tmhedberg/SimpylFold'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-python/python-syntax'

" web/Javascript
Plugin 'othree/html5.vim'
Plugin 'ap/vim-css-color'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'posva/vim-vue'

" Lisp/Scheme
" Plugin 'kien/rainbow_parentheses.vim'

" other
" Plugin 'kylef/apiblueprint.vim'
Plugin 'chr4/nginx.vim'

call vundle#end()
filetype plugin indent on
" -----------------------------------------------------------------------------


"  Reminder: statusline code in .vim/plugin/statusline.vim


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
set backup		       " keep a backup file (restore to previous version)
set undofile		   " keep an undo file (undo changes after closing)
set backupcopy=yes     " for webpack watch to work properly
set backupdir^=$HOME/.vim/backup//
set directory^=$HOME/.vim/swap//
set undodir^=$HOME/.vim/undo//

" allow backspacing in insert mode
set backspace=indent,eol,start

" timeouts
set timeoutlen=500
set ttimeoutlen=20

" search settings
set incsearch
set ignorecase
set smartcase
set shortmess-=S

set scrolloff=4        " 4 lines buffer for scroll
set hidden             " allow buffers to be open in background
set noshowmode         " hide default status line
set nonu               " hide linenumber column
set encoding=utf8
set wildmenu
set showcmd
set signcolumn=yes     " enable sign col to be always enabled
set updatetime=250
" set cpoptions+=$       " add $ at end of c command
" set clipboard=unnamed

" space/tab settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

packadd matchit        " Add optional packages.

" insert mode completion options
set completeopt=menuone,noinsert,noselect

" highlight trailing whitespace
set list listchars=trail:·,nbsp:·,tab:\ \ 

" auto source .vimrc on saving this file
" autocmd! bufwritepost .vimrc source %

" autoreload buffers if they are changed outside of vim
set autoread
augroup autoreload
    autocmd!
    autocmd CursorHold,CursorHoldI * :checktime
    autocmd FocusGained,BufEnter * :checktime
augroup END


" markdown fenced code syntax highlighting
let g:markdown_fenced_languages = [
    \'html', 
    \'python', 
    \'bash=sh', 
    \'css', 
    \'javascript', 
    \'js=javascript', 
    \'json=javascript', 
    \'cpp'
    \]
" ------------------------------------------------


" Colorscheme ------------------------------------
" set term=screen-256color " Enable 256 color schemes
" set t_Co=256
set termguicolors

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme turtle
" highlight normal ctermbg=none guibg=NONE
" highlight NonText ctermbg=none guibg=NONE
" highlight todo ctermbg=233 ctermfg=208
" ------------------------------------------------

" add colorcolumn at 80 chars for python PEP8 ----
setlocal textwidth=80
set cc=80
" hi ColorColumn ctermbg=233
" ------------------------------------------------

" Show syntax color highlighting groups for word under cursor
nmap <c-b> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction


" buftabline settings ----------------------------
let g:buftabline_show=1
let g:buftabline_numbers=0
let g:buftabline_separators=1

highlight BufTabLineCurrent guifg=#56ffff ctermfg=87 guibg=#121213 ctermbg=232
highlight BufTabLineActive guifg=#7eb2dd ctermfg=149 guibg=#2c2e34 ctermbg=236
highlight BufTabLineHidden guifg=#7f8490 ctermfg=102 guibg=#2c2e34 ctermbg=236
highlight link BufTabLineFill StatusLine

highlight BufTabLineModifiedCurrent guifg=#fc5d7c ctermfg=204 guibg=#121213 ctermbg=232
highlight link BufTabLineModifiedActive BufTabLineModifiedCurrent
highlight link BufTabLineModifiedHidden BufTabLineModifiedCurrent

" function! GitStatus()
"     let [a,m,r] = GitGutterGetHunkSummary()
"     return printf('+%d ~%d -%d', a, m, r)
" endfunction

" function TabLineGen()
"     let l:tabline = ''
"     let l:tabline .= '%{buftabline#render()}'
"     let l:tabline .= '%='
"     let l:tabline .= ' %{GitStatus()} '
"     " let l:line .= ' %{FugitiveStatusline()} '
"     let l:tabline .= ' %{FugitiveHead()} '
"     return l:tabline
" endfunction
" set tabline=%!TabLineGen()
" ------------------------------------------------


" Python related settings ------------------------

" disable folding when opening files, but keep it enabled for manual use
set nofoldenable
autocmd FileType python setlocal foldenable foldlevel=20

let g:python_highlight_builtins=1
let g:python_highlight_builtin_funcs_kwarg=1
let g:python_highlight_exceptions=1
let g:python_highlight_string_formatting=1
let g:python_highlight_string_format=1
let g:python_highlight_string_templates=1
let g:python_highlight_func_calls=1
let g:python_highlight_class_vars=1
let g:python_highlight_operators=1
" let g:python_highlight_all = 1
" ------------------------------------------------


" vue synatax ------------------------------------
let g:vue_pre_processors = ['pug', 'scss']
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

" dont display errors on statusline
let g:airline#extensions#ale#enabled = 0

" disable certain warnings in python
let g:ale_python_flake8_options='--ignore=E731,E402'

" ------------------------------------------------


" git-gutter settings -----------------------------
let g:gitgutter_override_sign_column_highlight = 0
set signcolumn=yes
let g:gitgutter_set_sign_backgrounds = 1
" let g:gitgutter_sign_added = '++'
" let g:gitgutter_sign_modified = '~~'
" let g:gitgutter_sign_removed = '--'
" " let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_removed_above_and_below = '{'
" let g:gitgutter_sign_modified_removed = '~-'
"
" highlight clear SignColumn
" highlight SignColumn ctermbg=233
" highlight GitGutterAdd ctermfg=green ctermbg=233
" highlight GitGutterChange ctermfg=yellow ctermbg=233
" highlight GitGutterDelete ctermfg=red ctermbg=233
" highlight GitGutterChangeDelete ctermfg=yellow ctermbg=233

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

" dont show docstrings on hover
let g:ycm_auto_hover=''

" autoclose preview window
let g:ycm_autoclose_preview_window_after_completion=1
" -------------------------------------------------

" Keymappings ------------------------------------

" map spacebar to leader
" let mapleader = "\<space>"
map <space> <leader>

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
nnoremap <leader><space> :w<cr>

" map enter to cmd mode
nnoremap <cr> :
vnoremap <cr> :

" comment mappings using Commentary
nmap <leader>c <Plug>Commentary
nmap <leader>c<space> <Plug>CommentaryLine
xmap <leader>c<space> <Plug>Commentary
nmap ? <Plug>CommentaryLine
xmap ? <Plug>Commentary

" map leader+hh to temporarly turn of highlighting until next search
nnoremap <leader>hh :noh<cr>

" map leader+= to reindent the entire file from top to bottom
nnoremap <leader>= gg=G

" goto declaration shortcut
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ------------------------------------------------
