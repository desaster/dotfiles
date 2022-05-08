vim.o.termguicolors = true
vim.g.gruvbox_material_background = 'hard'

local colorscheme = 'gruvbox-material'

-- abort if colorscheme is not (yet) installed
local ok, result = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
    return
end

function SetupSignColumn()
    -- clear the background color from signcolumn so it looks the same as line
    -- numbers
    vim.cmd[[highlight clear SignColumn]]
    vim.cmd[[highlight clear RedSign]]
    vim.cmd[[highlight RedSign ctermfg=167 guifg=#ea6962]]
    vim.cmd[[highlight clear YellowSign]]
    vim.cmd[[highlight YellowSign ctermfg=214 guifg=#d8a657]]
    vim.cmd[[highlight clear AquaSign]]
    vim.cmd[[highlight AquaSign ctermfg=108 guifg=#32302f]]
    vim.cmd[[highlight clear BlueSign]]
    vim.cmd[[highlight BlueSign ctermfg=109 guifg=#32302f]]

    -- also undercurl, which is supported by some terminals sometimes
    vim.cmd[[highlight LspDiagnosticsUnderlineError cterm=undercurl gui=undercurl]]
    vim.cmd[[highlight LspDiagnosticsUnderlineHint cterm=undercurl gui=undercurl]]
    vim.cmd[[highlight LspDiagnosticsUnderlineInformation cterm=undercurl gui=undercurl]]
    vim.cmd[[highlight LspDiagnosticsUnderlineWarning cterm=undercurl gui=undercurl]]

    -- highlight line numbers instead of having sign column
    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-line-number-instead-of-having-icons-in-sign-column
    vim.cmd[[highlight! DiagnosticLineNrError guifg=#ea6962 gui=bold]]
    vim.cmd[[highlight! DiagnosticLineNrWarn guifg=#d8a657 gui=bold]]
    vim.cmd[[highlight! DiagnosticLineNrInfo guifg=#32302f gui=bold]]
    vim.cmd[[highlight! DiagnosticLineNrHint guifg=#7daea3 gui=bold]]

    vim.cmd[[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError]]
    vim.cmd[[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn]]
    vim.cmd[[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo]]
    vim.cmd[[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint]]
end

vim.cmd[[au VimEnter * lua SetupSignColumn()]]
