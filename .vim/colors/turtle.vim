" ===============================================================
" turtle
" 
" URL: 
" Author: prdx23
" License: MIT
" Last Change: 2021/08/09 23:28
" ===============================================================

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="turtle"


let Italic = ""
if exists('g:turtle_italic')
  let Italic = "italic"
endif
let g:turtle_italic = get(g:, 'turtle_italic', 0)

let Bold = ""
if exists('g:turtle_bold')
  let Bold = "bold"
endif

let g:turtle_bold = get(g:, 'turtle_bold', 0)
hi ALEError guifg=#181819 ctermfg=234 guibg=#fc5d7c ctermbg=204 gui=NONE cterm=NONE
hi ALEWarning guifg=#181819 ctermfg=234 guibg=#f39660 ctermbg=209 gui=NONE cterm=NONE
hi ALEInfo guifg=#181819 ctermfg=234 guibg=#7eb2dd ctermbg=110 gui=NONE cterm=NONE
hi ALEErrorSign guifg=#fc5d7c ctermfg=204 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi ALEWarningSign guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi ALEInfoSign guifg=#7eb2dd ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Normal guifg=#e6e6dc ctermfg=254 guibg=#181819 ctermbg=234 gui=NONE cterm=NONE
hi ColorColumn guibg=#1b1b1c ctermbg=234 gui=NONE cterm=NONE
hi Conceal guibg=#2c2e34 ctermbg=236 gui=NONE cterm=NONE
hi Directory guifg=#7eb2dd ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiffAdd guifg=#9ed072 ctermfg=149 guibg=#43634e ctermbg=239 gui=NONE cterm=NONE
hi DiffChange guifg=#56ffff ctermfg=87 guibg=#3f4860 ctermbg=238 gui=NONE cterm=NONE
hi DiffDelete guifg=#fc5d7c ctermfg=204 guibg=#5f4448 ctermbg=238 gui=NONE cterm=NONE
hi DiffText guifg=#181819 ctermfg=234 guibg=#7eb2dd ctermbg=110 gui=NONE cterm=NONE
hi ErrorMsg guifg=#fc5d7c ctermfg=204 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#25262c ctermfg=235 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Folded guifg=#7eb2dd ctermfg=110 guibg=#2c2e34 ctermbg=236 gui=NONE cterm=NONE
hi SignColumn guibg=#1b1b1c ctermbg=234 gui=NONE cterm=NONE
hi IncSearch guifg=#181819 ctermfg=234 guibg=#f39660 ctermbg=209 gui=NONE cterm=NONE
hi Search guifg=#181819 ctermfg=234 guibg=#e7c664 ctermbg=185 gui=NONE cterm=NONE
hi LineNr guifg=#33353f ctermfg=237 guibg=#1b1b1c ctermbg=234 gui=NONE cterm=NONE
hi CursorLineNr guifg=#4f5462 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi MatchParen guifg=#181819 ctermfg=234 guibg=#7eb2dd ctermbg=110 gui=NONE cterm=NONE
hi MoreMsg guifg=#9ed072 ctermfg=149 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi NonText guifg=#33353f ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=#4f5462 ctermfg=240 guibg=#25262c ctermbg=235 gui=NONE cterm=NONE
hi PmenuSel guifg=#181819 ctermfg=234 guibg=#7eb2dd ctermbg=110 gui=NONE cterm=NONE
hi PmenuSbar guibg=#2c2e34 ctermbg=236 gui=NONE cterm=NONE
hi PmenuThumb guibg=#4f5462 ctermbg=240 gui=NONE cterm=NONE
hi Question guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#9c8cc3 ctermfg=139 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpellBad guifg=#fc5d7c ctermfg=204 gui=underline cterm=underline
hi SpellLocal guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpellCap guifg=#e7c664 ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpellRare guifg=#7eb2dd ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StatusLine guifg=#4f5462 ctermfg=240 guibg=#1b1b1c ctermbg=234 gui=NONE cterm=NONE
hi StatusLineNC guifg=#4f5462 ctermfg=240 guibg=#25262c ctermbg=235 gui=NONE cterm=NONE
hi Title guifg=#56ffff ctermfg=87 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Visual guibg=#414550 ctermbg=238 gui=NONE cterm=NONE
hi VisualNOS guibg=#7f8490 ctermbg=102 gui=NONE cterm=NONE
hi WarningMsg guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#181819 ctermfg=234 guibg=#7eb2dd ctermbg=110 gui=NONE cterm=NONE
hi Comment guifg=#4f5462 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Builtin guifg=#56ffff ctermfg=87 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Noise guifg=#4f5462 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Constant guifg=#9c8cc3 ctermfg=139 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi String guifg=#e7c664 ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Character String
hi link Boolean Constant
hi Number guifg=#9ed072 ctermfg=149 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Float Number
hi Identifier guifg=#7dc3bd ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Function guifg=#7eb2dd ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Statement guifg=#fc5d7c ctermfg=204 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Conditional Statement
hi link Repeat Statement
hi Label guifg=#ff00ff ctermfg=13 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Operator guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Keyword Statement
hi link Exception Operator
hi PreProc guifg=#9ed072 ctermfg=149 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi Type guifg=#00bcbc ctermfg=37 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi Special guifg=#9c8cc3 ctermfg=139 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special
hi Underlined gui=underline cterm=underline
hi Ignore guifg=#33353f ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Error guifg=#fc5d7c ctermfg=204 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Todo guifg=#7f8490 ctermfg=102 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link cssProp Identifier
hi link cssAttrComma Operator
hi link cssUnitDecorators Operator
hi link cssFunctionComma Noise
hi link cssIdentifier Operator
hi link cssBraces Noise
hi link cssClassName Operator
hi link cssClassNameDot Noise
hi htmlTag guifg=#7f8490 ctermfg=102 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlEndTag guifg=#5f4448 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link htmlArg Function
hi link jsNoise Noise
hi link jsFunction Statement
hi link jsArrowFunction Statement
hi link jsGlobalObjects jsBuiltins
hi link jsGlobalNodeObjects Identifier
hi link jsBuiltins Builtin
hi link jsExceptions Structure
hi link jsObjectKey Identifier
hi link jsVariableDef Identifier
hi link jsDestructuringBlock Identifier
hi link jsDestructuringArray Identifier
hi link jsModuleKeyword Identifier
hi link pythonBuiltin Builtin
hi link pythonDecoratorName pythonDecorator
hi link pythonFunctionCall pythonFunction
hi link pythonBuiltInFunc pythonBuiltin
hi link pythonDottedName pythonDecorator
hi pythonDot guifg=#7f8490 ctermfg=102 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link pythonSingleton Identifier
hi link sassCssAttribute cssAttr
hi link sassVariable cssStringQ
hi link sassMixinName cssFunctionName
hi link sassClass cssClassName
hi link sassId cssIdentifier
hi GitGutterAdd guifg=#9ed072 ctermfg=149 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterChange guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterDelete guifg=#fc5d7c ctermfg=204 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterChangeDelete guifg=#e7c664 ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi YcmErrorSign guifg=#fc5d7c ctermfg=204 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi YcmWarningSign guifg=#f39660 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi YcmErrorSection guifg=#181819 ctermfg=234 guibg=#fc5d7c ctermbg=204 gui=NONE cterm=NONE
hi YcmWarningSection guifg=#181819 ctermfg=234 guibg=#f39660 ctermbg=209 gui=NONE cterm=NONE

if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)

endif

if has('nvim')
endif

" ===================================
" Generated by Estilo 1.5.1
" https://github.com/jacoborus/estilo
" ===================================
