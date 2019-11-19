" Plugins {{{

call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'

"Plug 'majutsushi/tagbar'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

"Plug 'kien/ctrlp.vim'
Plug 'Shougo/denite.nvim', { 'commit': '671da21f020445cf86836b5387000e0826f1b16e' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'sgur/vim-editorconfig'

Plug 'HerringtonDarkholme/yats'

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
execute 'source ' . fnameescape(stdpath('config') . '/coc.vim')

"}}}
