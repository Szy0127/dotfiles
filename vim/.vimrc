" ----------------------------------------
" Include bundles.vim
" ----------------------------------------
source ~/.vim/bundles.vim

" ----------------------------------------
" Platform Specific Configuration
" ----------------------------------------

if has('win32') || has('win64')
  " Windows
  source $VIMRUNTIME/mswin.vim
  set guifont=Consolas:h12:cANSI
  set guioptions-=T " Toolbar
  set guioptions-=m " Menubar

  " Set height and width on Windows
  set lines=60
  set columns=120

  " Windows has a nasty habit of launching gVim in the wrong working directory
  cd ~
elseif has('gui_running')
  if has("gui_macvim")
    "set guifont=Monaco:h12
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12
    " e: tab page, g: gray menu, m: menu bar, t: tearoff menu items
    set guioptions=egmt
    " commands like yy will directly put content into mac clipboard
    set clipboard=unnamed
  endif
  winsize 90 45
else
  set guifont=Source\ Code\ Pro\ for\ Powerline:h12
endif

" ----------------------------------------
" Regular Vim Configuartion (No Plugins Needed)
" ----------------------------------------

" ---------------
" Color
" ---------------
set t_Co=256
try
  colorscheme Tomorrow-Night-Eighties
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

" ---------------
" File encodings
" ---------------
set fileencodings=utf-8,gbk "ucs-bom,ucs-4
set encoding=utf-8

" ---------------
" Backups
" ---------------
set backup
call mkdir(expand('~/.vim/data/backup'), 'p')
call mkdir(expand('~/.vim/data/swap'), 'p')
set backupdir=~/.vim/data/backup
set directory=~/.vim/data/swap

" ---------------
" UI
" ---------------
set modelines=5
set ruler " show the cursor position all the time
set nu
set wrap " wrap long text when displaying
set laststatus=2
"set cmdheight=2
"set list
" :dig for more symbols
"set listchars=tab:»·,trail:·

" ---------------
" Behaviors
" ---------------
syntax on
set shortmess=atI
set hidden " allow change to buffer while modified
set wildmenu
set cf
set history=100
set showcmd " display incomplete commands
set autowrite " Writes on make/shell commands
set wildignore+=*.o,*.obj,.git
set scrolloff=5 " Always keep 5 lines above/below the cursor
set timeoutlen=300 " Time to wait for a command (after Leader for example)

" ---------------
" Text Format
" ---------------
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set shiftwidth=4  " Tabs under smart indent
set cindent
set autoindent
set smarttab
set textwidth=0
" for better formatting for multi-byte characters
set formatoptions+=tcqMm

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase " Non-case sensitive search
set incsearch
set hlsearch

" ---------------
" Visual
" ---------------
set showmatch  " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink

" ---------------
" Sounds
" ---------------
set noerrorbells
set novisualbell
set t_vb=

" ---------------
" Mouse
" ---------------
if has('mouse')
  set mousehide  " Hide mouse after chars typed
  set mouse=a  " Mouse in all modes
end

" Better complete options to speed it up
set complete=.,w,b,u,U

" ----------------------------------------
" Bindings
" ----------------------------------------

let mapleader=","

" Window Movement
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Fixes common typos
command W w
command Q q
abbreviate teh the

" Make line completion easier
imap <C-l> <C-x><C-l>

map <F1> <Esc>
imap <F1> <Esc>
map <F2> :w<CR>
map <F3> :q!<CR>
map <F4> :tabnext<CR>
map <F5> :tabprevious<CR>
map <F6> :copen<CR>

" Jump to the exact location of the mark
nmap ' `
nnoremap ; :
nnoremap j gj
nnoremap k gk

" Switch on spell
nmap <silent> <Leader>s :setlocal spell!<CR>
nmap <silent> <Leader>v :e ~/.vimrc<CR>
nmap <silent> <Leader>b :e ~/.vim/bundles.vim<CR>
set pastetoggle=<Leader>p

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Don't use Ex mode, use Q for formatting
nmap Q gqap
vmap Q gq

" In case forget to use sudo vim
cmap w!! w !sudo tee % >/dev/null

" ctrl + k to move over the last pair
"inoremap ( ():let leavechar=")"i
"inoremap [ []:let leavechar="]"i
"inoremap " "":let leavechar="\""i
"inoremap <C-k> :exec "normal f" . leavechara

