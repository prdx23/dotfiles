
require("telescope").setup({
    defaults = {
        layout_strategy = 'flex',
        layout_config = {},

        -- winblend = 5,

        preview = {
            timeout = 1000,
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
vim.keymap.set('n', '<leader>o', builtin.git_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>e', builtin.diagnostics, {})
-- vim.keymap.set('n', '<leader>b', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>a', builtin.lsp_code_actions, {})

