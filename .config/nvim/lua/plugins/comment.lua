

return {

    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            ignore = '^$',
            toggler = {
                line = '<leader>c<leader>',
                block = '<leader>b<leader>',
            },
            opleader = {
                line = '<leader>c',
                block = '<leader>b',
            },

        })
        -- vim.keymap.set('n', '<space>c<space>', 'gcc', { remap = true })
        -- vim.keymap.set('n', '<space>bc', 'gbc', { remap = true })
        -- vim.keymap.set('x', '<space>c<space>', 'gcc', { remap = true })
        -- vim.keymap.set('x', '<space>bc', 'gbc', { remap = true })
    end

}
