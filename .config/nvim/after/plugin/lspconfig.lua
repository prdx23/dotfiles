 -- pipx install 'python-lsp-server[all]'
 -- npm install -g typescript typescript-language-server

 -- npm install -g eslint_d

 -- npm install -g yarn
 -- yarn global add diagnostic-languageserver


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

vim.api.nvim_set_keymap('n', '<leader>d<space>', '', {
    noremap = true,
    callback = function()
        vim.diagnostic.open_float(nil)
    end
})

------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        -- rust
        "rust_analyzer",
        -- python
        "pylsp", -- 
        -- js + html/css/others
        "tsserver",
        "diagnosticls",
        -- C/C++
        "clangd",
    }
})


local nvim_lsp = require('lspconfig')

local custom_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    -- Mappings
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


require('rust-tools').setup({
    tools = {
        inlay_hints = {
            -- auto = false,
            only_current_line = true,
            highlight = "NonText",
        }
    },
    server = {
        on_attach = on_attach,
    }
})


local servers = { 'pylsp', 'tsserver' }
-- local servers = { 'pylsp' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = custom_attach,
        -- handlers = custom_handlers,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 100,
        }
    }
end

-- nvim_lsp.tsserver.setup{
--     on_attach = custom_attach
-- }

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    -- handlers = custom_handlers,
    capabilities = capabilities,
    filetypes = {
        'javascript', 'javascriptreact', 'vue',
        'json',
        'typescript', 'typescriptreact',
        'css', 'less', 'scss',
        'markdown', 'pandoc'
    },
    init_options = {
        linters = {
            eslint = {
                command = 'eslint_d',
                rootPatterns = { '.git' },
                debounce = 100,
                args = { 
                    '--stdin', '--stdin-filename', '%filepath', 
                    '--format', 'json' 
                },
                sourceName = 'eslint_d',
                parseJson = {
                    errorsRoot = '[0].messages',
                    line = 'line',
                    column = 'column',
                    endLine = 'endLine',
                    endColumn = 'endColumn',
                    -- message = '[eslint] ${message} [${ruleId}]',
                    message = '[${ruleId}] ${message}',
                    security = 'severity'
                },
                securities = {
                    ["2"] = 'error',
                    ["1"] = 'warning'
                }
            },
        },
        filetypes = {
            javascript = 'eslint',
            javascriptreact = 'eslint',
            vue = 'eslint',
            typescript = 'eslint',
            typescriptreact = 'eslint',
            -- markdown = 'markdownlint',
            -- pandoc = 'markdownlint'
        },
        formatters = {},
        formatFiletypes = {}
    }
}


