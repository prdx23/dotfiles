" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" disallow nvim to change terminal cursor, set before everything else
set guicursor=


" runtime plug.vim

lua << EOF

-- has to be set before plugins load
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup('plugins', {
    change_detection = {
        enabled = false,
        notify = false,
    },
})


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})


-- vim.api.nvim_create_autocmd('BufWritePre', {
--     desc = 'remove whitespace from end of lines',
--     group = vim.api.nvim_create_augroup('eol-whitespace-remove', { clear = true }),
--     command = [[%s/\s\+$//e]],
-- })

EOF


lua require('statusline')


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
" colorscheme asteroid


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
