" Basic Setting

syntax enable
filetype plugin indent on
set nu
set relativenumber
set autoindent
set expandtab
set splitright
set splitbelow
set tabstop=4
set backspace=2
set shiftwidth=4
set cursorline
" 修改leader 键位
let mapleader = ","
noremap , \

" 移动窗口
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

noremap <leader>k :resize +10<cr>
noremap <leader>j :resize -10<cr>
noremap <leader>h :vertical resize +10<cr>
noremap <leader>l :vertical resize -10<cr>

map Q :q!<cr>

" 手动设置安装有py-neovim的python3 环境
let g:python3_host_prog='/usr/bin/python3'

call plug#begin("~/.config/nvim/plugged")

" toobar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'xuyuanp/nerdtree-git-plugin'

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'
" comment
Plug 'scrooloose/nerdcommenter'
" autosave
Plug '907th/vim-auto-save'

"python
Plug 'numirias/semshi',{'do': ':UpdateRemotePlugins','for':['python','vim-plug']}
Plug 'Vimjas/vim-python-pep8-indent',{'for':['python','vim-plug']}
Plug 'tweekmonster/braceless.vim'

"python env 有BUG 无法正常激活虚拟环境
" Plug 'jmcantrell/vim-virtualenv'

" go
Plug 'fatih/vim-go',{'do':':GoInstallBinaries'}

" formatter
Plug 'chiel92/vim-autoformat'

" undo tree
Plug 'mbbill/undotree'

" debugger
Plug 'puremourning/vimspector', {'do':'./install_gadget.py --enable-c --enable-python --enable-go --enable-bash'}

 "markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dkarter/bullets.vim'
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'

" snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" align
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

" 让nerdtree 上显示git仓库文件git的状态

let g:NERDTreeIndicatorMapCustom = {
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

" nerdtree config

noremap <leader>r :NERDTreeToggle<CR>


" ctrlp config
" 忽略某些文件
let g:ctrp_custom_ignore = {
		\ 'dir': '\v[\/]\.(git|hg|svn)$',
		\ 'file': '\v\.(exe|so|dll)$',
		\ 'link': 'some_bad_symbolic_links',
		\}

" coc 配置

let g:coc_global_extensions=['coc-python','coc-go','coc-html','coc-json','coc-html','coc-css','coc-tsserver','coc-vetur','coc-yaml']

" 使用tab 切换选中
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :<SID>check_back_space() ? "\<TAB>" : coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
		  let col = col('.') - 1
		    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" 在airline 上显示错误跟警告信息
" let airline#extensions#coc#enabled = 0
" let airline#extensions#coc#error_symbol = 'Error:'
" let airline#extensions#coc#warning_symbol = 'Warning:'

" undotree`
noremap <leader>n :UndotreeToggle<CR>

" Semshi config

nmap <silent> <leader>rr :Semshi rename<CR>
nmap <silent> <TAB> :Semshi goto name next<CR>
nmap <silent> <S-Tab> :Semshi goto name prev<CR>
nmap <silent> <leader>c :Semshi goto class next<CR>
nmap <silent> <leader>C :Semshi goto class prev<CR>

nmap <silent> <leader>f :Semshi goto function next<CR>
nmap <silent> <leader>F :Semshi goto function prev<CR>
nmap <silent> <leader>gu :Semshi goto unresolved first<CR>
nmap <silent> <leader>gp :Semshi goto parameterUnused first<CR>
nmap <silent> <leader>ee :Semshi error<CR>
nmap <silent> <leader>ge :Semshi goto error<CR>

" barceless config
autocmd FileType python BracelessEnable +indent +fold +hightlight-cc2

" auto format
noremap <leader>gf :Autoformat<CR>

" ultisnips config
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vimspector config
let g:vimspector_enable_mappings='HUMAN'
" git config 
nmap gb :Gblame<CR> 

" autosave 
let g:auto_save=1
let g:auto_save_events=["InsertLeave"]
