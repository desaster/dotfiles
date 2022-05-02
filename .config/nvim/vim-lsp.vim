set signcolumn=yes

let g:asyncomplete_auto_popup = 1 " disable this if typing gets too painful
let g:lsp_signs_enabled = 1 " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " show message when cursor is above a hint
let g:lsp_highlight_references_enabled = 1 " highlight symbol under cursor elsewhere in the document
let g:lsp_textprop_enabled = 1 " no idea if this does anything
let g:lsp_virtual_text_enabled = 0 " shows diagnostics texts next to the code

let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '✓'}
let g:lsp_signs_information = {'text' : 'ℹ'}

" setup lsp folding only for specific filetype(s)
augroup lsp_folding
  autocmd!
  autocmd FileType typescript setlocal
      \ foldmethod=expr
      \ foldexpr=lsp#ui#vim#folding#foldexpr()
      \ foldtext=lsp#ui#vim#folding#foldtext()
augroup end

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" check if there's a whitespace to the left of cursor
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:lspSetting() abort
    nmap <buffer> ga        <plug>(lsp-code-action)
    nmap <buffer> <leader>ac <Plug>(lsp-code-action)
    nmap <buffer> gd        <plug>(lsp-definition)
    nmap <buffer> gD        <plug>(lsp-peek-definition)
    nmap <buffer> K         <Plug>(lsp-hover)
    nmap <buffer> gr        <Plug>(lsp-references)
    nmap <buffer> gq        <Plug>(lsp-document-format)
    xmap <buffer> gq        <Plug>(lsp-document-format)
    nmap <buffer> <F9>      :call Lspdiagnostics()<CR>
    nmap <buffer> ]r        <Plug>(lsp-next-reference)
    nmap <buffer> [r        <Plug>(lsp-previous-reference)
    nmap <buffer> <F8>      <plug>(lsp-next-error)
    nmap <buffer> <S-F8>    <plug>(lsp-previous-error)
    nmap <buffer> <F2>      <plug>(lsp-rename)
    nmap <buffer> gR        <plug>(lsp-rename)
    nmap <buffer> gC        <plug>(lsp-document-diagnostics)

    setlocal omnifunc=lsp#complete
endfunction

autocmd mygroup FileType typescript call s:lspSetting()

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <buffer> ga     <plug>(lsp-code-action)
"nmap <buffer> <c-]>  <plug>(lsp-declaration)
"nmap <buffer> g<c-]> <plug>(lsp-peek-declaration)
"nmap <buffer> gd     <plug>(lsp-definition)
"nmap <buffer> gD     <plug>(lsp-peek-definition)
"nmap <buffer> go     <plug>(lsp-document-symbol)
"nmap <buffer> K      <plug>(lsp-hover)
"nmap <buffer> <c-n>  <plug>(lsp-next-error)
"nmap <buffer> <c-p>  <plug>(lsp-previous-error)
"nmap <buffer> gr     <plug>(lsp-references)
"nmap <buffer> gR     <plug>(lsp-rename)
"nmap <buffer> gS     <plug>(lsp-workspace-symbol)

hi! link LspErrorHighlight MyLspErrorHighlight
augroup LspHighlight
  autocmd!

  autocmd InsertEnter * highlight link LspErrorHighlight NONE
  autocmd InsertLeave * highlight link LspErrorHighlight MyLspErrorHighlight
augroup END

" for some reason, the undercurl stuff doesn't get set in terminal without
" delaying it
function! s:setupLspColors()
    hi! clear SignColumn
    hi! MyLspErrorHighlight cterm=undercurl gui=undercurl guisp=#fb4934
    " TODO: different colors for hints/warnings
    hi! LspWarningHighlight cterm=undercurl gui=undercurl guisp=#fabd2f
    hi! LspHintHighlight cterm=undercurl gui=undercurl guisp=#fabd2f

    hi! LspErrorText ctermfg=167 guifg=#fb4934
    hi! LspHintText ctermfg=214 guifg=#fabd2f
    if g:lsp_virtual_text_enabled
        hi! LspErrorText gui=italic
        hi! LspHintText gui=italic
    endif
endfunction

"hi! link LspWarningHighlight SpellRare
"hi! link LspHintHighlight SpellCap

autocmd mygroup VimEnter * call s:setupLspColors()
