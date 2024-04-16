

local function treesitter_config()

    require('nvim-treesitter.configs').setup({
        -- TEMP -> narrow down to needed parsers later
        ensure_installed = "all",
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            -- disable = { 'toml' },
            -- disable = { 'html', 'vue', 'css', 'scss' },
            -- custom_captures = {
            --     ["css.class"] = "Error",
            --     ["css.tag"] = "Error", ["css.id"] = "Error",
            -- },
            additional_vim_regex_highlighting = false,
            disable = function(lang, buf)
                local max_filesize = 200 * 1024 -- 200 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },

    })

    vim.api.nvim_set_hl(0, "@type.qualifier.rust", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@storageclass.rust", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@storageclass.lifetime.rust", { link = "Special" })

    vim.api.nvim_set_hl(0, "@type.qualifier.glsl", { link = "Keyword" })
    -- vim.api.nvim_set_hl(0, "@type.builtin.glsl", { link = "@function.builtin" })

    -- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    -- parser_config.javascript.used_by = "vue"


    -- add shader filetypes
    vim.filetype.add({
        extension = {
            vert = 'glsl',
            frag = 'glsl',
            comp = 'glsl',
            geom = 'glsl',
        },
    })
    vim.treesitter.language.register('glsl', 'vert')
    vim.treesitter.language.register('glsl', 'frag')
    vim.treesitter.language.register('glsl', 'comp')
    vim.treesitter.language.register('glsl', 'geom')

    -- require'nvim-treesitter.configs'.setup({
    --     textobjects = {
    --         select = {
    --             enable = true,
    --             lookahead = true,
    --             keymaps = {
    --                 -- You can use the capture groups defined in textobjects.scm
    --                 ["af"] = "@function.outer",
    --                 ["if"] = "@function.inner",
    --                 ["ac"] = "@class.outer",
    --                 ["ic"] = "@class.inner",
    --                 ["al"] = "@loop.outer",
    --                 ["il"] = "@loop.inner",
    --                 ["al"] = "@loop.outer",
    --                 ["il"] = "@loop.inner",
    --                 ["ap"] = "@parameter.outer",
    --                 ["ip"] = "@parameter.inner",
    --             },
    --             -- You can choose the select mode (default is charwise 'v')
    --             selection_modes = {
    --                 ['@parameter.outer'] = 'v', -- charwise
    --                 ['@function.outer'] = 'V', -- linewise
    --                 ['@class.outer'] = '<c-v>', -- blockwise
    --             },
    --             -- If you set this to `true` (default is `false`) then any textobject is
    --             -- extended to include preceding or succeeding whitespace. Succeeding
    --             -- whitespace has priority in order to act similarly to eg the built-in
    --             -- `ap`. Can also be a function (see above).
    --             include_surrounding_whitespace = true,
    --         },
    --     },
    -- })
end



return {

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = treesitter_config,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
            -- skip backwards compatibility routines and speed up loading
            vim.g.skip_ts_context_commentstring_module = true
        end
    },

    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },

    {
        'nvim-treesitter/playground',
        cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
    },

}
