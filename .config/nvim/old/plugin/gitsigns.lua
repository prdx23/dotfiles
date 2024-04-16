require('gitsigns').setup {

    signs = {
        add          = {text = '┃'},
        change       = {text = '┃'},
        -- delete       = {text = '_'},
        -- topdelete    = {text = '‾'},
        -- changedelete = {text = '~'},
    },
    sign_priority = 6,
}

vim.cmd [[ command! GitBlame :Gitsigns toggle_current_line_blame ]]
vim.cmd [[ command! GitReset :Gitsigns reset_hunk ]]
vim.cmd [[ command! GitResetBuffer :Gitsigns reset_buffer ]]

vim.cmd [[ nnoremap <leader>gg <cmd>Gitsigns reset_hunk<cr> ]]
vim.cmd [[ nnoremap <leader>gr <cmd>Gitsigns reset_buffer<cr> ]]
vim.cmd [[ nnoremap <leader>gb <cmd>Gitsigns toggle_current_line_blame<cr> ]]
