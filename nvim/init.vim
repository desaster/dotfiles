" Author: Upi Tamminen <desaster@>

" Comments {{{
" Thanks: https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
"}}}

" Preamble {{{

filetype off
filetype plugin indent on

"}}}

" Plugin setup {{{
"
"silent! call pathogen#infect()
call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'

"Plug 'majutsushi/tagbar'

Plug 'itchyny/lightline.vim'

"Plug 'kien/ctrlp.vim'
Plug 'Shougo/denite.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'sgur/vim-editorconfig'

Plug 'HerringtonDarkholme/yats'

call plug#end()

"}}}

" NeoVim weirdness {{{

" https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/
"In Nvim-qt, when we press Shift+insert in insert mode, it will add a literal
"<S-Insert>, instead of the text on the system clipboard. To fix this issue,
"we can use the following mapping:

inoremap <silent>  <S-Insert>  <C-R>+

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
set laststatus=2
set pastetoggle=<F10>
set report=0
set selection=exclusive
set shortmess=aoOIt
set showbreak=←
set viminfo='20,\"200
set virtualedit=block
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

if has("persistent_undo")
    set undolevels=5000
    set undofile
    if has("win32")
        " TODO how to point to some neovim path?
        set undodir=$HOME/vimfiles/tmp/undo//
    else
        set undodir=~/.vim/tmp/undo//
    endif
endif
"}}}

" Color scheme & other style options {{{

syntax on
set background=dark

let g:gruvbox_italic=0

colorscheme gruvbox

" utf8 pipe character
if has("multi_byte") && &encoding == "utf-8"
    set fillchars=vert:│,fold:\
    set listchars=tab:→\ ,trail:·,extends:»,precedes:«,nbsp:×
    " this is aa rwappersd lanie"a rwappersd lanie"a rwappersd lanie"a rwappersd lanie"a rwappersd lanie"a rwappersd lanie" rwappersd lanie"
endif

"}}}

" GUI settings {{{

"if has("gui_gtk2")
"    set guifont=Dejavu Sans Mono:h10
"elseif has("gui_macvim")
"    set guifont=Menlo\ Regular:h14
"elseif has("win32")
"    "set guifont=Consolas_for_Powerline_FixedD:h10:cANSI,Consolas:h10
"    set guifont=Consolas:h10
"    set lines=58
"    set columns=83
"    set titlestring=%<%F
"endif

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

" vim-lightline {{{

" https://github.com/neoclide/coc.nvim/wiki/Statusline-integration

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" TODO: show errors/warnings of cocstatus a more outstanding way

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

"}}}

" ctrlp {{{
let g:ctrlp_by_filename = 1
" }}}

" Denite {{{

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

"}}}

" coc {{{

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-tslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" To make completion works like VSCode https://github.com/neoclide/coc-snippets/issues/5
"inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
"let g:coc_snippet_next = '<TAB>'
"let g:coc_snippet_prev = '<S-TAB>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



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

" https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

"}}}
