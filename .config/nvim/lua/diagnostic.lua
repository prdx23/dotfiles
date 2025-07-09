
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

    -- virtual_lines = {
    --     severity = { min = vim.diagnostic.severity.ERROR },
    --     current_line = true,
    -- },

    signs = {
        severity = { min = vim.diagnostic.severity.HINT },
        -- priority = 10,

        --     ﱣ  ﱤ ┆·               諸  󰗀 
        --   󰝤          󰆢  󰨓  󰝣  󱓻    󰨕  󱓼  󰄮  󰡖  󰄱
        --                 
        --       󱈸  󰈅       󰔶  󰔷  
        --     󰙎  󰋽    󰋼  󰰄  󰰅  󰬐  󰰃 
        --     󰌵    󰛨  󰌶  󱠂  󱠃
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN]  = '',
            [vim.diagnostic.severity.INFO]  = '',
            [vim.diagnostic.severity.HINT]  = '',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
        },
    },

    float = {
        scope = 'line',
        header = false,
        source = 'if_many',
        prefix = '- ',
        focusable = false,
        border = 'single',
        -- severity = { min = vim.diagnostic.severity.HINT },
        -- close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    },

    update_in_insert = false,
    severity_sort = true,

})


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


-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--     -- vim.lsp.handlers.hover, { border = "rounded", }
--     vim.lsp.handlers.hover, { border = "single", silent = true, }
-- )


vim.api.nvim_create_autocmd('DiagnosticChanged', {
    callback = function(args)
        RefreshStatusLine()
    end,
})


