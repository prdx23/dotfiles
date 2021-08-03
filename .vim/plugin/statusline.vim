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

highlight StatusLine ctermfg=242 ctermbg=235
highlight StatusLineHighlight ctermfg=85 ctermbg=235
highlight StatusLineFlag ctermfg=216 ctermbg=235
highlight StatusLineRedFlag ctermfg=210 ctermbg=235
highlight StatusLineNC ctermfg=239 ctermbg=235
highlight StatusLineNCMid ctermfg=241 ctermbg=236
highlight StatusLineNCLight ctermfg=233 ctermbg=237
highlight StatusLineDefault ctermfg=210 ctermbg=233
highlight StatusLineNormal ctermfg=16 ctermbg=76
highlight StatusLineInsert ctermfg=17 ctermbg=45
highlight StatusLineVisual ctermfg=232 ctermbg=214
highlight StatusLineReplace ctermfg=96 ctermbg=116
highlight StatusLineMid ctermfg=255 ctermbg=238

function StatusLineGen(mode)
    let l:line = ''

    if a:mode ==# 'active'
        if &filetype ==# 'help' || &filetype ==# 'man'
            let l:line.= '%#StatusLineNormal#'
            " let l:line.= ' %{toupper(&filetype)} '
            let l:line.= ' %{&filetype} '
            let l:line.= '%* %f %r%w'
            let l:line .= '%='
            let l:line.=' %#StatusLineNormal#'
            let l:line .= ' %03l:%03c[%p%%] '
            return l:line
        endif

        let l:line .= StatusModeColor()
        let l:line .= ' %{g:currentmode[mode()]} '
        let l:line .= '%*'

        let l:line .= '%#StatusLineMid#'
        " let l:line .= ' %{FugitiveStatusline()} '
        " let l:line .= ' %{FugitiveHead()} '
        let l:line .= '%*'

        let l:line .= '%#StatusLineFlag# %n:%*'
        let l:line .= ' %<%.24{expand("%:.:h")}/'
        let l:line .= '%#StatusLineHighlight#'
        let l:line .= &modified ? '%#StatusLineRedFlag#%t%m %*' : '%t '
        let l:line .= '%*'
        let l:line .= '%#StatusLineFlag#'
        let l:line .= '%r%h%w'
        let l:line .= &paste? '[PASTE]' : ''
        let l:line .= '%*'

        let l:line .= '%='

        let l:line .= ' %Y | %{FileSize()} '

        let l:line .= '%#StatusLineMid#'
        let l:line .= ''
        let l:line .= '%*'

        let l:line .= StatusModeColor()
        let l:line .= ' %03l:%03c '
    else
        let l:line .= '%#StatusLineNC#'
        let l:line .= ' %f '
        let l:line .= &modified ? '%m' : ''
        let l:line .= '%r%h%w'
        let l:line .= '%='
        let l:line .= ' %Y | %{FileSize()} '
        let l:line .= '%#StatusLineNCMid# %*'
        let l:line .= '%#StatusLineNCLight#'
        let l:line .= ' %03l:%03c '
    endif

    let l:line .= '%*'
    return l:line
endfunction

set statusline=%!StatusLineGen('active')
augroup CustomStatusLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setl statusline=%!StatusLineGen('active')
    autocmd VimLeave,WinLeave,BufWinLeave * setl statusline=%!StatusLineGen('inactive')
augroup END
" -------------------------------------------------
