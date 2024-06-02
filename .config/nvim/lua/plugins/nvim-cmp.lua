

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
            entries = { name = 'custom',  selection_order = 'near_cursor' },
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

                if entry.source.name == 'treesitter' and string.sub(formatted.kind, 1, 1) == ' ' then
                    formatted.kind = '󱁉' .. formatted.kind
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


    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer', keyword_length = 2 }
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = ''
                return vim_item
            end
        },
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline', keyword_length = 2 }
        }),
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = ''
                return vim_item
            end
        },
        matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- require("luasnip/loaders/from_vscode").lazy_load()


    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch',  { link = 'Variable' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy',  { link = 'Comment' })
    vim.api.nvim_set_hl(0, 'CmpItemKind',  { link = 'DullRed' })
    vim.api.nvim_set_hl(0, 'CmpItemMenu',  { link = 'DullYellow' })


    vim.api.nvim_set_hl(0, 'CmpItemKindText',  { link = '@string' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod',  { link = '@function.method' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction',  { link = '@function' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstructor',  { link = '@constructor' })
    vim.api.nvim_set_hl(0, 'CmpItemKindField',  { link = '@variable.member' })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable',  { link = '@variable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindClass',  { link = '@type' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface',  { link = '@lsp.type.interface' })
    vim.api.nvim_set_hl(0, 'CmpItemKindModule',  { link = '@module' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty',  { link = '@property' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit',  { link = '@special' })
    vim.api.nvim_set_hl(0, 'CmpItemKindValue',  { link = '@special' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnum',  { link = '@type' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword',  { link = '@keyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstant',  { link = '@constant' })
    vim.api.nvim_set_hl(0, 'CmpItemKindStruct',  { link = '@type' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEvent',  { link = '@special' })
    vim.api.nvim_set_hl(0, 'CmpItemKindOperator',  { link = '@operator' })

end


return {

    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
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
