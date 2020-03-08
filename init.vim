set encoding=utf8
setglobal fileencoding=utf8

set shell=/usr/local/bin/fish

set runtimepath+=$HOME/.config/nvim
let g:python3_host_prog = '/usr/local/bin/python3'

syntax on

" Keymaps may be omitted.
call plug#begin(stdpath('config').'/plugged/')
    runtime! plugin/*.vim
call plug#end()
exe 'source' . stdpath('config').'/quickui.vim'


" ========= PLUGIN INDEPENDENT SETTINGS ===========
set laststatus=2 " Status bar always show
set showtabline=2 " Tabline always show
if $TERM == "xterm-256color"
    set t_Co=256
endif


set termguicolors " GUI colors

set hidden " something about hidden buffers

set nu " have numbers

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove tool bar
set guioptions-=r  "remove right scroll bar
set guioptions-=L  "remove left scroll bar

set mouse=a

set breakindent
set linebreak
set backspace=indent,eol,start
set nowrap
set autoread
set shiftwidth=4
set tabstop=4
set shiftround
set expandtab
set smarttab
set autoindent

set ignorecase " infercase
set smartcase

set wildmenu
set wildmode=full
set wildoptions=tagfile "pum is cool though
set wildignore+=*.o,*.obj,*.pyc,.git,.svn,*.a,*.class,*.mo,*.la,*.so
set wildignore+=*.ttf,\*.obj,*.swp,*.jpg,*.pdf,*.png,*.xpm,*.gif,*.jpeg
set wildignore+=build,lib,node_modules,public,_site,third_party
set suffixes+=.old
" Ignore lib/ dirs since the contain compiled libraries typically
" Ignore images and fonts
" Ignore case when completing

set title



" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5
set sidescroll=1

set showbreak=↪\
" set list listchars=tab:→\ ,trail:⋅,nbsp:␣,extends:⟩,precedes:
set list listchars=tab:▷⋅,trail:⋅,nbsp:░, 
set fillchars=diff:⣿                " BOX DRAWINGS
set fillchars=vert:┃               " HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
set fillchars=eob:\ 
set fillchars=fold:\ 

set foldmethod=syntax "indent
set foldcolumn=0
set foldlevel=99
set foldlevelstart=10

set diffopt+=vertical,algorithm:histogram,indent-heuristic

" All these gets deleted by the os eventually
set backupdir=/tmp/backup//
set directory=/tmp/swap//
set undodir=/tmp/undo//
" set tags=/tmp/tags;

set undofile " persistant undo
set nobackup
set nowritebackup

" Thesaurus and dictionary support
let &thesaurus=stdpath('config').'/thesaurus/words.txt'
set dictionary+=/usr/share/dict/words

set langmenu=en_US

set signcolumn=auto

set updatetime=300
set cmdheight=1
set noshowmode " No need for that
set shortmess+=A      " ignore annoying swapfile messages
set shortmess+=I      " no splash screen
set shortmess+=O      " file-read message overwrites previous
set shortmess+=T      " truncate non-file messages in middle
set shortmess+=W      " don't echo "[w]"/"[written]" when writing
set shortmess+=a      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o      " overwrite file-written messages
set shortmess+=t      " truncate file messages at start

set inccommand=nosplit " realtime changes for ex-commands
set shortmess+=c

set showcmd
let mapleader = " "

set conceallevel=2
set concealcursor= "ni

set formatoptions+=j
set grepprg=rg\ --vimgrep

set whichwrap=b,h,l,s,<,>,[,],~
set virtualedit=block
" allow cursor to move where there is no text in visual block mode

set modelineexpr
set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview
set complete-=i

set pumheight=25
set pumblend=20
set winblend=20

" Wait for cursorhold to trigger
set updatetime=250
set splitright

autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber


" Close quickfix with q, esc or C-C
augroup easy_close
    autocmd!
    autocmd FileType help,qf nnoremap <buffer> q :q<cr>
    autocmd FileType qf nnoremap <buffer> <Esc> :q<cr>
augroup END

autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif

" ====== FUNCTIONS ========




" ======= MAPPINGS ========
" Basics
noremap <CR> :
noremap Q :close<cr>
noremap <leader>Q :bd<cr>
noremap x "_x

noremap Y y$

" Annoying with a trackpad
noremap <ScrollWheelLeft> <nop>
noremap <ScrollWheelRight> <nop>

" Buffer magic
noremap gb :bn<CR>
noremap gB :bp<CR>

nnoremap <silent> <C-^> :<C-u>exe
            \ v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<CR>

" No highlighting
noremap <silent> <leader><space> :noh<CR>
noremap <silent> <space><space><space> :noh<CR>

vnoremap . :normal .<CR>
vnoremap @ :normal @<CR>

" Keep selection with indention
vnoremap > >gv
vnoremap < <gv

" Terminal magic
tnoremap <C-X> <C-\><C-n>
" tmap <C-j> <C-\><C-n><C-j>
" tmap <C-k> <C-\><C-n><C-k>
" tmap <C-h> <C-\><C-n><C-h>
" tmap <C-l> <C-\><C-n><C-l>


" CoC Stuff
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@


" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" ====== COLORS =======
let g:neomolokai_inv_column=1
colorscheme neomolokai


set secure
