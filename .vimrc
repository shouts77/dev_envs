" Encoding setting
set encoding=utf-8
set fileencodings=utf-8,cp949

"----------------------------------------------------------
" Vim 기본 설정
"----------------------------------------------------------
" Vim-Plug 설정 파일 관리 (by John Grib)

" Vim-Plug 목록
let g:config_dir = expand('~/git/dotfiles/config/')
let s:file_plug_candidate = []

command! -nargs=1 PlugFile call <SID>plug_file(<args>)
function! s:plug_file( ... )
    call add(s:file_plug_candidate, g:config_dir . a:1)
endfunction

" 아래와 같이 설정한 다음 :PlugInstall<CR> 해주면 된다.
call plug#begin('~/.vim/plugged')

    "* Cursor, Color
    Plug 'johngrib/FlatColor-johngrib'
        PlugFile 'set-color.vim'
        PlugFile 'set-cursor.vim'


    " Vim기반 어플리케이션
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' } 
        PlugFile 'set-vimwiki.vim'


    " Session
    Plug 'mhinz/vim-startify'
        PlugFile 'set-startify.vim'


    " Display
    Plug 'vim-airline/vim-airline'
        PlugFile 'set-airline.vim'
        

    " File 탐색
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        PlugFile 'set-fzf.vim'

    Plug 'preservim/nerdtree'
        PlugFile 'set-nerdtree.vim'


    " 자동완성
    Plug 'SirVer/ultisnips'
        PlugFile 'set-ultisnips.vim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
        PlugFile 'set-coc.vim'

    Plug 'jiangmiao/auto-pairs'
        PlugFile 'set-autopairs.vim'

    " 편집 기능 확장
    Plug 'tpope/vim-surround'

    " 외부 기능 지원
    " git
    Plug 'tpope/vim-fugitive'
    

    " ctags
    Plug 'ludovicchabant/vim-gutentags'
        PlugFile 'set-gutentags.vim'
    Plug 'majutsushi/tagbar'
        PlugFile 'set-tagbar.vim'
    Plug 'jszakmeister/markdown2ctags', {'do' : 'cp ./markdown2ctags.py ~/markdown2ctags.py'}


    " language 확장
    Plug 'rust-lang/rust.vim'
    Plug 'evanleck/vim-svelte', {'branch': 'main'}

    " qtlog 기능
        PlugFile 'set-qtmd.vim'


call plug#end()

" Brief help
" PlugInstall: Install plugins
" PlugUpdate: Install or update plugins
" PlugClean: Remove unlisted plugins
" PlugUpgrade: Upgrade vim-plug itself
" PlugStatus: Check the status of plugins

for include_file in s:file_plug_candidate
    execute "source " . include_file
endfor
let s:file_plug_candidate = v:null

" COC plugin 목록
" :CocUpdate
let g:coc_global_extensions = [
            \ 'coc-ultisnips',
            \ 'coc-explorer',
            \ 'coc-prettier',
            \]


" basic setting (by John Grib)

set nocompatible "vi 기능을 사용하지 않고 vim 만의 기능을 사용
set hidden  " Buffer should still exist if window is closed

set cursorcolumn
set cursorline       " highlight current line
set lazyredraw       " redraw only when we need to.


set number          " 행숫자표기, 인덴트, 탭너비 설정
set ruler           " 현재 커서 위치 (row, col) 좌표 출력
set laststatus=2    " 상태바를 언제나 표시할 것

set autoindent
set cindent
set smartindent

set tabstop=4
set expandtab
set shiftwidth=4

set smartcase       " 대문자가 검색어 문자열에 포함될 때는 noignorecase
set ignorecase      " 검색 시 대소문자 무시
set hlsearch        " 검색 시 하이라이트
set incsearch       " 검색 키워드 입력 시 한 글자 입력할 때마다 점진 검색

"set background=dark " 검정배경을 사용할 때, (문법 하이라이트 색상 달라짐)
set sm              " 매치되는 괄호 표시

" 모드별로 커서 모양 변경하기
"autocmd InsertEnter * set cursorcolumn
"autocmd InsertLeave * set nocursorcolumn

" 20211203 - change cursor shape for each insert, command mode
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).
" t_SI: Start Insert mode
" t_EI: End Insert mode

"let &t_SI = "\<ESC>[1 q"
"let &t_EI = "\<ESC>[2 q"

" 짜증나는 swp, backup 파일 안 만들기
set noswapfile
set nobackup

set langmap=ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz
set splitbelow
set splitright
set virtualedit=block   " visual block mode를 쓸 때 문자가 없는 곳도 선택 가능하다
set autoread


" map
let mapleader = "\<Space>"
let maplocalleader = "\\"

" ESC 대응
imap jk <Esc>
imap kj <Esc>

" navigation 기능 보완 
nnoremap <Space>h ^
nnoremap <Space>l $
noremap <Space>j 8j
noremap <Space>k 8k

" buffer 이동
nnoremap <silent> <PageUp>   :bnext!<CR>
nnoremap <silent> <PageDown> :bprevious!<CR>

" Syntax Highlighting
"if has ("syntax")
"    syntax on
"endif

" 현재 편집중인 파일 경로로 pwd 를 변경한다
command! Ncd :cd %:p:h
