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

" recenter screen after move up or down by half page
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" recenter screen on move forward or backward through search
nnoremap n nzz
nnoremap N Nzz

" paste with delete to void buffer
xnoremap <leader>p "_dP

" delete to void buffer
vnoremap <leader>d "_d

" copy to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" map leader+hh to temporarly turn of highlighting until next search
nnoremap <leader>hh :noh<cr>

" map leader+= to reindent the entire file from top to bottom
" nnoremap <leader>= gg=G

" map number increment/decrement to alt-= and alt--
nnoremap <A-=> <C-a>
nnoremap <A--> <C-x>

" open netrw
nnoremap <leader>= :Ex<cr>

" open vim notes file in obsidian
nnoremap <leader>fc :e ~/Documents/vault/Braindump/Random/vim notes.md<cr>

" open global todo file
nnoremap <leader>ft :e ~/todo.md<cr>

" next and prev buffer navigation
nnoremap <C-j> :bn<cr>
nnoremap <C-k> :bp<cr>

" ctrl-w to close buffer (will only work if no unsaved changes)
nnoremap <leader>w :bw<cr>
vnoremap <leader>w :bw<cr>

" next and prev quickfix navigation
" autocmd FileType qf nnoremap <leader>j :cn<cr>
" autocmd FileType qf nnoremap <leader>k :cp<cr>

" move highlighted block up and down
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '>-2<cr>gv=gv

" Show syntax color highlighting groups for word under cursor
nmap <c-b> :TSHighlightCapturesUnderCursor<CR>

" replace all mentions of the word under cursor in this buffer
nnoremap <leader>r :%s/\<<C-r>=expand('<cword>')<CR>\>/

" replace all mentions of the selection in this buffer
xnoremap <leader>r :<C-u>%s/<C-r>=GetVisualSelection()<CR>/
function! GetVisualSelection()
    let old_reg = @v
    normal! gv"vy
    let raw_search = @v
    let @v = old_reg
    return substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction
