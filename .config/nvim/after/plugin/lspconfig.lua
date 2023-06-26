
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
        border = 'rounded',
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

------------------------------------------

local servers = {
    "rust_analyzer",
    "pylsp",
    "tsserver",
    "eslint",
    "lua_ls",
    "clangd",
    "svelte",
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers
})



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 100,
        }
    }
end

require('rust-tools').setup({
    tools = {
        inlay_hints = {
            -- auto = false,
            only_current_line = true,
            highlight = "NonText",
        }
    },
})


nvim_lsp.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        }
    }
}


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded", }
)


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
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<space>f', function()
        --     vim.lsp.buf.format { async = true }
        -- end, opts)
    end,
})

-- nvim_lsp.tsserver.setup{
--     on_attach = custom_attach
-- }

-- nvim_lsp.diagnosticls.setup {
--     on_attach = on_attach,
--     -- handlers = custom_handlers,
--     capabilities = capabilities,
--     filetypes = {
--         'javascript', 'javascriptreact', 'vue',
--         'json',
--         'typescript', 'typescriptreact',
--         'css', 'less', 'scss',
--         'markdown', 'pandoc'
--     },
--     init_options = {
--         linters = {
--             eslint = {
--                 command = 'eslint_d',
--                 rootPatterns = { '.git' },
--                 debounce = 100,
--                 args = { 
--                     '--stdin', '--stdin-filename', '%filepath', 
--                     '--format', 'json' 
--                 },
--                 sourceName = 'eslint_d',
--                 parseJson = {
--                     errorsRoot = '[0].messages',
--                     line = 'line',
--                     column = 'column',
--                     endLine = 'endLine',
--                     endColumn = 'endColumn',
--                     -- message = '[eslint] ${message} [${ruleId}]',
--                     message = '[${ruleId}] ${message}',
--                     security = 'severity'
--                 },
--                 securities = {
--                     ["2"] = 'error',
--                     ["1"] = 'warning'
--                 }
--             },
--         },
--         filetypes = {
--             javascript = 'eslint',
--             javascriptreact = 'eslint',
--             vue = 'eslint',
--             typescript = 'eslint',
--             typescriptreact = 'eslint',
--             -- markdown = 'markdownlint',
--             -- pandoc = 'markdownlint'
--         },
--         formatters = {},
--         formatFiletypes = {}
--     }
-- }


