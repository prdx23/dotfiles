

vim.g.term_win_id = nil


local function toggle_terminal()

    -- open terminal at a fixed height in a bottom window
    -- focus window directly if already open

    if vim.g.term_win_id and vim.api.nvim_win_is_valid(vim.g.term_win_id) then
        vim.api.nvim_set_current_win(vim.g.term_win_id)
        vim.cmd('startinsert')
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, { split = 'below', height = 12 })

    vim.cmd.term()
    vim.cmd('startinsert')
    vim.g.term_win_id = vim.api.nvim_get_current_win()

end


vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.bufhidden = "wipe"
        vim.opt_local.buflisted = false

        -- focus previous window
        vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:wincmd p<CR>", {
            buffer = true
        })

        -- close terminal window, which will also close the session
        vim.keymap.set("t", "<leader>w", "<C-\\><C-n>:wincmd c<CR>", {
            buffer = true
        })
    end,
})


vim.keymap.set("n", "<Leader>z", toggle_terminal, {
    noremap = true,
    silent = true
})
vim.api.nvim_create_user_command('Term', toggle_terminal, {})
