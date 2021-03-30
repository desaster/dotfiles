" Plugins {{{

let g:myvimrc_enable_coc=1
let g:myvimrc_enable_vim_lsp=0

call plug#begin(stdpath('data') . '/plugged')

" some sensible defaults
Plug 'tpope/vim-sensible'

" comment with gc
Plug 'tpope/vim-commentary'

" scrolloff as a fraction of window height
Plug 'drzel/vim-scrolloff-fraction'

" ability to close all hidden buffers, etc
Plug 'Asheq/close-buffers.vim'

" retro color scheme
Plug 'morhetz/gruvbox'

"Plug 'majutsushi/tagbar'

" potentially lighter alternative to airline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

"Plug 'kien/ctrlp.vim'
" plugin that works with lists, can implement some ctrlp functionality
Plug 'Shougo/denite.nvim', { 'commit': '4bf092244dac9c8d21e22039979fa3afe240e5c5' }

" provide two options for lsp, coc and vim-lsp
if g:myvimrc_enable_coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
elseif g:myvimrc_enable_vim_lsp
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'ryanolsonx/vim-lsp-typescript'
endif

" support .editorconfig
Plug 'sgur/vim-editorconfig'

" typescript syntax support
Plug 'HerringtonDarkholme/yats'

" remember the last position in file after re-launching vim
Plug 'farmergreg/vim-lastplace'

call plug#end()

"}}}

" close-buffers {{{

nnoremap <silent> <C-q> :Bdelete menu<CR>

"}}}

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

let g:lightline.tabline          = {'left': [['buffers']], 'right': []}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#shorten_path = 1 " don't show full path in bufferline
let g:lightline#bufferline#filename_modifier = ':t' " only show filename in bufferline
let g:lightline#bufferline#unnamed = '[No Name]' " default is *
let g:lightline#bufferline#show_number = 2 " show buffer number for quick switching
set showtabline=2

" use ordinal numbers in bufferline
nmap <leader>1 <Plug>lightline#bufferline#go(1)
nmap <leader>2 <Plug>lightline#bufferline#go(2)
nmap <leader>3 <Plug>lightline#bufferline#go(3)
nmap <leader>4 <Plug>lightline#bufferline#go(4)
nmap <leader>5 <Plug>lightline#bufferline#go(5)
nmap <leader>6 <Plug>lightline#bufferline#go(6)
nmap <leader>7 <Plug>lightline#bufferline#go(7)
nmap <leader>8 <Plug>lightline#bufferline#go(8)
nmap <leader>9 <Plug>lightline#bufferline#go(9)
nmap <leader>0 <Plug>lightline#bufferline#go(10)

"}}}

" Plugin setup from other files {{{

execute 'source ' . fnameescape(stdpath('config') . '/denite.vim')

if g:myvimrc_enable_coc
    execute 'source ' . fnameescape(stdpath('config') . '/coc.vim')
endif

if g:myvimrc_enable_vim_lsp
    execute 'source ' . fnameescape(stdpath('config') . '/vim-lsp.vim')
endif

"}}}
