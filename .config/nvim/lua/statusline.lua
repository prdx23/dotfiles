

local function get_mode()

    local modes = {
        ['n']    = { text = 'N', color = 'N' },
        ['v']    = { text = 'V', color = 'V' },
        ['V']    = { text = 'V Line', color = 'V' },
        ['']   = { text = 'V Block', color = 'V' },
        ['i']    = { text = 'I', color = 'I' },
        ['R']    = { text = 'R', color = 'R' },
        ['Rv']   = { text = 'V Replace', color = 'R' },
        ['c']    = { text = 'Command', color = 'D' },
        ['s']    = { text = 'Select', color = 'D' },
        ['S']    = { text = 'S Line', color = 'D' },
        ['']   = { text = 'S Block', color = 'D' },
        ['no']   = { text = 'N·Operator Pending', color = 'N' },
        ['nov']  = { text = 'N·Operator Pending', color = 'N' },
        ['noV']  = { text = 'N·Operator Pending', color = 'N' },
        ['no'] = { text = 'N·Operator Pending', color = 'N' },
        ['ic']   = { text = 'I Completion', color = 'I' },
        ['ix']   = { text = 'I Completion', color = 'I' },
        ['cv']   = { text = 'Vim Ex', color = 'D' },
        ['ce']   = { text = 'Ex', color = 'D' },
        ['r']    = { text = 'Prompt', color = 'D' },
        ['rm']   = { text = 'More', color = 'D' },
        ['r?']   = { text = 'Confirm', color = 'D' },
        ['!']    = { text = 'Shell', color = 'D' },
        ['t']    = { text = 'Terminal', color = 'D' },

        ['niI']  = { text = 'N', color = 'N' },
        ['niR']  = { text = 'N', color = 'N' },
        ['niV']  = { text = 'N', color = 'N' },
        ['nt']   = { text = 'N', color = 'N' },
        ['vs']   = { text = 'V', color = 'V' },
        ['Vs']   = { text = 'V Line', color = 'V' },
        ['\22s'] = { text = 'V Block', color = 'V' },
        ['Rc']   = { text = 'R', color = 'R' },
        ['Rx']   = { text = 'R', color = 'R' },
        ['Rvc']  = { text = 'V Replace', color = 'R' },
        ['Rvx']  = { text = 'V Replace', color = 'R' },
    }

    local colors = {
        ['N'] = '%#StatusLineNormal#',
        ['I'] = '%#StatusLineInsert#',
        ['V'] = '%#StatusLineVisual#',
        ['R'] = '%#StatusLineReplace#',
        ['D'] = '%#StatusLineDefault#',
    }

    local current_mode = vim.api.nvim_get_mode().mode
    return {
        text  = modes[current_mode].text,
        color = colors[modes[current_mode].color],
    }
end



local function get_filesize()
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))

    if size == 0 or size == -1 then
        return '-b'
    elseif size == -2 then
        return '^b'
    elseif size < 1024 then
        return size .. 'b'
    elseif size < 1024 * 1024 then
        return string.format('%.1fkb', size / 1024)
    elseif size < 1024 * 1024 * 1024 then
        return string.format('%.1fmb', size / 1024 / 1024)
    elseif size < 1024 * 1024 * 1024 * 1024 then
        return string.format('%.1fgb', size / 1024 / 1024 / 1024)
    end

    return size .. 'b'
end



local function get_win_details()
    local current_id = vim.g.statusline_winid
    local current_type = vim.fn.getwinvar(current_id, '&filetype')
    return {
        is_not_active = current_id ~= vim.fn.win_getid(vim.fn.winnr()),
        is_help = current_type == 'help' or current_type == 'man',
        is_modified = vim.fn.getwinvar(current_id, '&modified') ~= 0
    }
end



local function get_icon()
    if not vim.g.has_devicons then
        return ''
    end
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
    local ext  = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':e')
    return require('nvim-web-devicons').get_icon(name, ext, { default = true })
