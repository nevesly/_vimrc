"----------------------------------------+
" vim 7.x 配置文件
"----------------------------------------+

set nocompatible "不需要兼容VI

" encoding settings
set fileformats=unix,dos,mac
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

" font settings
" set guifont=MONACO:h12
" set guifont=Lucida_Console:h16
" set guifont=Terminus:h16
set guifont=BPmono:h16
"
set go=e " guioption
set number " line number
set hlsearch

" indent settings
set ts=4
set nocursorline
set shiftwidth=4
set softtabstop=4 
set tabstop=4
" set smarttab
set expandtab

" colorscheme ego
" colorscheme wombat
" colorscheme desert
colorscheme gruvbox

" 开启文件自动识别
syntax on
filetype on
"filetype plugin on
filetype indent on

"关闭声音
set noerrorbells
set novisualbell
set noerrorbells visualbell t_vb=
au GUIEnter * set vb t_vb=

" fix broken characters in menu
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" fix broken characters in console
language messages zh_CN.utf-8

" 括号补全
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap < <><left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

" Quickfix 的快捷键
map [q :cnext<CR>
map ]q :cprev<CR>
map [Q :cfirst<CR>
map ]Q :clast<CR>

" display the tab string
" set listchars=tab:>-,trail:.,extends:>,precedes:<
set listchars=tab:>-,extends:>,precedes:<
set list

"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" 状态栏的显示形式
set laststatus=2
set statusline=%f\ \%h%m%r%r%=%-35(%l,%c\ [0x%B]\ (%L\ lines)\ %Y%)\ %P

" 开关光标辅助线
hi Search guibg=#ff6600 guifg=#ffffff
hi IncSearch guibg=#ff6600 guifg=#ffffff
hi cursorline guibg=#222222
hi cursorcolumn guibg=#222222
function! ToggleCursorLine()
    if !exists("g:CursorLineStatu")
        let g:CursorLineStatu = 0
    endif
    if g:CursorLineStatu == 1
        set nocursorcolumn
        set nocursorline
        let g:CursorLineStatu = 0
    else
        set cursorcolumn
        set cursorline
        let g:CursorLineStatu = 1
    endif
endfunction
" call ToggleCursorLine() "默认打开光标辅助线,想要关闭请注释这行

" 梆定到Alt+m键上
map <m-m> :call ToggleCursorLine()<cr>

" ec 文件的类型是erlang
au BufNewFile,BufRead *.ec set filetype=erlang

" md 文件的类型是 markdown
au BufNewFile,BufRead *.md set filetype=ghmarkdown

" 新建 *.erl 文件加载模板文件
au BufNewFile *_app.erl r c:/vim/erl_app.erl
au BufNewFile *_sup.erl r c:/vim/erl_sup.erl
au BufNewFile *_service.erl r c:/vim/erl_service.erl

" 新建 *.py 文件加载模板文件
au BufNewFile *.py r c:/vim/py.py

" setting for CtrlP plugin
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*.pyc
set wildignore+=*.beam
set wildignore+=*.swp
set wildignore+=*.swo
set wildignore+=*.sw*
set wildignore+=*.class
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*,*/bin/*,*.class
let g:ctrlp_working_path_mode=0
let g:ctrlp_custom_ignore={
\ 'dir':  'great_service/\include|great_service\/src\/common|bin',
\ 'file': '\.pyc$|\.DCL$|\.DCD$|\.swp$|\.swo$|\.class$'
\ }
" end CtrlP Config

" make a custom command for user to run the os's command, and then it will open a new window to show the output
" http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(line)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright tabe
  "botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

"""设置语法检查工具
""let g:syntastic_enable_signs=1
""
""" let g:syntastic_auto_loc_list=1
""" set statusline+=%#warningmsg#
""" set statusline+=%{SyntasticStatuslineFlag()}
""" set statusline+=%*
"""Errors显示切换
""map! <m-e> <c-o>:call ToggleErrors()<cr>
""map <m-e> :call ToggleErrors()<cr>
""function! ToggleErrors()
""    if !exists("g:errors_is_show")
""        let g:errors_is_show = 0
""    endif
""    if g:errors_is_show
""        let g:errors_is_show = 0
""        lclose
""    else
""        let g:errors_is_show = 1
""        " Errors 需要Syntastic插件支持
""        Errors
""    endif
""endfunction

