


return {

    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        "rcarriga/nvim-notify",
        -- keys = {
        --     {
        --         "<leader>un",
        --         function()
        --             require("notify").dismiss({ silent = true, pending = true })
        --         end,
        --         desc = "Dismiss All Notifications",
        --     },
        -- },
        event = 'VeryLazy',
        config = function()
            require('notify').setup({
                render = 'compact',
                stages = "static",
                -- timeout = 2000,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { zindex = 100 })
                end,
            })

            vim.notify = require("notify")
        end,
    },

    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    -- normal_hl = "NormalFloat",
                    border = "single",
                    align = 'top',
                    max_width = 60,
                    x_padding = 0,
                    y_padding = 0,
                },
            },
        },
    },

    -- {
    --     'goolord/alpha-nvim',
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons',
    --         'nvim-lua/plenary.nvim'
    --     },
    --     config = function ()
    --         require'alpha'.setup(require'alpha.themes.theta'.config)
    --     end
    -- },

}
