
return {

    {
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

        end,

    },


    {
        'jinh0/eyeliner.nvim',
        event = 'VeryLazy',
        config = function()
            require('eyeliner').setup({
                highlight_on_key = true,
                dim = true
            })
            vim.api.nvim_set_hl(0, 'EyelinerPrimary',    { link = 'Statement' })
            vim.api.nvim_set_hl(0, 'EyelinerSecondary',  { link = 'Operator' })
        end,
    }

}

