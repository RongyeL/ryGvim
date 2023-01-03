"-----------------------------------------------------------------------------
" basic configuration 
"-----------------------------------------------------------------------------
syntax on " syntax highlight
filetype plugin indent on  " plugins and indentation based on file type  

set hlsearch " search highlight
set ignorecase " ignore search case

set cuc " current column highlight
set cul " current line highlight

set nu " show line number

set fileencoding=utf-8 "prevent garbled characters
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936,big－5                  
set enc=utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
let &termencoding=&encoding

set guifont=Monospace\ 12 " set font 

set tabstop=4 " set tab to 4 spaces
set expandtab
set shiftwidth=4 "set auto-indent to 4 spaces
set softtabstop=4 " set the back key to delete 4 spaces

set ruler " set show ruler

set smartindent " set smart auto-indent

set showcmd " show command
set autochdir  " auto-swith working directory

winpos 235 235 " set windows position 
set lines=40 columns=108 " set windows size 

set nocompatible " remove vi consistency

"-----------------------------------------------------------------------------
" customize shortcut keys 
"-----------------------------------------------------------------------------
imap ii <ESC>
nmap ww :w<CR>
nmap qq :q<CR> 
nmap fd * 

let mapleader = ","

"-----------------------------------------------------------------------------
" plugin: NERDTree
"-----------------------------------------------------------------------------
map <leader>ne :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 25 " set nerdtree size
let NERDTreeIgnore=['\.pyc','\~$','\.swp'] " ignore the display of the following files
let NERDTreeShowHidden=1 " show hidden files
let g:NERDTreeDirArrowExpandable = '▸' " modify the default arrow symbol
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nerdtree hot key mapping
map <F5> :NERDTreeMirror<CR>
map <F5> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

"-----------------------------------------------------------------------------
" plugin: airline
"-----------------------------------------------------------------------------
let g:airline_theme='base16_gruvbox_dark_hard'

"-----------------------------------------------------------------------------
" plugin: indentline
"-----------------------------------------------------------------------------
let g:indentLine_enable = 1
let g:autopep8_disable_show_diff=1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"-----------------------------------------------------------------------------
" plugin: easyalign
"-----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-----------------------------------------------------------------------------
" plugin: neocomplcache
"-----------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1 " auto start neocomplcache  
let g:neocomplcache_enable_auto_select = 1 " auto select the first item in the list
let g:neocomplcache_min_syntax_length = 2 " Set minimum syntax keyword length.
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-Y>  neocomplcache#close_popup()
inoremap <expr><space>  neocomplcache#undo_completion()
inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"  

"-----------------------------------------------------------------------------
" plugin: gruvbox
"-----------------------------------------------------------------------------
set bg=dark
colorscheme gruvbox

"-----------------------------------------------------------------------------
" plugin: nerdcommender
"-----------------------------------------------------------------------------
" my key: ,cl /,cc /,cu /,c<space>
let g:NERDSpaceDelims = 1 " add space after comment

"-----------------------------------------------------------------------------
" plugin: ale
"-----------------------------------------------------------------------------
"keep the sign gutter open
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" show errors or warnings in my statusline
let g:airline#extensions#ale#enabled = 1 
" use quickfix list instead of the loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" only enable these linters
let g:ale_linters = {
\    'verilog': ['iverilog']
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)

"-----------------------------------------------------------------------------
" plugin: ctags
"-----------------------------------------------------------------------------
nmap gi <C-]> " go into instance module or output port 
nmap go <C-o> " go out to upper stage 


"-----------------------------------------------------------------------------
" plugin: vlogInst
"-----------------------------------------------------------------------------
so ~/.vim/pack/default/start/vlog_inst_gen/vlog_inst_gen.vim " set path

" key: (,ig)

"-----------------------------------------------------------------------------
" plugin: snipmate
"-----------------------------------------------------------------------------
imap <tab> <Plug>snipMateTrigger " tab expand code snippets
imap <tab> <Plug>snipMateNextOrTrigger
imap <C-tab> <Plug>snipMateShow " tab expand code snippets list

"-----------------------------------------------------------------------------
" auto add file header when create new file
"-----------------------------------------------------------------------------
autocmd BufNewFile *.v,*.sv,*.cpp,*.c,*.h exec ":call AddHeader()"
autocmd BufWrite *.v call UpdateLastModifyTime()

function s:GetUserName() 
    let user_name = "Rongye"
    return user_name
endfunction 

function AddHeader() 
       let line = getline(1)
      let filename = expand("%")
       call append(0,  "// +FHDR----------------------------------------------------------------------------")
       call append(1,  "//                 Copyright (c) ".strftime("%Y ") )
       call append(2,  "//                       ALL RIGHTS RESERVED")
       call append(3,  "// ---------------------------------------------------------------------------------")
       call append(4,  "// Filename      : ".filename)
       call append(5,  "// Author        : ".s:GetUserName())
       call append(6,  "// Created On    : ".strftime("%Y-%m-%d %H:%M"))
       call append(7,  "// Last Modified : ")
       call append(8,  "// ---------------------------------------------------------------------------------")
       call append(9,  "// Description   : ")
       call append(10, "//")
       call append(11, "//")
       call append(12, "// -FHDR----------------------------------------------------------------------------")
endfunction 
"-----------------------------------------------------------------------------
" auto update file header modifyTime if write
"-----------------------------------------------------------------------------
function UpdateLastModifyTime() 
       let line = getline(8)
       if line =~ '// Last Modified'
              call setline(8,"// Last Modified : " . strftime("%Y-%m-%d %H:%M"))
       endif
endfunction

