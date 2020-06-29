" Author: Upi Tamminen <desaster@>

" Comments {{{
" Thanks: https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
"}}}

" Preamble {{{
version 6.0

if version < 600
    echo "This vimrc requires vim 6.0 or higher"
    exit
endif

filetype off

filetype plugin indent on
set nocompatible

" Add git to PATH on win32 for vim-plug
if has("win32")
    let $PATH=$PATH . ";$PATH;C:\\Program Files (x86)\\Git\\bin"
endif

"}}}

" Plugin setup {{{
"silent! call pathogen#infect()
call plug#begin('~/.vim/plugged')

"Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

Plug 'majutsushi/tagbar'

Plug 'bling/vim-airline'

Plug 'Shougo/unite.vim' | Plug 'Shougo/vimfiler.vim', { 'on': 'VimFilerExplorer' }

Plug 'tpope/vim-fugitive'

Plug 'epeli/slimux', { 'on': [ 'SendCommandToTmux', 'SlimuxShellConfigure', 'SlimuxShellLast', 'SlimuxShellRun' ] }

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

Plug 'qpkorr/vim-bufkill'

Plug 'ARM9/arm-syntax-vim'

Plug 'tomtom/tcomment_vim'

Plug 'kien/ctrlp.vim'

Plug 'haya14busa/vim-poweryank'

Plug 'PProvost/vim-ps1'

Plug 'leissa/vim-acme', { 'for': 'asm' }

Plug 'sirtaj/vim-openscad', { 'for': 'openscad' }

Plug 'leafgarland/typescript-vim'

call plug#end()

for f in split(glob('~/.vim/vimrc.d/*.vim'), '\n')
    execute 'source' f
endfor

"}}}

" Basic options {{{
scriptencoding=utf8
set encoding=utf8
set autoindent
set infercase
set joinspaces
set lazyredraw
set linebreak
set magic
set modeline
set ruler
set showcmd
set showmode
set smarttab
set splitright
set nocompatible
set backspace=2
set dictionary=/usr/dict/words
set laststatus=2
set pastetoggle=<F10>
set report=0
set selection=exclusive
set shortmess=aoOIt
set showbreak=←
set viminfo='20,\"200
set virtualedit=block
"set statusline=[%n]\ %F\ %([%Y%M%R%H%W]\ %)%=(%b,0x%B)\ c/%l\ r/%c\ %p%%
set showcmd
set wildmenu

" bells off
set noerrorbells
set visualbell
set t_vb=

set updatetime=500

let mapleader = "\\"
let maplocalleader = "\\"
" this is a workaround so the leader shows up in showcmd
map <Space> <Leader>

" Show the cursorline for the focused window
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
"}}}

" Show line numbers {{{

if version >= 703
    set numberwidth=3 " 3 is okay for relativenumber
    set number " also shows current line number
    set relativenumber
else
    set numberwidth=4
    set number
endif

" automatic approach, but doesn't really work with split windows:
"set numberwidth=5
"function _SetLineNumbers() "{{{
"    if &columns < 85
"        set nonumber
"        set norelativenumber
"    else
"        "set number
"        set relativenumber
"    endif
"endfunction "}}}

"au VimResized * call SetLineNumbers()
"call SetLineNumbers()

"}}}

" Indentation settings {{{
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set textwidth=78

" new in 8.0, but some 7.4 versions also have this
try
    set breakindent
    set breakindentopt=shift:3
catch /^Vim\%((\a\+)\)\=:E518/
    " older vim version
endtry

if version >= 703
    set colorcolumn=80
    hi ColorColumn ctermbg=black guibg=#222222
endif

"}}}

" Buffer / Tab settings {{{

" No need to :w before being allowed to switch buffers
set hidden

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer
nmap <leader>bq :bd<CR>

" List all buffers
nmap <leader>bl :ls<CR>

" new empty buffer
nmap <leader>bn :enew<CR>
"
" switch to alternate buffer
nmap <leader># :b#<CR>
"
" close the current buffer without closing split NOTE: this works sometimes
nmap <silent> <leader>d :bp\|bd #<CR>

