

return {

    -- {
    --     "prdx23/asteroid.vim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function ()
    --         vim.cmd.colorscheme("asteroid")
    --     end
    -- },
    {
        dir = "~/Code/projects/asteroid.vim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd.colorscheme("asteroid")
            vim.api.nvim_set_hl(0, "@type.qualifier.glsl", { link = "Keyword" })
            vim.api.nvim_set_hl(0, "@type.astro", { link = "Statement" })
            vim.api.nvim_set_hl(0, "@lsp.type.type.astro", { link = "Statement" })
        end
    },


    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require('nvim-web-devicons').setup({
                override = {
                    -- TEMP until font update
                    rs = {
                        icon = "",
                        color = "#dea584",
                        cterm_color = "216",
                        name = "Rs"
                    }
                }
            })
            vim.g.has_devicons = true
        end
    },


    {
        'chr4/nginx.vim',
        ft = { 'nginx' }
    },

    -- {
    --     'glench/vim-jinja2-syntax',
    --     ft = { 'htmljinja', 'jinja', 'jinja.html' }
    -- },

    -- {
    --     'RRethy/vim-hexokinase',
    --     build = 'make hexokinase',
    --     event = 'VeryLazy',
    -- },

    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    rgb_fn = true,
                    hsl_fn = true,
                    css = true,
                    css_fn = true,
                    mode = 'virtualtext',
                    tailwind = 'lsp',
                },
            })
        end
    },

    {
        'rktjmp/lush.nvim',
        cmd = { 'Lushify', 'LushRunTutorial' },
    },

    {
        'rktjmp/shipwright.nvim',
        cmd = { 'Shipwright' },
    },

    {
        "m4xshen/hardtime.nvim",
        cmd = { 'Hardtime' },
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require('hardtime').setup({
                enabled = false,
                max_count = 6,
                disable_mouse = false,
                restricted_keys = {
                    -- enter is reassigned
                    ["<CR>"] = {},
                },
                disabled_keys = {
                    -- arrow keys are already noop
                    ["<Up>"] = {},
                    ["<Down>"] = {},
                    ["<Left>"] = {},
                    ["<Right>"] = {},
                },
            })
        end,
    },
}
