
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

-- require('telescope').load_extension('fzf')

vim.cmd [[ nnoremap <leader>f <cmd>Telescope find_files<cr> ]]
vim.cmd [[ nnoremap <leader>s <cmd>Telescope live_grep<cr> ]]
vim.cmd [[ nnoremap <leader>b <cmd>Telescope buffers<cr> ]]
vim.cmd [[ nnoremap <leader>a <cmd>Telescope lsp_code_actions<cr> ]]
