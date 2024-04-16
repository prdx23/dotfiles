
return {

    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function ()

        require("telescope").setup({
            defaults = {
                layout_strategy = 'flex',
                layout_config = {},

                -- winblend = 5,

                preview = {
                    timeout = 500,
                    msg_bg_fillchar = '·'
                }
            },
            pickers = {
                lsp_code_actions = {
                    layout_strategy = 'cursor',
                    layout_config = {
                        height = 10,
                        width = 0.5,
                    }
                }

            },
            extensions = {

            }
        })


        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>-', builtin.find_files, {})
        vim.keymap.set('n', '<leader>o', function()
            local ok, _ = pcall(builtin.git_files)
            if not ok then
                vim.notify('Warn: not a git repo', vim.log.levels.WARN)
                builtin.find_files()
            end
        end , {})
        vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>e', builtin.diagnostics, {})
        -- vim.keymap.set('n', '<leader>b', builtin.buffers, {})
        -- vim.keymap.set('n', '<leader>a', builtin.lsp_code_actions, {})

        vim.keymap.set('n', '<leader>ta', builtin.builtin, {})
        vim.keymap.set('n', '<leader>ts', builtin.spell_suggest, {})
        vim.keymap.set('n', '<leader>tt', builtin.treesitter, {})
    end

}
