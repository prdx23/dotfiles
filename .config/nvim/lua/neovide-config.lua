


if vim.g.neovide then

    vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"

    -- emulate Alacritty font rendering
    vim.g.neovide_text_gamma = 0.8
    vim.g.neovide_text_contrast = 0.1

    vim.g.neovide_opacity = 0.9
    vim.g.neovide_normal_opacity = 0.9

    vim.g.neovide_detach_on_quit = 'always_quit'

    -- vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    -- vim.g.neovide_scroll_animation_far_lines = 0
    -- vim.g.neovide_scroll_animation_length = 0.00



    vim.o.guifont = "JetBrainsMono NFP:h10"

    local function adjust_guifont(delta)
        local guifont = vim.o.guifont
        if not guifont or guifont == "" then
            vim.notify("guifont is not set", vim.log.levels.WARN)
            return
        end

        -- Extract current size using pattern ":h%d+"
        local name, size = guifont:match("^(.-):h(%d+)")
        if not name or not size then
            vim.notify("guifont format is invalid (expected 'Name:hSize')", vim.log.levels.ERROR)
            return
        end

        local new_size = tonumber(size) + delta
        if new_size < 1 then new_size = 1 end

        vim.o.guifont = string.format("%s:h%d", name, new_size)
        vim.notify("GUI font set to: " .. vim.o.guifont)
    end

    vim.keymap.set("n", "<C-=>", function() adjust_guifont(1) end, {
        desc = "Increase GUI font size"
    })
    vim.keymap.set("n", "<C-->", function() adjust_guifont(-1) end, {
        desc = "Decrease GUI font size"
    })

end
