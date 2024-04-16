
return {

    'lewis6991/gitsigns.nvim',

    config = function()

        require('gitsigns').setup {
            signs = {
                add          = {text = '┃'},
                change       = {text = '┃'},
                -- delete       = {text = '_'},
                -- topdelete    = {text = '‾'},
                -- changedelete = {text = '~'},
            },
        }

        vim.api.nvim_create_autocmd('User', {
            pattern = 'GitSignsUpdate',
            callback = function()
                RefreshStatusLine()
            end
        })


        vim.api.nvim_create_user_command(
            'GitBlame',
            'Gitsigns toggle_current_line_blame',
            {}
        )

        vim.api.nvim_create_user_command(
            'GitReset',
            ':Gitsigns reset_hunk',
            {}
        )

        vim.api.nvim_create_user_command(
            'GitResetBuffer',
            ':Gitsigns reset_buffer',
            {}
        )

        -- vim.cmd [[ nnoremap <leader>gg <cmd>Gitsigns reset_hunk<cr> ]]
        -- vim.cmd [[ nnoremap <leader>gr <cmd>Gitsigns reset_buffer<cr> ]]
        -- vim.cmd [[ nnoremap <leader>gb <cmd>Gitsigns toggle_current_line_blame<cr> ]]

        vim.g.has_gitsigns = true

    end

}
