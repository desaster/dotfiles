" Author: Upi Tamminen <desaster@>

execute 'source ' . fnameescape(stdpath('config') . '/plugins.vim')

" https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/
" In Nvim-qt, when we press Shift+insert in insert mode, it will add a literal
" <S-Insert>, instead of the text on the system clipboard. To fix this issue,
" we can use the following mapping:
if has("win32")
    inoremap <silent>  <S-Insert>  <C-R>+
endif

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
set backspace=2
set laststatus=2
set pastetoggle=<F10>
set report=0
set selection=exclusive
set shortmess=aoOIt
set showbreak=←
set virtualedit=block
set showcmd
set wildmenu

" bells off
set noerrorbells
set visualbell
set belloff=all

set mouse=a " mouse should work even in terminal

set updatetime=4000

let mapleader = "\\"
let maplocalleader = "\\"
" this is a workaround so the leader shows up in showcmd
map <Space> <Leader>

" Show the cursorline for the focused window
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" input auto-formatting
set formatoptions=
set formatoptions+=r " continue comments by default
set formatoptions+=o " do not continue comment using o or O
set formatoptions+=j " no // comment when joining commented lines

" show line numbers
set numberwidth=3 " 3 is okay for relativenumber
set number " also shows current line number
set relativenumber

"}}}

" Indentation settings {{{

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set textwidth=78

set breakindent
set breakindentopt=shift:3

set colorcolumn=80
hi ColorColumn ctermbg=black guibg=#222222

"}}}

" Buffer / Tab settings {{{

" hide buffers instead of closing them
" Allows to change buffers with unsaved changes
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

" }}}

" Backups {{{

set nobackup
set nowritebackup
set noswapfile " any need for this anymore?

set undolevels=5000
set undofile

"}}}

" Color scheme & other style options {{{

syntax on
set background=dark

" Enable true color support
set termguicolors

let g:gruvbox_italic=0

colorscheme gruvbox

set fillchars=vert:│,fold:\
set list
set listchars=tab:→\ ,trail:·,extends:»,precedes:«,nbsp:×

"}}}

" Search and movement {{{

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

" don't move on *
nnoremap * *<c-o>

noremap H ^
noremap L g_

"}}}

" Folding {{{
set foldlevelstart=0 " start with folds closed
set foldmethod=syntax

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

" https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" mark position before search
nnoremap / ms/

"}}}
