
return {

    {
        'echasnovski/mini.nvim',
        config = function()

            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            require('mini.ai').setup({
                n_lines = 500,
                custom_textobjects = {
                    f = spec_treesitter({
                        a = '@function.outer', i = '@function.inner'
                    }),
                    k = spec_treesitter({
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    }),
                    c = spec_treesitter({
                        a = '@class.outer', i = '@class.inner'
                    }),
                    j = spec_treesitter({
                        a = '@parameter.outer', i = '@parameter.inner'
                    }),
                }
            })

            require('mini.surround').setup()

            -- require('mini.notify').setup()
        end,
    }

}
