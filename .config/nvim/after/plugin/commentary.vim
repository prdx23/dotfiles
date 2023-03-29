" nmap <leader>c <Plug>Commentary
" nmap <leader>c<space> <Plug>CommentaryLine
" xmap <leader>c<space> <Plug>Commentary
" nmap ? <Plug>CommentaryLine
" xmap ? <Plug>Commentary

lua << EOF
local map = vim.api.nvim_set_keymap
map('n', '<space>c', [[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]], { expr = true })
map('n', '<space>c<space>', [[v:lua.context_commentstring.update_commentstring_and_run('CommentaryLine')]], { expr = true })
map('x', '<space>c<space>', [[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]], { expr = true })
map('n', '?', [[v:lua.context_commentstring.update_commentstring_and_run('CommentaryLine')]], { expr = true })
map('x', '?', [[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]], { expr = true })
EOF