" move to buffer n from left
nmap <leader>1 :brewind<CR>:bnext 0<CR>
nmap <leader>2 :brewind<CR>:bnext 1<CR>
nmap <leader>3 :brewind<CR>:bnext 2<CR>
nmap <leader>4 :brewind<CR>:bnext 3<CR>
nmap <leader>5 :brewind<CR>:bnext 4<CR>
nmap <leader>6 :brewind<CR>:bnext 5<CR>
nmap <leader>7 :brewind<CR>:bnext 6<CR>
nmap <leader>8 :brewind<CR>:bnext 7<CR>
nmap <leader>9 :brewind<CR>:bnext 8<CR>
nmap <leader>0 :brewind<CR>:bnext 9<CR>

" move between windows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" http://stackoverflow.com/questions/12328277/vim-remote-silent-always-opens-no-name-buffer-for-first-file
" https://paste2.org/bcjaa1Y0
" Delete empty buffers, specially for files opened with --remote option
autocmd BufAdd * :call <SID>DeleteBufferIfEmpty()
function s:DeleteBufferIfEmpty()
    if bufname('%') == ''
        bwipe
        " This will trigger filetype detection, mainly to trigger syntax highlighting
        doautocmd BufRead
    endif
endfunction

" }}}

" Backups {{{
set nobackup
set nowritebackup
" set backupdir=~/.vim/tmp/backup//
" set directory=~/.vim/tmp/swap//
set noswapfile " any need for this anymore?

if has("persistent_undo")
    set undolevels=5000
    set undofile
    if has("win32")
        set undodir=$HOME/vimfiles/tmp/undo//
    else
        set undodir=~/.vim/tmp/undo//
    endif
endif
"}}}

" Color scheme & other style options {{{
syntax on
set background=dark

if has("gui_running") && has("win32")
    set t_Co=256
endif

if $NOTHEME != "1" && &t_Co == 256
    "set t_Co=256 " let's trust this works automatically

    " hard gives a darker bg
    "let g:gruvbox_contrast="hard"

    " italic broken via putty
    "if !has("gui_running")
    "    let g:gruvbox_italic=0
    "endif
    " italic always ugly
    let g:gruvbox_italic=0

    try
        colorscheme gruvbox
    catch /E185:/
    endtry

    "let g:solarized_termcolors=256
    "let g:solarized_italic=0
    "try
    "    colorscheme solarized
    "catch /E185:/
    "endtry
endif

syn match obsoleteWhiteSpace "[ ]*$"
" syntax sync fromstart " php needed this, do we still need it?

" theme messes up colors after quit
if &shell == "/bin/bash"
    au VimLeave * silent ! echo -e "\033[0m"
endif

" utf8 pipe character
if has("multi_byte") && &encoding == "utf-8"
    set fillchars=vert:│,fold:\ 
endif
"}}}

" GUI settings {{{

set guioptions=egc

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Dejavu Sans Mono:h10
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    "set guifont=Consolas_for_Powerline_FixedD:h10:cANSI,Consolas:h10
    set guifont=Consolas:h10
    set lines=58
    set columns=83
    set titlestring=%<%F
  endif
endif

" X connections only as normal user
if $USER == "root"|set notitle|else|set title|endif

set mouse=a " mouse should work even in terminal

"}}}

" Search and movement {{{

" move one screen line instead of real line
map j gj
map k gk
set ignorecase
set smartcase
set noincsearch
set showmatch
set hlsearch
set sidescroll=8
set gdefault

" keep search matches in the middle of the window and pulse the line when
" moving to them
nnoremap n nzzzv
nnoremap N Nzzzv

" clear search matches
nmap <silent> <BS>  :nohlsearch<CR>
"nnoremap <silent> <BS> :nohlsearch<CR><BS>

" don't move on *
nnoremap * *<c-o>

noremap H ^
noremap L g_

nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

