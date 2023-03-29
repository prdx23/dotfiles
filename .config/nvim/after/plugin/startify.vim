let g:startify_bookmarks = [ 
    \ {'t': '~/todo.md'},
    \ {'p': '~/Code/projects'},
    \ {'d': '~/Code/design'},
    \ {'w': '~/Code/work'},
    \ {'b': '~/Documents/vault/braindump'},
    \ ]

let g:startify_lists = [
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'dir',       'header': [' ',
    \     '   Recent: '. escape(fnamemodify(getcwd(), ':~'), '\')
    \     ] },
    \ ]

let g:startify_files_number = 4
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 1
let g:startify_enable_special = 0
let g:startify_fortune_use_unicode = 1

let g:startify_skiplist = [
    \ 'dist/*',
    \ 'venv/*',
    \ ]

let g:startify_custom_header = 'startify#pad(startify#fortune#boxed() + [" "])'
let g:startify_custom_footer = 'startify#pad([" ", "[e] Empty Buffer    [q] Quit"])'

highlight link StartifyFooter Comment
