

local function cmp_config()

    local cmp = require'cmp'
    local lspkind = require('lspkind')
    -- local luasnip = require('luasnip')


    cmp.setup({
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end,
        },
        view = {
            entries = "custom" -- can be "custom", "wildmenu" or "native"
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
        -- mapping = {
        --     -- ['<C-p>'] = cmp.mapping.select_prev_item(),
        --     -- ['<C-n>'] = cmp.mapping.select_next_item(),
        --     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --     -- ['<C-Space>'] = cmp.mapping.complete(),
        --     ['<C-e>'] = cmp.mapping.close(),
        --     -- ['<CR>'] = cmp.mapping.confirm {
        --     --     behavior = cmp.ConfirmBehavior.Replace,
        --     --     select = true,
        --     -- },
        --     -- ['<Tab>'] = function(fallback)
        --     --     if cmp.visible() then
        --     --         cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        --     --     elseif luasnip.expand_or_jumpable() then
        --     --         luasnip.expand_or_jump()
        --     --     else
        --     --         fallback()
        --     --     end
        --     -- end,
        --     -- ['<S-Tab>'] = function(fallback)
        --     --     if cmp.visible() then
        --     --         cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        --     --     elseif luasnip.jumpable(-1) then
        --     --         luasnip.jump(-1)
        --     --     else
        --     --         fallback()
        --     --     end
        --     -- end,
        -- },
        sources = cmp.config.sources({
            -- { name = 'nvim_lsp', max_item_count = 15 },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            -- { name = 'treesitter', max_item_count = 15, keyword_length = 2 },
            { name = 'treesitter', keyword_length = 2 },
            { name = 'calc' },
            { name = 'path', max_item_count = 10 },
            { name = 'buffer' },
            { name = 'rg', max_item_count = 20, keyword_length = 3 },
            -- { name = "buffer-lines", max_item_count = 5, keyword_length = 3 },
            { name = 'spell', max_item_count = 10 },
            -- { name = 'cmdline' },
            -- { name = 'luasnip', max_item_count = 5 },
            -- { name = 'vsnip' },
        }),
        window = {
            documentation = {
                border = 'single',
            },
        },
        formatting = {
            format = function(entry, vim_item)
                local formatted = lspkind.cmp_format({
                    -- with_text = true,
                    mode = "symbol_text",
                    -- maxwidth = 35,
                    menu = ({
                        nvim_lsp = "[lsp]",
                        nvim_lsp_signature_help = "[lsp]",
                        luasnip = "[snip]",
                        buffer = "[buf]",
                        -- ['buffer-lines'] = "[bufline]",
                        path = "[path]",
                        spell = "[spl]",
                        treesitter = "[ts]",
                        rg = "[rg]",
                        calc = "[calc]",
                    })
                })(entry, vim_item)

                if entry.source.name == 'calc' then
                    formatted.kind = '󰃬 Result'
                end

                return formatted
            end
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require "cmp-under-comparator".under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    })

    -- cmp.setup.cmdline('/', {
    --     sources = {
    --         { name = 'buffer' }
    --     }
    -- })

    -- cmp.setup.cmdline(':', {
    --     sources = cmp.config.sources({
    --         { name = 'path' }
    --     }, {
    --         { name = 'cmdline' }
    --     })
    -- })

    -- require("luasnip/loaders/from_vscode").lazy_load()


end


return {

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'lukas-reineke/cmp-rg',
            'ray-x/cmp-treesitter',
            'lukas-reineke/cmp-under-comparator',
            -- 'amarakon/nvim-cmp-buffer-lines',
        },
        config = cmp_config,
    },

}
