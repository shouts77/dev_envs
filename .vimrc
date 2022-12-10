"----------------------------------------------------------
" Vim 기본 설정
"----------------------------------------------------------

" Syntax Highlighting
if has ("syntax")
    syntax on
endif

" 행숫자표기, 인덴트, 탭너비 설정
set number
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

set background=dark " 검정배경을 사용할 때, (문법 하이라이트 색상 달라짐)
set sm              " 매치되는 괄호 표시

" 모드별로 커서 모양 변경하기
autocmd InsertEnter * set cursorcolumn
autocmd InsertLeave * set nocursorcolumn

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

let &t_SI = "\<ESC>[1 q"
let &t_EI = "\<ESC>[2 q"

" 가장 최근에 수정한 곳에 커서 위치
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ end

" ESC 대응
imap jk <Esc>
imap kj <Esc>

" 명령행 한글 입력 오류 처리
ca ㅈ w


" 버퍼간 이동
nnoremap <F12>b :bn<ENTER>
nnoremap <F12>c :bp<ENTER>
nnoremap <F12>x :bd<ENTER>

" navigation 기능 보완 
nnoremap <Space>h ^
nnoremap <Space>l $
noremap <Space>j 8j
noremap <Space>k 8k

"----------------------------------------------------------
" vim-plug 설정
"----------------------------------------------------------

" vim-plug automatic installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'vimwiki/vimwiki', { 'branch': 'dev' } 
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Brief help
" PlugInstall: Install plugins
" PlugUpdate: Install or update plugins
" PlugClean: Remove unlisted plugins
" PlugUpgrade: Upgrade vim-plug itself
" PlugStatus: Check the status of plugins

"----------------------------------------------------------
" vim bundle 설정
"----------------------------------------------------------

" bundle config
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" NerdTree
Plugin 'The-NERD-tree'

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"----------------------------------------------------------
" The-NERD-tree 설정
"----------------------------------------------------------
nnoremap <F12>n :NERDTreeToggle<ENTER>

"----------------------------------------------------------
" Vimwiki 설정 (by John Grib)
"----------------------------------------------------------

" 로컬 리더 키 설정은 취향이니 각자 마음에 드는 키로 설정한다
let maplocalleader = "\\"

" wiki list 설정
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
command! WikiIndex :VimwikiIndex
nmap <LocalLeader>ww <Plug>VimwikiIndex
nmap <LocalLeader>wi <Plug>VimwikiDiaryIndex
nmap <LocalLeader>w<LocalLeader>w <Plug>VimwikiMakeDiaryNote
nmap <LocalLeader>wt :VimwikiTable<CR>

" F4 키를 누르면 커서가 놓인 단어를 위키에서 검색한다.
nnoremap <F4> :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>

" Shift F4 키를 누르면 현재 문서를 링크한 모든 문서를 검색한다
nnoremap <S-F4> :execute "VWB" <Bar> :lopen<CR>

" Vimwiki blacklist
let g:ycm_filetype_blacklist = {}

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

"----------------------------------------------------------
" stratify setting
"----------------------------------------------------------

" showing first page when all buffer was deleted
autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

" stratify list order
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]


let g:startify_session_sort = 1

