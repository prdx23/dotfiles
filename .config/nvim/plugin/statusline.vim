let g:currentmode={
    \ 'n'   : 'N',
    \ 'v'   : 'V',
    \ 'V'   : 'V Line',
    \ ''  : 'V Block',
    \ 'i'   : 'I',
    \ 'R'   : 'R',
    \ 'Rv'  : 'V Replace',
    \ 'c'   : 'Command',
    \ 's'   : 'Select',
    \ 'S'   : 'S Line',
    \ ''  : 'S Block',
    \ 'no'  : 'N·Operator Pending',
    \ 'nov' : 'N·Operator Pending',
    \ 'noV' : 'N·Operator Pending',
    \ 'no': 'N·Operator Pending',
    \ 'ic'  : 'I Completion',
    \ 'ix'  : 'I Completion',
    \ 'cv'  : 'Vim Ex',
    \ 'ce'  : 'Ex',
    \ 'r'   : 'Prompt',
    \ 'rm'  : 'More',
    \ 'r?'  : 'Confirm',
    \ '!'   : 'Shell',
    \ 't'   : 'Terminal'
\}

function FileSize()
    let l:size = getfsize(expand('%'))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size.'b'
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0).'kb'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) . 'mb'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'gb'
    endif
endfunction

function StatusModeColor()
    if (mode() =~# '[vV]')
        return '%#StatusLineVisual#'
    elseif (mode() =~# 'n.*')
        return '%#StatusLineNormal#'
    elseif (mode() =~# 'i.*')
        return '%#StatusLineInsert#'
    elseif (mode() =~# 'R.*')
        return '%#StatusLineReplace#'
    else
        return '%#StatusLineDefault#'
    endif
endfunction


lua << EOF
    function hl(name)
        if not name then return '%*' end
        return '%#StatusLine' .. name .. '#'
    end

    function gen_diagnostics_status()
        local diagnostics = vim.diagnostic.get(0)
        if vim.tbl_isempty(diagnostics) then return '' end

        local severities = {
            [ vim.diagnostic.severity.ERROR ] = { 0, hl('MidRed')    .. '  ' },
            [ vim.diagnostic.severity.WARN  ] = { 0, hl('MidOrange') .. '  ' },
            [ vim.diagnostic.severity.INFO  ] = { 0, hl('MidBlue')   .. '  ' },
            [ vim.diagnostic.severity.HINT  ] = { 0, hl('MidPurple') .. '  ' },
        }

        for _, v in ipairs(diagnostics) do
            severities[v.severity][1] = severities[v.severity][1] + 1
        end

        local section = ''
        for k, v in ipairs(severities) do
            if v[1] > 0 then
                section = section .. v[2] .. v[1] .. hl()
            end
        end
        section = section .. hl('Mid') .. ' ' .. hl()
        return section
    end

    function gen_gitsigns_status()
        local gitsigns = vim.b.gitsigns_status_dict
        if not gitsigns then return '' end

        if gitsigns.added and gitsigns.changed and gitsigns.removed then
            if gitsigns.added + gitsigns.changed + gitsigns.removed == 0 then
                return hl('Mid') .. '  ' .. gitsigns.head .. ' ' ..  hl()
            end
        end

        local section = ''
        local values = {
            { gitsigns.added,   hl('MidGreen')  .. ' +' },
            { gitsigns.changed, hl('MidOrange') .. ' ~' },
            { gitsigns.removed, hl('MidRed')    .. ' -' },
        }
        for _, v in ipairs(values) do
            if v[1] and v[1] > 0 then
                section = section .. v[2] .. v[1] .. '%*'
            end
        end

        section = section .. hl('Mid') .. '  ' ..  gitsigns.head .. ' ' .. hl()
        return section
    end

    local valid_buffer = function(bufnr)
        return vim.api.nvim_buf_get_option(bufnr, "buflisted") and vim.api.nvim_buf_get_name(bufnr) ~= ""
    end

    devicons = require('nvim-web-devicons')

    function gen_bufferlist()
        local section = ''

        -- local name
        -- for _, b in ipairs(vim.api.nvim_list_bufs()) do
        --     if valid_buffer(b) then
        --         name = vim.api.nvim_buf_get_name(bufnr)

        --         local current = b == vim.fn.bufnr()
        --         local modified = vim.api.nvim_buf_get_option(b, 'modified')

        --         if modified and current then
        --             section = section .. hl('TabModifiedCurrent')
        --         elseif modified and not current then
        --             section = section .. hl('TabModifiedHidden')
        --         elseif not modified and current then
        --             section = section .. hl('TabCurrent')
        --         else
        --             section = section .. hl('TabHidden')
        --         end

        --         if b == 1 then
        --             section = section .. ' ' .. name .. ' ' .. hl()
        --         else
        --             section = section .. '⎸' .. name .. ' ' .. hl()
        --         end

        --     end
        -- end

        local buffers = {}
        for b = 1, vim.fn.bufnr '$' do
            -- if vim.fn.buflisted(b) ~= 0 and vim.api.nvim_buf_get_option(b, 'buftype') ~= 'quickfix' then
            -- if vim.api.nvim_buf_get_option(b, 'buftype') ~= 'quickfix' then
                buffers[#buffers + 1] = b
            -- end
        end

        local test = ''
        for _, b in ipairs(buffers) do

            if not vim.api.nvim_buf_is_valid(b) or not vim.api.nvim_buf_is_loaded(b) then
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
                icon, _ = devicons.get_icon 'zsh'
            elseif vim.fn.isdirectory(file) == 1 then
                name = vim.fn.fnamemodify(file, ':p:.')
            elseif filetype == 'TelescopePrompt' then
                name = 'Telescope'
            elseif file == '' then
                goto continue
            else
                name = vim.fn.fnamemodify(file, ':t')
                icon, _ = devicons.get_icon(name, vim.fn.expand('#' .. b .. ':e'))
            end

            local current = b == vim.fn.bufnr()
            local modified = vim.api.nvim_buf_get_option(b, 'modified')

            if modified and current then
                section = section .. hl('TabModifiedCurrent')
            elseif modified and not current then
                section = section .. hl('TabModifiedHidden')
            elseif not modified and current then
                section = section .. hl('TabCurrent')
            else
                section = section .. hl('TabHidden')
            end

            if not icon then
                icon = ''
            else
                icon = icon .. ' '
            end

            if b == 1 then
                section = section .. ' ' .. icon .. name .. ' ' .. hl()
            else
                section = section .. '⎸' .. icon .. name .. ' ' .. hl()
            end

            ::continue::
        end

        section = section .. '⎸'
        return section
    end

    function combine()
        local diagnostics = gen_diagnostics_status()
        local gitsigns = gen_gitsigns_status()

        if diagnostics == '' and gitsigns == '' then
            return ''
        elseif diagnostics ~= '' and gitsigns == '' then
            return diagnostics
        elseif diagnostics == '' and gitsigns ~= '' then
            -- return hl('Mid') .. '⎸' .. hl() .. gitsigns
            return gitsigns
        else
            return diagnostics .. hl('Mid') .. '|' .. hl() .. gitsigns
        end
    end

EOF



function IsNotActiveWindow()
    return g:statusline_winid != win_getid(winnr())
endfunction


function IsHelpWindow()
    return getwinvar(g:statusline_winid, "&filetype") == 'help' || getwinvar(g:statusline_winid, "&filetype") == 'man'
endfunction


function IsModified()
    return getwinvar(g:statusline_winid, "&modified")
endfunction


function StatusLineGen() abort
    let l:line = ''

    if IsNotActiveWindow() && IsHelpWindow()
        let l:line .= '%#StatusLineNCLight#'
        let l:line .= ' %{&filetype} '
        let l:line .= '%*'

        let l:line .= '%#StatusLineNC#'
        let l:line .= ' %f '
        let l:line .= '%r%w'
        let l:line .= '%='
        let l:line .= '%#StatusLineNCLight#'
        let l:line .= ' %03l:%03c '
        let l:line .= '%*'
        return l:line
    endif

    if IsNotActiveWindow()
        let l:line .= '%#StatusLineNCLight#'
        let l:line .= ' %{g:currentmode[mode()]} '
        let l:line .= '%*'

        let l:line .= '%#StatusLineNC# %n:'
        let l:line .= ' %<%.24{expand("%:~:.:h")}/'
        let l:line .= IsModified() ? '%#StatusLineNCRedFlag#%t%m %*' : '%t '
        let l:line .= '%r%w'
        let l:line .= '%='
        let l:line .= luaeval("devicons.get_icon('', vim.fn.expand('#' .. vim.fn.bufnr() .. ':e'), { default = true })")
        let l:line .= ' %Y | %{FileSize()} '
        " let l:line .= '%#StatusLineNCMid#%*'
        let l:line .= '%#StatusLineNCLight#'
        let l:line .= ' %03l:%03c '
        let l:line .= '%*'
        return l:line
    endif

    if IsHelpWindow()
        let l:line .= '%#StatusLineNormal#'
        let l:line .= ' %{&filetype} '
        let l:line .= '%*'
        let l:line .= '%* %f %r%w'
        let l:line .= '%='
        let l:line .= ' %#StatusLineNormal#'
        let l:line .= ' %03l:%03c '
        return l:line
    endif

    let l:line .= StatusModeColor()
    let l:line .= ' %{g:currentmode[mode()]} '
    let l:line .= '%*'

    let l:line .= '%#StatusLineMid#'
    " let l:line .= luaeval('gen_gitsigns_status()')
    let l:line .= '%*'

    let l:line .= '%#StatusLineFlag# %n:%*'
    " let l:line .= ' %<%.24{fnamemodify(expand("%:.:h"), ":~:.")}/'
    let l:line .= ' %<%.24{expand("%:~:.:h")}/'
    let l:line .= '%#StatusLineHighlight#'
    let l:line .= IsModified() ? '%#StatusLineRedFlag#%t%m %*' : '%t '
    let l:line .= '%*'
    let l:line .= '%#StatusLineFlag#'
    let l:line .= '%r%w'
    let l:line .= &paste? '[PASTE]' : ''
    let l:line .= '%*'

    let l:line .= '%='

    let l:line .= luaeval("devicons.get_icon('', vim.fn.expand('#' .. vim.fn.bufnr() .. ':e')) or ''")
    let l:line .= ' %Y | %{FileSize()} '

    let l:line .= '%#StatusLineMid#'
    let l:line .= ''
    " let l:line .= luaeval('gen_diagnostics_status()')
    " let l:line .= luaeval("require('nvim-lightbulb').get_status_text")
    let l:line .= '%*'

    let l:line .= StatusModeColor()
    let l:line .= ' %03l:%03c '

    let l:line .= '%*'
    return l:line
endfunction

set statusline=%!StatusLineGen()

set showtabline=2


function TabLineGen() abort
    let l:line = ''

    lua gen_bufferlist()
    let l:line .= luaeval('gen_bufferlist()')

    let l:line .= '%= '

    let l:line .= luaeval('combine()')
    " let l:line .= '%#StatusLineMid#'
    " let l:line .= '|'
    " let l:line .= '%*'
    " let l:line .= luaeval('gen_gitsigns_status()')

    return l:line
endfunction



set tabline=%!TabLineGen()
