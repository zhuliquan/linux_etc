" ==============================================================================
" 加载插件
" ==============================================================================

call plug#begin('~/.vim/plugged')

" one 配色方案
Plug 'rakr/vim-one'

" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'

" 用来提供一个导航目录的侧边栏
" 在侧边栏按下m 可以弹出一个菜单去选择做相应的操作
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" 可以使 nerdtree Tab 标签的名称更友好些
Plug 'jistr/vim-nerdtree-tabs'

" 可以在导航目录中看到 git 版本信息
Plug 'Xuyuanp/nerdtree-git-plugin'

" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'

" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'

" Go开发的专有插件
Plug 'fatih/vim-go'

" Coc代码补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 智动注释
" <leader>cc comment a line
" <leader>cu uncomment a line
Plug 'preservim/nerdcommenter'

" 快速智能选中某个字符包裹的代码
" 按下回车（Enter）按键自动选择
Plug 'gcmt/wildfire.vim'

" 将选中代码块包裹特定字符
" 选中代码块S指定字符 可以将选中文本以特定字符包裹 S' 用'包裹代码
" cs两个字符, 可以将包裹代码块的第一个字符替换为第二个字符 cs'" ' => "
Plug 'tpope/vim-surround'

" 对齐代码
" ga字符 ga= 就会用等号去对其选中代码
Plug 'junegunn/vim-easy-align'

" 这个用于处理在可视模式下多行编辑
" select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
" create cursors vertically with Ctrl-Down/Ctrl-Up
" select one character at a time with Shift-Arrows
" press n/N to get next/previous occurrence
" press [/] to select next/previous cursor
" press q to skip current and get next occurrence
" press Q to remove current cursor/selection
" start insert mode with i,a,I,A
Plug 'mg979/vim-visual-multi'

" snake camel mixed 各种单词格式替换
" to snake_case press `crs`
" to mixedCase press `crm`
" to camelCase press `crc`
" to UPPER_CASE press `cru`
" to dash-case press `cr-`
" to dot.case press `cr.`
Plug 'tpope/vim-abolish'

" 文件检索工具
" :CtrlP<CR> 可以列举需要检索的文件 
" noremap <leader>p :CtrlP<CR>
Plug 'kien/ctrlp.vim'

" fzf模糊搜索
" noremap <leader>f :Files<CR>
" noremap <leader>b :Buffers<CR>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 给在光标下的单词添加下划线
Plug 'itchyny/vim-cursorword'

" 高亮多个单词
" <leader>k 高亮所有相同单词, 再次<leader>k 用另一种颜色去高亮单词
" <leader>K 取消所有的单词高亮
Plug 'lfv89/vim-interestingwords'

" rust 开发工具
" Rust语法高亮，格式化
Plug 'rust-lang/rust.vim'

" vim-lsp 代码补全, 错误检查
Plug 'prabirshrestha/vim-lsp'

" ale 一步语法检查和代码格式化
Plug 'dense-analysis/ale'

call plug#end()

" ==============================================================================
" 基础设置
" ==============================================================================

" 语法高亮
syntax on
syntax enable
" 设置行号
set number
" 显示命令
set showcmd
" 设置标尺
set ruler
" 显示特定字符
set list
set listchars=tab:<->,trail:.,eol:$,extends:>,precedes:<
" 设置文件编码
set encoding=utf-8
set fileencoding=utf-8
" 设置文件自动载入
set autoread
" 自动保存
set autowrite
" 代码补全
set completeopt=preview,menu
" 不备份
set nobackup
" 不生成临时文件
set noswapfile
" 突出当前行
set cursorline
" 突出当前列
set cursorcolumn
" 设置魔术
set magic
" 自动缩进
set autoindent
" 智能缩进
set smartindent
" 设置tab缩进
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不用空格替代tab
set noexpandtab
" 设置命令历史记录数目
set history=1000
" 搜索忽略大小写
" set ignorecase
" 搜索的时候智能大小写
set smartcase 
" 搜索逐行高亮
set hlsearch
set incsearch
" 显示状态行
set laststatus=2
" 允许插件
filetype plugin on
filetype indent on
" 检测文件类型
filetype on
" backspace可以删除数据
set backspace=2
" 高亮括号匹配
set showmatch
" 设置显示颜色为真彩色
set t_Co=256
set termguicolors
" 设置配色
colorscheme one     " for 'one' colorschema

set background=dark " for the dark version

" 防止一行代码太长，可以折叠这一行代码
set wrap
" 自动根据文件切换目录
set autochdir

" 退出插入模式自动保存
au InsertLeave *.c,*.cc,*.cxx,*.cpp,*.cs,*.ts,*.js,*.css,*.html,*.go,*.rs,*.java,*.tsx,*.scala,*.vim,*.vimrc,*.sh,*.bash write

" ==============================================================================
" 按键设置
" ==============================================================================

let mapleader=","
map s <nop>
nmap <leader>R :source $MYVIMRC<CR>
nmap <silent> <Esc> <Esc>:noh<CR>
" 选择文本使用rustfmt 进行格式化
vnoremap <leader>rsft :RustFmtRange<CR>
" 普通模式执行rustfmt 对文件进行格式化
nnoremap <leader>rsft :RustFmt<CR>

" ==============================================================================
" NERDTree 插件
" ==============================================================================
" 打开和关闭NERDTree快捷键
nmap <leader><F9> :NERDTreeToggle<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
" let NERDTreeWinSize=31
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1

" ==============================================================================
" nerdtree-git-plugin 插件
" ==============================================================================
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:NERDTreeGitStatusShowIgnored = 1

" ==============================================================================
" majutsushi/tagbar 插件
" ==============================================================================

" majutsushi/tagbar 插件打开关闭快捷键
nmap <leader><F10> :TagbarToggle<CR>

" ==============================================================================
" vim-easy-align 插件
" ==============================================================================

xmap ga <Plug><(EasyAlign)
nmap ga <Plug><(EasyAlign)


" ==============================================================================
" ctrlp 插件
" ==============================================================================

noremap <leader>p :CtrlP<CR>

" ==============================================================================
" fzf.vim 插件
" ==============================================================================

noremap <leader>f :Files<CR>
noremap <leader>b :Buffers<CR>

" ==============================================================================
" airline 插件
" ==============================================================================
" 启用tabline
let g:airline#extensions#tabline#enabled = 1
" 在装填栏显示ale检查检查结果
let g:airline#extensions#ale#enabled = 1
" 显示buffer编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 直接定位到要用buffer
nmap <leader>1 :b1<CR>
nmap <leader>2 :b2<CR>
nmap <leader>3 :b3<CR>
nmap <leader>4 :b4<CR>
nmap <leader>5 :b5<CR>
nmap <leader>6 :b6<CR>
nmap <leader>7 :b7<CR>
nmap <leader>8 :b8<CR>
nmap <leader>9 :b9<CR>

" ==============================================================================
" rust.vim 插件
" ==============================================================================
" 自动保存rust文件
let g:rustfmt_autosave = 1 
" 格式化命令
let g:rustfmt_command = "rustfmt" 

" ==============================================================================
" ale 插件
" ==============================================================================
" rust 代码检查
let g:ale_linters = { "rust": [ "analyzer", "cargo", "clippy" ] }
" rust bug修复工具
let g:ale_fixers = { "rust": [ "cargo", "rustfmt" ] }
" 使用clippy进行更加严格的代码检查
let g:ale_rust_cargo_use_clippy = 1
" ale 错误和告警显示
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" ale开启修复列表
let g:ale_open_list = 1
let g:ale_set_quickfix = 1

