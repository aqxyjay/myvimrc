source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set lines=50 columns=118	" 设定打开时窗口大小
set nocompatible 	" 关闭 vi 兼容模式
syntax on 		" 自动语法高亮
colorscheme desert 	" 设定配色方案
set number 		" 显示行号
set cursorline 		" 突出显示当前行
set ruler 		" 打开状态栏标尺
set shiftwidth=4 	" 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 	" 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 		" 设定 tab 长度为 4
set nobackup 		" 覆盖文件时不备份
set noundofile      " 不生成undo文件
set noswapfile		" 不生成swap文件
set autochdir		" 自动切换当前目录为当前文件所在的目录
set backupcopy=yes 	" 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan 		" 禁止在搜索到文件两端时重新搜索
set incsearch	 	" 输入搜索内容时就显示搜索结果
set hlsearch 		" 搜索时高亮显示被找到的文本
set noerrorbells 	" 关闭错误信息响铃
set novisualbell 	" 关闭使用可视响铃代替呼叫
set t_vb= 		" 置空错误铃声的终端代码
set magic 		" 设置魔术
set hidden 		" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set smartindent 	" 开启新行时使用智能自动缩进
set backspace=indent,eol,start
			" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 	" 设定命令行的行数为 1
set laststatus=2 	" 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
			" 设置在状态行显示的信息
set foldenable 		" 开始折叠
set foldmethod=syntax 	" 设置语法折叠
set foldcolumn=0 	" 设置折叠区域的宽度
setlocal foldlevel=1	 " 设置折叠层数为

" <F2>显示/隐藏工具栏&菜单栏
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
  if has("win16") || has("win32") || has("win64") || has("win95")
    return "windows"
  elseif has("unix")
    return "linux"
  endif
endfunction

" 用户目录变量$VIMFILES
if MySys() == "windows"
  let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
  let $VIMFILES = $HOME.'/.vim'
endif

" 设定doc文档目录
let helptags=$VIMFILES.'/doc'

" 设置字体 以及中文支持
if has("win32")
set guifont=Microsoft\ Yahei\ Mono:h11
endif

" 配置多语言环境
if has("multi_byte")
" UTF-8 编码
  set encoding=utf-8
  set termencoding=utf-8
  set formatoptions+=mM
  set fencs=utf-8,gbk

  if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
  endif

  if has("win32")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
  endif
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" Buffers操作快捷方式!
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" Tab操作快捷方式!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

"关于tab的快捷键
map tn :tabnext<cr>
map tp :tabprevious<cr>
map tn :tabnew .<cr>
map te :tabedit
map tc :tabclose<cr>

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

