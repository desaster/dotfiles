" Plugins {{{

let g:myvimrc_enable_coc=0
let g:myvimrc_enable_vim_lsp=1

call plug#begin(stdpath('data') . '/plugged')

" some sensible defaults
Plug 'tpope/vim-sensible'

" retro color scheme
Plug 'morhetz/gruvbox'

"Plug 'majutsushi/tagbar'

" potentially lighter alternative to airline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

"Plug 'kien/ctrlp.vim'
" plugin that works with lists, can implement some ctrlp functionality
Plug 'Shougo/denite.nvim', { 'commit': '671da21f020445cf86836b5387000e0826f1b16e' }

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

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
set showtabline=2

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
