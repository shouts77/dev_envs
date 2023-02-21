" set qtlog_list
let g:qtlog_list = [
            \{
            \   'path': '/home/tlo/git/qtlog/content/posts/',
            \},
            \{
            \   'path': '/home/shouts/git/qtlog/content/posts/',
            \},
            \]


" md function - date 시간을 현재시간으로 자동수정
function! LastDateModified()

    let l:qtlog_directory = v:false

    for qt in g:qtlog_list
        if expand('%:p:h:h') . '/' == qt.path
            let l:qtlog_directory = v:true
            break
        endif
    endfor

    if !l:qtlog_directory
        return
    endif

    if &modified && exists(qtlog_directory)
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}date\s*: \).*#\1' .
                    \ strftime('%Y-%m-%d') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre *.md call LastDateModified()

