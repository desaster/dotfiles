" Author: Upi Tamminen <desaster@>

" Todo {{{

" try airline

"}}}

" Preamble {{{
version 6.0

if version < 600
    echo "This vimrc requires vim 6.0 or higher"
    exit
endif

filetype off
call pathogen#infect()
filetype plugin indent on
set nocompatible

if has("gui_running")
    set lines=60
    set titlestring=%<%F
endif
"}}}

" Basic options {{{

" toggle on
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
set showbreak=+
set viminfo='20,\"200
set virtualedit=block
"set statusline=[%n]\ %F\ %([%Y%M%R%H%W]\ %)%=(%b,0x%B)\ c/%l\ r/%c\ %p%%
set showcmd

" bells off
set noerrorbells
set visualbell
set t_vb=

let mapleader = ","
let maplocalleader = "\\"

"}}}

" Tab settings {{{
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set textwidth=78

set colorcolumn=80
hi ColorColumn ctermbg=black guibg=#222222
"}}}

" Backups {{{
set nobackup
set nowritebackup
" set backupdir=~/.vim/tmp/backup//
" set directory=~/.vim/tmp/swap//
" set undodir=~/.vim/tmp/undo//
set noswapfile " any need for this anymore?
"}}}

" Color scheme {{{
syntax on
set background=dark

if $NOTHEME != "1"
    set t_Co=256
    let g:gruvbox_italic=0
    colorscheme gruvbox
endif

set guioptions=eg
set guifont=Consolas:h10

syn match obsoleteWhiteSpace "[ ]*$"
" syntax sync fromstart " php needed this, do we still need it?

"highlight link obsoleteWhiteSpace Error
"highlight Comment cterm=NONE ctermfg=darkcyan guifg=#00BABD
"highlight Constant cterm=NONE guifg=#BD00BD
"highlight Identifier cterm=NONE guifg=#00BABD
"highlight NonText ctermfg=red cterm=NONE guibg=black guifg=darkred
"highlight Normal guibg=black guifg=grey
"highlight Special cterm=NONE guifg=#BD0000
"highlight StatusLine ctermfg=blue ctermbg=white cterm=reverse guifg=darkblue guibg=grey gui=NONE,reverse
"highlight Visual guibg=grey guifg=black
"highlight PreProc guifg=#5255FF
"highlight Statement gui=NONE guifg=#FFFF52
"highlight Type gui=NONE guifg=#52FF52
"highlight Folded guibg=#444466 guifg=Cyan
"highlight link sqlStatement sqlSpecial
"highlight TabLineSel ctermfg=white ctermbg=blue cterm=none,bold
"highlight TabLineFill ctermfg=white ctermbg=blue cterm=none
"highlight TabLine ctermfg=white ctermbg=blue cterm=none

"}}}

" X specific stuff  {{{

" X connections only as normal user
if $USER == "root"|set notitle|else|set title|endif

" }}}

" Search and movement {{{

" move one screen line instead of real line
map j gj
map k gk
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set sidescroll=8
set gdefault

" keep search matches in the middle of the window and pulse the line when
" moving to them
nnoremap n nzzzv
nnoremap N Nzzzv

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
nnoremap <Space> za
vnoremap <Space> za

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
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

"}}}

" Filetype specific stuff {{{

"  settings for php {{{
let php_minlines = 500
let php_folding = 1
let php_parent_error_close = 1

function PHP_Syntax_Addons()
    syntax match obsoleteWhiteSpace "[ ]*$" containedin=phpRegion
    syntax match tabInsteadOfSpaces "\t" containedin=phpRegion
    highlight link tabInsteadOfSpaces Error
    highlight link obsoleteWhiteSpace Error
endfunction

if has("autocmd")
    autocmd BufReadPost,FileReadPost *.php,*.php3 syntax sync fromstart
    autocmd BufReadPost,FileReadPost *.php,*.php3 set formatoptions=tcqlr1
    autocmd BufReadPost,FileReadPost *.php,*.php3 call PHP_Syntax_Addons()
endif

"}}}

"  settings for C {{{

function FoldBrace()
  if getline(v:lnum+1)[0] == '{'
    return '>1'
  endif
  if getline(v:lnum)[0] == '}'
    return '<1'
  endif
  " return foldlevel(v:lnum-1)
  return '='
endfunction

function CFold()
  set foldexpr=FoldBrace()
  set foldmethod=expr
  "set foldmethod=indent
  set foldnestmax=1
endfunction

if has("autocmd")
    "autocmd BufReadPost,FileReadPost *.c call CFold()
    augroup cprog
	au!
	autocmd BufRead *       set formatoptions=tcql nocindent comments&
	autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
    augroup END
endif

"}}}

" }}}

" Convenience mappings {{{

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" substitute
nnoremap <leader>s :%s//<left>

" emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

inoremap <MiddleMouse> <C-O>:set paste<cr><MiddleMouse><C-O>:set nopaste<CR>
" }}}