end



local function get_gitstatus()
    if not vim.g.has_gitsigns then
        return ''
    end

    local gitsigns = vim.b.gitsigns_status_dict
    if not gitsigns then
        return ''
    end

    if gitsigns.added and gitsigns.changed and gitsigns.removed then
        if gitsigns.added + gitsigns.changed + gitsigns.removed == 0 then
            return table.concat({ '%#StatusLineMid#  ', gitsigns.head, ' %*' })
        end
    end

    local section = ''
    local values = {
        { gitsigns.added,   '%#StatusLineMidGreen# +' },
        { gitsigns.changed, '%#StatusLineMidOrange# ~' },
        { gitsigns.removed, '%#StatusLineMidRed# -' },
    }
    for _, v in ipairs(values) do
        if v[1] and v[1] > 0 then
            section = section .. v[2] .. v[1] .. '%*'
        end
    end

    return table.concat({ section, '%#StatusLineMid#  ', gitsigns.head, ' %*' })
end


local function get_diagnostics()

    local diagnostics = vim.diagnostic.get(0)
    if vim.tbl_isempty(diagnostics) then return '' end

    local severities = {
        [ vim.diagnostic.severity.ERROR ] = { 0, '%#StatusLineMidRed#  ' },
        [ vim.diagnostic.severity.WARN  ] = { 0, '%#StatusLineMidOrange#  ' },
        [ vim.diagnostic.severity.INFO  ] = { 0, '%#StatusLineMidBlue#  ' },
        [ vim.diagnostic.severity.HINT  ] = { 0, '%#StatusLineMidPurple#  ' },
    }

    for _, v in ipairs(diagnostics) do
        severities[v.severity][1] = severities[v.severity][1] + 1
    end

    local section = ''
    for k, v in ipairs(severities) do
        if v[1] > 0 then
            section = section .. v[2] .. v[1] .. '%*'
        end
    end

    return section .. '%#StatusLineMid# %*'
end


local function get_bufferlist()

    local function get_icon(_, _, _)
        return ''
    end
    if vim.g.has_devicons then
        get_icon = require('nvim-web-devicons').get_icon
    end

    local sections = {}
    for b = 1, vim.fn.bufnr('$') do

        if not vim.api.nvim_buf_is_valid(b) then
            goto continue
        end

        if not vim.api.nvim_buf_is_loaded(b) then
            goto continue
        end


        local buftype = vim.api.nvim_buf_get_option(b, 'buftype')
        local filetype = vim.api.nvim_buf_get_option(b, 'filetype')
        local file = vim.fn.bufname(b)
        local name = ''
        local icon = ''

        if buftype == 'help' then
            name = 'help: ' .. vim.fn.fnamemodify(file, ':t:r')
        elseif buftype == 'terminal' then
            local match = string.match(vim.split(file, ' ')[1], 'term:.*:(%a+)')
            name = match ~= nil and match or vim.fn.fnamemodify(vim.env.SHELL, ':t')
            icon, _ = get_icon('zsh')
        elseif vim.fn.isdirectory(file) == 1 then
            name = vim.fn.fnamemodify(file, ':p:.')
        elseif filetype == 'TelescopePrompt' then
            name = 'Telescope'
        elseif file == '' then
            goto continue
        else
            name = vim.fn.fnamemodify(file, ':t')
            icon, _ = get_icon(name, vim.fn.fnamemodify(file, ':e'))
        end

        if not icon or icon == '' then
            icon = ''
        else
            icon = icon .. ' '
        end

        table.insert(sections, {
            i = b,
            name = name,
            icon = icon,
            current = b == vim.fn.bufnr(),
            modified = vim.api.nvim_buf_get_option(b, 'modified'),
        })

        ::continue::
    end

    local output = {}
    for _, section in ipairs(sections) do
        if section.modified and section.current then
            table.insert(output, '%#StatusLineTabModifiedCurrent#')
        elseif section.modified and not section.current then
            table.insert(output, '%#StatusLineTabModifiedHidden#')
        elseif not section.modified and section.current then
            table.insert(output, '%#StatusLineTabCurrent#')
        else
            table.insert(output, '%#StatusLineTabHidden#')
        end

        if section.i == 1 then
            table.insert(output, ' ')
        else
            table.insert(output, '⎸')
        end
        table.insert(output, section.icon)
        if vim.g.tabline_show_bufnums then
            table.insert(output, section.i)
            table.insert(output, ':')
        end
        table.insert(output, section.name)
        table.insert(output, ' %*')
    end

    table.insert(output, '⎸')
    return table.concat(output)
