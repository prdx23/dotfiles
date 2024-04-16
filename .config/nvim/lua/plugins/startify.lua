


return {

    {
        'mhinz/vim-startify',
        cmd = { 'Startify' },
        config = function()

            vim.g.startify_bookmarks = {
                { t = '~/todo.md'},
                { p = '~/Code/projects'},
                { d = '~/Code/design'},
                { w = '~/Code/work'},
                { b = '~/Documents/vault/braindump'},
                { c = '~/Documents/vault/Braindump/Random/vim notes.md'},
            }

            vim.g.startify_lists = {
                { type = 'bookmarks', header = {'   Bookmarks'} },
                { type = 'dir',       header = {
                    ' ',
                    '   Recent: ' .. vim.fn.escape(vim.fn.fnamemodify(vim.fn.getcwd(), ':~'), '\\'),
                }}
            }

            vim.g.startify_files_number = 4
            vim.g.startify_custom_indices = vim.fn.map(vim.fn.range(1,100), 'string(v:val)')

            vim.g.startify_update_oldfiles = 1
            vim.g.startify_change_to_dir = 1
            vim.g.startify_enable_special = 0
            vim.g.startify_fortune_use_unicode = 1

            vim.g.startify_skiplist = {
                'dist/*',
                'venv/*',
            }

            -- vim.g.startify_custom_header = 'startify#pad(startify#fortune#boxed() + [" "])'
            vim.g.startify_custom_header = ''
            vim.g.startify_custom_footer = 'startify#pad([" ", "[e] Empty Buffer    [q] Quit"])'

            vim.api.nvim_set_hl(0, 'StartifyFooter', { link = 'Comment' })
            -- vim.api.nvim_exec2([[
            --     highlight link StartifyFooter Comment
            -- ]], { output = false })

            -- vim.api.nvim_exec2([[
            --     autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
            -- ]], { output = false })

        end,
    },

}
