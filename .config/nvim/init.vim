" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" disallow nvim to change terminal cursor, set before everything else
set guicursor=


runtime plug.vim


filetype plugin indent on

set showcmd
set nowrap
set noshowmatch
let g:loaded_matchparen=1
set nofoldenable
set scrolloff=4
set signcolumn=yes
set colorcolumn=80
" set lazyredraw


set timeoutlen=500
set ttimeoutlen=20
set updatetime=50


set mouse=a
set backspace=indent,eol,start
autocmd InsertLeave * set nopaste


set completeopt=menuone,noinsert,noselect
set list listchars=trail:·,nbsp:·,tab:\ \
set inccommand=nosplit


" backup
set backup
set undofile
set backupcopy=yes
set hidden
let &backupdir=stdpath('data').'/backup//'
let &directory=stdpath('data').'/swap//'
let &undodir=stdpath('data').'/undo//'


" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set shortmess-=S


" space/tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent


" spell
set spelllang=en
set spellsuggest+=10


" wildmenu
set wildmenu
set wildignorecase
set wildignore+=*/node_modules/*
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv


" popup menu
set pumheight=10
set pumwidth=15
set pumblend=0


" colorscheme
syntax on
set termguicolors
colorscheme asteroid


" statusline
set noshowmode
set laststatus=2


autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse=0



" markdown fenced code syntax highlighting
" let g:markdown_fenced_languages = [
"     \'vim', 
"     \'html', 
"     \'python', 
"     \'py=python', 
"     \'sh', 
"     \'shell=sh', 
"     \'bash=sh', 
"     \'css', 
"     \'javascript', 
"     \'js=javascript', 
"     \'json=javascript', 
"     \'cpp'
"     \]


runtime keys.vim