end


function Statusline()

    local mode = get_mode()
    local filesize = get_filesize()
    local win = get_win_details()
    local icon = get_icon()

    local modified_flag = '%t '
    local modified_flag_nonactive = '%t '
    if win.is_modified then
        modified_flag = '%#StatusLineRedFlag#%t%m %*'
        modified_flag_nonactive = '%#StatusLineNCRedFlag#%t%m %*'
    end

    if win.is_not_active and win.is_help then
        return table.concat({
            '%#StatusLineNCLight#',
            ' %{&filetype} ',
            '%*',

            '%#StatusLineNC#',
            ' %f ',
            '%r%w',
            '%=',
            '%#StatusLineNCLight#',
            ' %03l:%03c ',
            '%*',
        })
    elseif win.is_not_active then
        return table.concat({
            '%#StatusLineNCLight#',
            ' ', mode.text, ' ',
            '%*',

            '%#StatusLineNC# %n:',
            ' %<%.24{expand("%:~:.:h")}/',
            modified_flag_nonactive,
            '%r%w',
            '%=',
            icon,
            ' %Y | ', filesize, ' ',
            -- '%#StatusLineNCMid#%*',
            '%#StatusLineNCLight#',
            ' %03l:%03c ',
            '%*',
        })
    elseif win.is_help then
        return table.concat({
            '%#StatusLineNormal#',
            ' %{&filetype} ',
            '%*',
            '%* %f %r%w',
            '%=',
            ' %#StatusLineNormal#',
            ' %03l:%03c ',
        })
    end


    return table.concat({
        mode.color,
        ' ', mode.text, ' ',
        '%*',

        -- '%#StatusLineMid#',
        -- get_gitstatus(),
        -- '%*',

        '%#StatusLineFlag# %n:%*',
        -- ' %<%.24{fnamemodify(expand("%:.:h"), ":~:.")}/',
        ' %<%.24{expand("%:~:.:h")}/',
        '%#StatusLineHighlight#',
        modified_flag,
        '%*',
        '%#StatusLineFlag#',
        '%r%w',
        -- &paste? '[PASTE]' : '',
        '%*',


        '%=',

        icon,
        ' %Y | ', filesize, ' ',

        -- '%#StatusLineMid#',
        -- get_diagnostics(),
        -- '%*',

        mode.color,
        ' %03l:%03c ',
        '%*',

    })
end



vim.g.tabline_show_bufnums = false
vim.api.nvim_create_user_command('TablineToggleBufferNums', function()
    vim.g.tabline_show_bufnums = not vim.g.tabline_show_bufnums
end, {})


function Tabline()

    local diagnostics = get_diagnostics()
    local gitstatus = get_gitstatus()

    if diagnostics ~= '' and gitstatus ~= '' then
        gitstatus = '%#StatusLineMid#⎸%*' .. gitstatus
    end

    return table.concat({
        get_bufferlist(),
        '%=',
        diagnostics,
        gitstatus,
    })
end


vim.opt.showtabline = 2
function RefreshStatusLine()
    vim.api.nvim_exec2([[
        set statusline=%!v:lua.Statusline()
        set tabline=%!v:lua.Tabline()
    ]], { output = false })
end
RefreshStatusLine()