if has("autocmd")
    " When editing a file, always jump to the last cursor position
    " autocmd BufReadPost * if &filetype != "help" && line("'\"") | exe "normal '\"" | endif
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
endif
"}}}

" Folding {{{
set foldlevelstart=0 " start with folds closed
set foldmethod=marker

" open/close folds with space
"nnoremap <Space> za
"vnoremap <Space> za

" make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be
nnoremap zO zCzO

" use ,z to "focus" the current fold
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '*' . repeat(" ",fillcharcount) . foldedlinecount . '*' . ' '
endfunction " }}}
set foldtext=MyFoldText()
"}}}

" Plugin specific stuff {{{

" Unite {{{

" http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" file_rec requires vimproc
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=files -start-insert file<cr>
nnoremap <leader>e :<C-u>Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>

" }}}

" VimFiler {{{

map <F7> :VimFilerExplorer<CR>
let g:vimfiler_as_default_explorer = 1

" }}}

" Tagbar {{{
" also see "updatetime" setting, which is useful with tagbar
map <F8> :TagbarToggle<CR>
" let g:tagbar_autoclose = 1
" let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
" }}}

" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" eye candy
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_symbols = {}
"let g:airline_left_sep = "\u2b80" "use double quotes here
"let g:airline_left_alt_sep = "\u2b81"
"let g:airline_right_sep = "\u2b82"
"let g:airline_right_alt_sep = "\u2b83"
"let g:airline_symbols.branch = "\u2b60"
"let g:airline_symbols.readonly = "\u2b64"
"let g:airline_symbols.linenr = "\u2b61"
"let g:airline#extensions#tabline#left_sep = "\u2b80"

" less eye candy
let g:airline_symbols = {}
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_alt_sep='|'
let g:airline_symbols.branch = ""
let g:airline_symbols.readonly = ""
let g:airline_symbols.linenr = ""
let g:airline#extensions#tabline#left_sep = ""
let g:airline_powerline_fonts = 0

" this apparently causes lag
let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#branch#enabled = 0

"}}}

" slimux / tmux integration {{{

let g:tmuxcmd = ""

function SendCommandToTmux(...) " {{{
    if g:tmuxcmd == ""
        call ResetTmuxCommand()
    end

    let cmd = g:tmuxcmd
    if a:0 > 0 && strlen(a:1) > 0
        let cmd .= " " . a:1
    endif
    let cmd .= "\n"

    call SendToTmux(cmd)
endfunction " }}}

map <leader>Ts :SlimuxShellConfigure<CR>
nmap <silent> <F5> :SlimuxShellLast<CR>

" for running apt-get removes
nmap <F2> "zyiW:execute "SlimuxShellRun " . @z<CR>
"nmap <F3> "zyiW:echo @z<CR>

" }}}

" ctrlp {{{
let g:ctrlp_by_filename = 1
" }}}

" completion {{{
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
endif


" }}}

"}}}

" Filetype specific stuff {{{
"
" (most of the filesystem specific stuff is now in ~/.vim/ftplugin/)
"

"  settings for VB {{{

if has("autocmd")
    autocmd BufReadPost,FileReadPost *.vb set ft=vb
endif
"}}}

"}}}

" Convenience mappings {{{

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" substitute
nnoremap <leader>s :%s//<left>

" emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

inoremap <MiddleMouse> <C-O>:set paste<cr><MiddleMouse><C-O>:set nopaste<CR>

" save via sudo
if !has("win32")
    cmap w!! w !sudo tee > /dev/null %
endif

" toggle syntax highlighting

"function ToggleSyntax() "{{{
"    if exists("g:syntax_on")
"        syntax off
"    else
"        syntax enable
"    endif
"endfunction
"
"map <leader>s :call ToggleSyntax()<CR>


" https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

"}}}

" Final tasks {{{

" Include local vimrc, if exists

if has("win32")
    if !empty(glob("~/_vimrc_local"))
        source ~/_vimrc_local
    endif
else
    if !empty(glob("~/.vimrc_local"))
       source ~/.vimrc_local
    endif
endif

"}}}
