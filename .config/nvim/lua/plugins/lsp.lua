

vim.diagnostic.config({
    underline = {
        severity = { min = vim.diagnostic.severity.INFO }
    },
    virtual_text = false,
    -- virtual_text = {
    --     -- format = function()
    --     spacing = 4,
    --     prefix = 'ﱣ ',
    --     severity = { min = vim.diagnostic.severity.WARN }
    -- },
    signs = {
        severity = { min = vim.diagnostic.severity.HINT }
        -- priority = 10,
    },
    float = {
        -- severity = { min = vim.diagnostic.severity.HINT },
        header = false,
        source = 'always',
        prefix = '- ',
        focusable = false,
        -- border = 'rounded',
        border = 'single',
        scope = 'line',
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    },
    update_in_insert = false,
    severity_sort = true,
})

--     ﱣ  ﱤ ┆·               諸 
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn',  {text = '', texthl = 'DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignInfo',  {text = '', texthl = 'DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignHint',  {text = '', texthl = 'DiagnosticSignHint'})


-- vim.api.nvim_create_autocmd('CursorHold', {
--     buffer = bufnr,
--     callback = function()
--         vim.diagnostic.open_float(nil)
--     end
-- })

vim.keymap.set('n', '<leader>d', '', {
    noremap = true,
    callback = function()
        vim.diagnostic.open_float(nil)
    end
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    -- vim.lsp.handlers.hover, { border = "rounded", }
    vim.lsp.handlers.hover, { border = "single", silent = true, }
)


vim.api.nvim_create_autocmd('DiagnosticChanged', {
    callback = function(args)
        RefreshStatusLine()
    end,
})


------------------------------------------

local function lspconfig()

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
            -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            -- vim.keymap.set('n', '<space>wl', function()
            --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, opts)
            vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>ln', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
            -- vim.keymap.set('n', '<space>f', function()
            --     vim.lsp.buf.format { async = true }
            -- end, opts)
        end,
    })


    local servers = {

        -- rust_analyzer = {}, -- overridden by 'mrcjkb/rustaceanvim'
        -- remove from ensure_installed below if enabled here
        -- remove override from handler if enabled here

        -- tsserver = {}, -- overridden by 'pmizio/typescript-tools.nvim',
        -- remove from ensure_installed below if enabled here

        pylsp = {},

        eslint = {},

        gopls = {},

        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                }
            }

        },

        clangd = {},

        svelte = {},

        tailwindcss = {},

        -- unocss = {},

        jinja_lsp = {},
    }


    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
        'force', capabilities, require('cmp_nvim_lsp').default_capabilities()
    )

    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(vim.tbl_deep_extend(
            'force', servers, {
                tsserver = {},
                rust_analyzer = {},
            }
        )),
        handlers = {
            function(server_name)

                -- NOTE!! - disable mason auto-config
                -- cause overridden by 'mrcjkb/rustaceanvim'
                if server_name == 'rust_analyzer' then
                    return
                end

                -- NOTE!! - disable mason auto-config
                -- cause overridden by 'pmizio/typescript-tools.nvim',
                if server_name == 'tsserver' then
                    return
                end

                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend(
                    'force', {}, capabilities, server.capabilities or {}
                )
                -- server.flags = { debounce_text_changes = 100 }
                require('lspconfig')[server_name].setup(server)
            end,
        },
    })

    -- NOTE - comment this out to use toolchain rust-analyzer
    -- vim.g.rustaceanvim = {
    --     server = {
    --         cmd = function()
    --             local mason_registry = require('mason-registry')
    --             local ra_binary = mason_registry.is_installed('rust-analyzer') 
    --             and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
    --             or "rust-analyzer"
    --             return { ra_binary }
    --         end,
    --     },
    -- }

end


return {

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = lspconfig,
    },


    -- {
    --     'simrat39/rust-tools.nvim',
    --     ft = { 'rust' },
    --     dependencies = { 'neovim/nvim-lspconfig' },
    --     config = function()
    --         require('rust-tools').setup({
    --             tools = {
    --                 inlay_hints = {
    --                     -- auto = false,
    --                     only_current_line = true,
    --                     highlight = "NonText",
    --                 }
    --             },
    --         })
    --     end
    -- },

    -- {
    --     'vxpm/ferris.nvim',
    --     ft = { 'rust' },
    --     dependencies = { 'neovim/nvim-lspconfig' }
    -- },

    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        ft = { 'rust' },
        dependencies = { 'neovim/nvim-lspconfig' }
    },

    {
        "pmizio/typescript-tools.nvim",
        ft = {
            'javascript', 'javascriptreact', 'javascript.jsx',
            'typescript', 'typescriptreact', 'typescript.tsx',
            'vue', 'astro', 'svelte',
        },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },

    -- {
    --     'kosayoda/nvim-lightbulb',
    --     config = function()
    --         require("nvim-lightbulb").setup({
    --             autocmd = { enabled = true }
    --         })
    --     end
    -- },

}
