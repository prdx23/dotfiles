call plug#begin(stdpath('data').'/plugged')

" dependencies
" Plug 'lewis6991/impatient.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }


Plug 'RRethy/vim-hexokinase'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'


" Treesitter plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'


" Lsp plugins
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
" Plug 'glepnir/lspsaga.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'simrat39/rust-tools.nvim'
Plug 'Vimjas/vim-python-pep8-indent'


" snippets engine + community snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/cmp-vsnip'


" autocompletion sources
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'f3fora/cmp-spell'
Plug 'lukas-reineke/cmp-rg'
Plug 'ray-x/cmp-treesitter'
Plug 'lukas-reineke/cmp-under-comparator'

" autocomplete plugin
Plug 'hrsh7th/nvim-cmp'


" colorscheme
" Plug 'prdx23/asteroid.vim'
Plug '~/Code/projects/asteroid.vim'


" syntax plugins for non-treesitter langs
Plug 'chr4/nginx.vim'
Plug 'glench/vim-jinja2-syntax'
Plug 'tikhomirov/vim-glsl'


" util stuff
Plug 'tweekmonster/startuptime.vim'
Plug 'nvim-treesitter/playground'
Plug 'rktjmp/lush.nvim'
Plug 'rktjmp/shipwright.nvim'

call plug#end()
" lua require('impatient').enable_profile()
