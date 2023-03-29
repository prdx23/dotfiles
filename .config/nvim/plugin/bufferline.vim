
" set showtabline

" function StatusLineGen() abort
"     let l:line = ''

"     lua gen_gitsigns_status()

"     if IsNotActiveWindow() && IsHelpWindow()
"         let l:line .= '%#StatusLineNCLight#'
"         let l:line .= ' %{&filetype} '
"         let l:line .= '%*'

"         let l:line .= '%#StatusLineNC#'
"         let l:line .= ' %f '
"         let l:line .= '%r%w'
"         let l:line .= '%='
"         let l:line .= '%#StatusLineNCLight#'
"         let l:line .= ' %03l:%03c '
"         let l:line .= '%*'
"         return l:line
"     endif

"     if IsNotActiveWindow()
"         let l:line .= '%#StatusLineNCLight#'
"         let l:line .= ' %{g:currentmode[mode()]} '
"         let l:line .= '%*'

"         let l:line .= '%#StatusLineNC# %n:'
"         let l:line .= ' %<%.24{expand("%:~:.:h")}/'
"         let l:line .= IsModified() ? '%#StatusLineNCRedFlag#%t%m %*' : '%t '
"         let l:line .= '%r%w'
"         let l:line .= '%='
"         let l:line .= ' %Y | %{FileSize()} '
"         " let l:line .= '%#StatusLineNCMid#%*'
"         let l:line .= '%#StatusLineNCLight#'
"         let l:line .= ' %03l:%03c '
"         let l:line .= '%*'
"         return l:line
"     endif

"     if IsHelpWindow()
"         let l:line .= '%#StatusLineNormal#'
"         let l:line .= ' %{&filetype} '
"         let l:line .= '%*'
"         let l:line .= '%* %f %r%w'
"         let l:line .= '%='
"         let l:line .= ' %#StatusLineNormal#'
"         let l:line .= ' %03l:%03c '
"         return l:line
"     endif

"     let l:line .= StatusModeColor()
"     let l:line .= ' %{g:currentmode[mode()]} '
"     let l:line .= '%*'

"     let l:line .= '%#StatusLineMid#'
"     " let l:line .= "%{get(b:,'gitsigns_status','')}"
"     let l:line .= luaeval('gen_gitsigns_status()')
"     " let l:line .= ' %{FugitiveStatusline()} '
"     " let l:line .= ' %{FugitiveHead()} '
"     " let l:line .= ' %{GitStatus()} '
"     " let l:line .= DiagnosticsCount() ? ' %{diagnosticsCount()} ' : ''
"     let l:line .= '%*'

"     " let l:line .= '%#StatusLineFlag# %n:%*'
"     " let l:line .= ' %<%.24{fnamemodify(expand("%:.:h"), ":~:.")}/'
"     let l:line .= ' %<%.24{expand("%:~:.:h")}/'
"     let l:line .= '%#StatusLineHighlight#'
"     let l:line .= IsModified() ? '%#StatusLineRedFlag#%t%m %*' : '%t '
"     let l:line .= '%*'
"     let l:line .= '%#StatusLineFlag#'
"     let l:line .= '%r%w'
"     let l:line .= &paste? '[PASTE]' : ''
"     let l:line .= '%*'

"     let l:line .= '%='

"     let l:line .= ' %Y | %{FileSize()} '

"     let l:line .= '%#StatusLineMid#'
"     let l:line .= ''
"     let l:line .= luaeval('gen_diagnostics_status()')
"     " let l:line .= luaeval("require('nvim-lightbulb').get_status_text")
"     let l:line .= '%*'

"     let l:line .= StatusModeColor()
"     let l:line .= ' %03l:%03c '

"     let l:line .= '%*'
"     return l:line
" endfunction




" set statusline=%!StatusLineGen()
