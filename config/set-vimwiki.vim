"----------------------------------------------------------
" Vimwiki 설정 (by John Grib)
"----------------------------------------------------------

" wiki list 설정
let g:vim_wiki_set_path = expand('<sfile>:p:h')
let g:vimwiki_list = [
            \{
            \   'path': '/home/tlo/git/shouts77.github.io/_wiki/',
            \   'ext' : '.md',
            \   'diary_rel_path': '.',
            \},
            \]

"let wiki = {}
"let wiki.path = '~/git/shouts77.github.io/_wiki/'
"let wiki.ext = '.md'
"
"let g:vimwiki_list = [wiki]

" vimwiki의 conceallevel 을 끄는 쪽이 좋다
let g:vimwiki_conceallevel = 0

" 자주 사용하는 vimwiki 명령어에 단축키를 취향대로 매핑해둔다
"command! WikiIndex :VimwikiIndex
"nmap <LocalLeader>ww <Plug>VimwikiIndex
"nmap <LocalLeader>wi <Plug>VimwikiDiaryIndex
"nmap <LocalLeader>w<LocalLeader>w <Plug>VimwikiMakeDiaryNote
"nmap <LocalLeader>wt :VimwikiTable<CR>
nmap <LocalLeader>v <Plug>VimwikiToggleListItem

" F4 키를 누르면 커서가 놓인 단어를 위키에서 검색한다.
nnoremap <F4> :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>

" Shift F4 키를 누르면 현재 문서를 링크한 모든 문서를 검색한다
nnoremap <S-F4> :execute "VWB" <Bar> :lopen<CR>

" Vimwiki blacklist
"let g:ycm_filetype_blacklist = {}

" Vimwiki 설정이 markdown 설정을 침투하지 않게 하기
let g:vimwiki_global_ext = 0


" Vimwiki의 테이블 단축키를 사용하지 않도록 한다
let g:vimwiki_table_mappings = 0

augroup vimwikiauto
    " <C-s> 로 테이블에서 오른쪽 컬럼으로 이동한다.
    autocmd FileType vimwiki inoremap <C-s> <C-r>=vimwiki#tbl#kbd_tab()<CR>
    " <C-a> 로 테이블에서 왼쪽 컬럼으로 이동한다.
    autocmd FileType vimwiki inoremap <C-a> <Left><C-r>=vimwiki#tbl#kbd_shift_tab()<CR>
augroup END

" Vimwiki function - updated 시간을 현재시간으로 자동수정
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
                    \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre *.md call LastModified()

" Vimwiki function - 메타데이터 기본값 입력 템플릿 생성
function! NewTemplate()

    let l:wiki_directory = v:false

    for wiki in g:vimwiki_list
        if expand('%:p:h') . '/' == wiki.path
            let l:wiki_directory = v:true
            break
        endif
    endfor

    if !l:wiki_directory
        return
    endif

    if line("$") > 1
        return
    endif

    let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : wiki')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tag     : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, 'parent  : ')
    call add(l:template, 'latex   : false')
    call add(l:template, 'resource: ' . substitute(system("uuidgen"), '\n', '', ''))
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

augroup vimwikiauto
    autocmd BufWritePre *wiki/*.md call LastModified()
    autocmd BufRead,BufNewFile *wiki/*.md call NewTemplate()
augroup END

" book progress update function
function! UpdateBookProgress()
    let l:cmd = g:vim_wiki_set_path . "/bookProgressUpdate.sh " . expand('%:p')
    call system(l:cmd)
    edit
endfunction

augroup todoauto
    autocmd BufWritePost *wiki/*.md call UpdateBookProgress()
augroup END

