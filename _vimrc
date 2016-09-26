source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set lines=50 columns=118	" �趨��ʱ���ڴ�С
set nocompatible 	" �ر� vi ����ģʽ
syntax on 		" �Զ��﷨����
colorscheme desert 	" �趨��ɫ����
set number 		" ��ʾ�к�
set cursorline 		" ͻ����ʾ��ǰ��
set ruler 		" ��״̬�����
set shiftwidth=4 	" �趨 << �� >> �����ƶ�ʱ�Ŀ��Ϊ 4
set softtabstop=4 	" ʹ�ð��˸��ʱ����һ��ɾ�� 4 ���ո�
set tabstop=4 		" �趨 tab ����Ϊ 4
set nobackup 		" �����ļ�ʱ������
set noundofile      " ������undo�ļ�
set noswapfile		" ������swap�ļ�
set autochdir		" �Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
set backupcopy=yes 	" ���ñ���ʱ����ΪΪ����
set ignorecase smartcase " ����ʱ���Դ�Сд��������һ�������ϴ�д��ĸʱ�Ա��ֶԴ�Сд����
set nowrapscan 		" ��ֹ���������ļ�����ʱ��������
set incsearch	 	" ������������ʱ����ʾ�������
set hlsearch 		" ����ʱ������ʾ���ҵ����ı�
set noerrorbells 	" �رմ�����Ϣ����
set novisualbell 	" �ر�ʹ�ÿ�������������
set t_vb= 		" �ÿմ����������ն˴���
set magic 		" ����ħ��
set hidden 		" ��������δ������޸�ʱ�л�����������ʱ���޸��� vim ���𱣴�
set smartindent 	" ��������ʱʹ�������Զ�����
set backspace=indent,eol,start
			" ���趨�ڲ���״̬�޷����˸���� Delete ��ɾ���س���
set cmdheight=1 	" �趨�����е�����Ϊ 1
set laststatus=2 	" ��ʾ״̬�� (Ĭ��ֵΪ 1, �޷���ʾ״̬��)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
			" ������״̬����ʾ����Ϣ
set foldenable 		" ��ʼ�۵�
set foldmethod=syntax 	" �����﷨�۵�
set foldcolumn=0 	" �����۵�����Ŀ��
setlocal foldlevel=1	 " �����۵�����Ϊ

" <F2>��ʾ/���ع�����&�˵���
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

" �û�Ŀ¼����$VIMFILES
if MySys() == "windows"
  let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
  let $VIMFILES = $HOME.'/.vim'
endif

" �趨doc�ĵ�Ŀ¼
let helptags=$VIMFILES.'/doc'

" �������� �Լ�����֧��
if has("win32")
set guifont=Microsoft\ Yahei\ Mono:h11
endif

" ���ö����Ի���
if has("multi_byte")
" UTF-8 ����
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

" Buffers������ݷ�ʽ!
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" Tab������ݷ�ʽ!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

"����tab�Ŀ�ݼ�
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

