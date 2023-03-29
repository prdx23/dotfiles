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

" map leader+hh to temporarly turn of highlighting until next search
nnoremap <leader>hh :noh<cr>

" map leader+= to reindent the entire file from top to bottom
nnoremap <leader>= gg=G

" map number increment/decrement to alt-= and alt--
nnoremap <A-=> <C-a>
nnoremap <A--> <C-x>

" goto declaration shortcut
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
