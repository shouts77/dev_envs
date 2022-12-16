"* Tagbar 설정

nnoremap \t :TagbarToggle<CR>:e<CR>
nnoremap \\t :TagbarOpen f<CR>

let g:tagbar_type_vimwiki = {
    \ 'ctagstype' : 'vimwiki',
    \ 'sort': 0,
    \ 'kinds' : [
        \ 't:목차'
    \ ]
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
    \ 'i:images'
        \ ],
        \ 'sro' : '»',
        \ 'kind2scope' : { 's' : 'section' },
        \ 'sort': 0,
        \ }

augroup tagbar_custom_color
    autocmd FileType tagbar syntax match tagbar_ignore_char /·/
    autocmd FileType tagbar hi def link tagbar_ignore_char Comment
augroup END
