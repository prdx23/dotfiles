" statusline--------------------------
set laststatus=2

let g:currentmode={
    \ 'n'   : 'N',
    \ 'v'   : 'V',
    \ 'V'   : 'V Line',
    \ ''  : 'V·Block',
    \ 'i'   : 'I',
    \ 'R'   : 'R',
    \ 'Rv'  : 'V·Replace',
    \ 'c'   : 'Command',
    \ 's'   : 'Select',
    \ 'S'   : 'S·Line',
    \ ''  : 'S·Block',
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

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

highlight StatusLine guifg=#4f5462 ctermfg=240 guibg=#1b1b1c ctermbg=234 gui=NONE cterm=NONE
highlight StatusLineNC guifg=#4f5462 ctermfg=240 guibg=#25262c ctermbg=235 gui=NONE cterm=NONE

highlight StatusLineHighlight guifg=#56ffff ctermfg=87 guibg=#1b1b1c ctermbg=234
highlight StatusLineFlag guifg=#f39660 ctermfg=209 guibg=#1b1b1c ctermbg=234
highlight StatusLineRedFlag guifg=#fc5d7c ctermfg=204 guibg=#1b1b1c ctermbg=234
highlight StatusLineNCRedFlag guifg=#fc5d7c ctermfg=204 guibg=#25262c ctermbg=234

highlight StatusLineNCMid guifg=#4f5462 ctermfg=240 guibg=#2c2e34 ctermfg=236
highlight StatusLineNCLight guifg=#33353f ctermfg=237 guibg=#4f5462 ctermfg=240
highlight StatusLineMid guifg=#7f8490 ctermfg=102 guibg=#2c2e34 ctermfg=236

" highlight StatusLineNormal  guifg=#181819 ctermfg=234 guibg=#93d072 ctermfg=149
highlight StatusLineNormal  guifg=#181819 ctermfg=234 guibg=#fc5d7c ctermfg=149
" highlight StatusLineNormal guifg=#181819 ctermfg=234 guibg=#7dc3bd ctermfg=149

highlight StatusLineInsert  guifg=#181819 ctermfg=234 guibg=#7eb2dd ctermfg=149
highlight StatusLineVisual  guifg=#181819 ctermfg=234 guibg=#f39660 ctermfg=149
highlight StatusLineReplace guifg=#181819 ctermfg=234 guibg=#9c8cc3 ctermfg=149
highlight StatusLineDefault guifg=#181819 ctermfg=234 guibg=#7dc3bd ctermfg=149


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
    " let l:line .= ' %{FugitiveStatusline()} '
    " let l:line .= ' %{FugitiveHead()} '
    " let l:line .= ' %{GitStatus()} '
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

    let l:line .= ' %Y | %{FileSize()} '

    let l:line .= '%#StatusLineMid#'
    let l:line .= ''
    let l:line .= '%*'

    let l:line .= StatusModeColor()
    let l:line .= ' %03l:%03c '

    let l:line .= '%*'
    return l:line
endfunction

set statusline=%!StatusLineGen()

" augroup CustomStatusLine
"     autocmd!
"     autocmd VimEnter,WinEnter,BufWinEnter * setl statusline=%!StatusLineGen('active')
"     autocmd VimLeave,WinLeave,BufWinLeave * setl statusline=%!StatusLineGen('inactive')
" augroup END
" -------------------------------------------------
