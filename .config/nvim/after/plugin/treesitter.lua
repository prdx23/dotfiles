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

}
vim.api.nvim_set_hl(0, "@type.qualifier.rust", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@storageclass.rust", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@storageclass.lifetime.rust", { link = "Special" })

vim.api.nvim_set_hl(0, "@type.qualifier.glsl", { link = "Keyword" })
-- vim.api.nvim_set_hl(0, "@type.builtin.glsl", { link = "@function.builtin" })

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.javascript.used_by = "vue"


require('ts_context_commentstring').setup {
    enable_autocmd = false,
}
-- skip backwards compatibility routines and speed up loading
vim.g.skip_ts_context_commentstring_module = true

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
