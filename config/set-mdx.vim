
" date 시간을 현재시간으로 자동수정
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}date\s*: \).*#\1' .
                    \ strftime('%Y-%m-%d') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre *.mdx call LastModified()
