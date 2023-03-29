require'nvim-treesitter.configs'.setup {
    -- TEMP -> narrow down to needed parsers later
    ensure_installed = "all",
    sync_install = false,
    highlight = {
        enable = true,
        -- disable = { 'toml' },
        -- disable = { 'html', 'vue', 'css', 'scss' },
        -- custom_captures = {
        --     ["css.class"] = "Error",
        --     ["css.tag"] = "Error",
        --     ["css.id"] = "Error",
        -- },
        additional_vim_regex_highlighting = false,
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false
    }
}
vim.api.nvim_set_hl(0, "@type.qualifier.rust", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@storageclass.rust", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@storageclass.lifetime.rust", { link = "Special" })

vim.api.nvim_set_hl(0, "@type.qualifier.glsl", { link = "Keyword" })
-- vim.api.nvim_set_hl(0, "@type.builtin.glsl", { link = "@function.builtin" })

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.javascript.used_by = "vue"
