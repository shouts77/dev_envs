"----------------------------------------------------------
" airline 설정
"----------------------------------------------------------

" airline theme
"let g:airline_theme='badwolf'

" buffer 목록 켜기
let g:airline#extensions#tabline#enabled = 1       

" buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_show = 1

" buffer number format
let g:airline#extensions#tabline#buffer_nr_format = '%s:'

" Tab line 포맷 설정
"let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#tabline#formatter = 'default'

" Tab line 구분자 '|' 로 설정
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Tab line에 buffer 목록 파일명만 출력
" let g:airline#extensions#tabline#fnamemod = ':t'

" Powerline-font 활성화
let g:airline_powerline_fonts = 1
