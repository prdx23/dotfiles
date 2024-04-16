
return {

    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()

        require('illuminate').configure({
            under_cursor = false,
        })

        vim.api.nvim_set_hl(0, 'IlluminatedWordText',  { link = 'TelescopeSelection' })
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead',  { link = 'TelescopeSelection' })
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'TelescopeSelection' })

        vim.keymap.set('n', '<A-n>', '', {
            noremap = true,
            callback = function()
                require('illuminate').goto_next_reference()
                vim.cmd.normal('zz')
            end
        })

        vim.keymap.set('n', '<A-p>', '', {
            noremap = true,
            callback = function()
                require('illuminate').goto_prev_reference()
                vim.cmd.normal('zz')
            end
        })

    end

}

