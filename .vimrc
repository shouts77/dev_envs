"Syntax Highlighting
if has ("syntax")
	syntax on
endif

set autoindent
set cindent
set nu

set smartindent
set tabstop=4
set expandtab
set shiftwidth=4

"가장 최근에 수정한 곳에 커서 위치
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ end

set laststatus=2 "상태바 상시 출력
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
