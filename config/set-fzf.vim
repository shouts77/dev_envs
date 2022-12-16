"----------------------------------------------------------
" fzf 설정
"----------------------------------------------------------
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
nnoremap <F1><F1> :Files ~<ENTER>
nnoremap <F2><F2> :Buffers<ENTER>

" hidden file 보기 명령어
"command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"  \   fzf#vim#with_preview(), <bang>0)

"let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