" ----------------------------------------
" Auto Commands
" ----------------------------------------

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" cpp, java specific abbreviation
"autocmd filetype c,cpp,java set shiftwidth=8 | set ts=8 | set noexpandtab
set expandtab
autocmd filetype c,cpp,java set shiftwidth=4 | set ts=4 | set expandtab
autocmd filetype c,cpp abbreviate #i #include
autocmd filetype c,cpp abbreviate #d #define
autocmd filetype c,cpp abbreviate #e #endif
"autocmd filetype c,cpp set list | set listchars=tab:»·,trail:·
autocmd filetype c,cpp,java,go inoremap { {}<Up>o
autocmd filetype ruby setlocal shiftwidth=2
autocmd filetype help setlocal nonu
autocmd filetype html setlocal shiftwidth=2
autocmd filetype python setlocal expandtab | setlocal shiftwidth=4 | setlocal tabstop=4 | setlocal softtabstop=4
autocmd filetype tex setlocal ts=4 | setlocal sw=4 | setlocal softtabstop=4 | setlocal expandtab
autocmd filetype lua setlocal ts=2 | setlocal sw=2 | setlocal softtabstop=2 | setlocal expandtab
autocmd filetype sh setlocal ts=4 | setlocal sw=4 | setlocal softtabstop=4 | setlocal expandtab
autocmd filetype srt setlocal ts=4 | setlocal sw=4 | setlocal softtabstop=4 | setlocal expandtab
autocmd filetype vim setlocal ts=2 | setlocal sw=2 | setlocal expandtab
autocmd filetype markdown setlocal ts=2 | setlocal sw=2 | setlocal expandtab
autocmd filetype go setlocal ts=4 | setlocal sw=4 | setlocal noexpandtab
autocmd filetype go setlocal makeprg=gomake

" ----------------------------------------
" Misc.
" ----------------------------------------

" ---------------
" cscope
" ---------------
set csprg=cscope
set cscopequickfix=s-,d-,i-,t-,e-

" ---------------
" netrw
" ---------------
let g:netrw_list_hide='^\.[^.]\+'

" ---------------
" Expand current file's path
" ---------------

" learned from "Vim Tip of the day"
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/"<CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif


" ----------------------------------------
"  Goyo
"  Distraction-free writing in Vim.
" ----------------------------------------
nnoremap <Leader>G :Goyo<CR>

" ----------------------------------------
"  IndentLine
" ----------------------------------------
let g:indentLine_color_term = 239
"let g:indentLine_char = '|'

" ----------------------------------------
"  vim-airline
" ----------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='serene'

" ----------------------------------------
"  gitgutter
" ----------------------------------------
highlight SignColumn ctermbg=0

" ----------------------------------------
"  nerdtree
" ----------------------------------------
nnoremap <silent> <F7> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" -----------------
"  taglist
" -----------------
" nnoremap <silent> <F10> :TlistToggle<CR>
" let g:Tlist_Show_One_File=1
" let g:Tlist_Use_Right_Window=1
" let g:Tlist_Exit_OnlyWindow=1
" let g:Tlist_Inc_Winwidth=1

nmap <F8> :TagbarToggle<CR>

" (可选) 设置 Tagbar 窗口的宽度
let g:tagbar_width = 40

" (可选) 打开 Tagbar 后自动聚焦到 Tagbar 窗口
let g:tagbar_autofocus = 1

" ---------------
" Syntastic
" ---------------

let g:syntastic_mode_map={ 'mode': 'passive',
                         \ 'active_filetypes': ['ruby', 'python'],
                         \ 'passive_filetypes': ['c'] }

" ---------------
"  Vundle
" ---------------
nnoremap <Leader>bi :BundleInstall<CR>
nnoremap <Leader>bu :BundleUpdate<CR>
nnoremap <Leader>bc :BundleClean<CR>

" ---------------
"  SuperTab
" ---------------
" Set these up for cross-buffer completion (something Neocachecompl has a hard
" time with)
let g:SuperTabDefaultCompletionType="<c-x><c-n>"
let g:SuperTabContextDefaultCompletionType="<c-x><c-n>"



" -----------------
"  neosnippet
" -----------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" -----------------
"  tmux-color
" -----------------
if exists('$TMUX')
  set term=screen-256color
endif
"  ----------------
"  YouCompleteMe
"  ----------------
"  Plugin 'Valloric/YouCompleteMe'
syntax enable
set tags+=tags;/
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/


" 1. 设置首选工具为 rg (Ripgrep)
let g:grepper = {}
let g:grepper.tools = ['rg', 'ag']

" 2. 配置 rg 的参数 (可选，默认通常已经够用)
" --vimgrep: 输出格式适合 Vim 解析
" --smart-case: 智能大小写匹配

" 3. 设置快捷键 (非常重要，否则你需要手动输入命令)
" 这里设置 <leader>g (通常是空格+g) 启动搜索
"nnoremap <silent> <leader>g :Grepper<CR>

" 4. (可选) 自动打开 quickfix 窗口显示结果
"autocmd User Grepper copen
"nnoremap <silent> <C-[> :<C-u>Grepper -tool rg -noprompt -query <C-R>=expand("<cword>")<CR><CR>)]
"nnoremap <silent> <F9> :<C-u>Grepper -tool rg -noprompt -query <C-R>=expand("<cword>")<CR><CR>)]
"nnoremap <silent> <C-[> :<C-u>Grepper -tool rg -noprompt -query <C-R>=expand("<cword>")<CR><CR>)]
