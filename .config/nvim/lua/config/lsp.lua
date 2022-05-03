local lspconfig = require('lspconfig')

-- null-ls will magically enable diagnostics messages from eslint
-- (except when it doesn't)
--require("null-ls").setup({
--    sources = {
--        require("null-ls").builtins.formatting.stylua,
--        require("null-ls").builtins.diagnostics.eslint,
--        require("null-ls").builtins.completion.spell,
--    },
--})

-- progress
require"fidget".setup{}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- do something on lsp attach
local function on_attach(client, bufnr)

    -- set mappings only in current buffer with lsp enabled
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- set options only in current buffer with lsp enabled
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- TODO: what is omnifunc?
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }

    -- TODO: pressing K twice jumps into the hover window :(
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)

    -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
    --buf_set_keymap('n', '<F12>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<F12>', '<cmd>Telescope lsp_definitions<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

    -- Goto the implementation of the word under the cursor if there's only
    -- one, otherwise show all options in Telescope
    --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    -- Lists LSP references for word under the cursor
    --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

    -- code actions (e.g. add import)
    buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
    --buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- Goto the definition of the type of the word under the cursor, if
    -- there's only one, otherwise show all options in Telescope
    --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    -- workspace folders, do I want this stuff?
    --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    -- rename (refactor) symbol
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

    -- popup current diagnostics (e.g. an error)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(nil, { focus=false, scope="cursor" })<CR>', opts)

    -- jump to next diagnostic (e.g. an error)
    buf_set_keymap('n', '<F8>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<S-F8>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)

    -- disable formatting in favour of eslint formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

require('nvim-lsp-installer').setup {
    -- stuff should appear in ~/.local/share/nvim/lsp_servers/
    -- status can be seen in :LspInstallInfo
    automatic_installation = true
}

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- seems like this shouldn't be global,
                -- but then again we only use lua for nvim
                globals = { 'vim' }
            }
        }
    }
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.eslint.setup {
    capabilities = capabilities
}

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#customizing-how-diagnostics-are-displayed
vim.diagnostic.config({
    -- disable virtual text, it often doesn't fit anyway
    virtual_text = false,

    -- default is false, update diagnostics in insert mode
    update_in_insert = true,

    float = {
        -- nice to know if message is from eslint or tsserver
        source = "always"
    },
})

-- Show line diagnostics automatically in hover window
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-line-diagnostics-automatically-in-hover-window
--vim.o.updatetime = 500
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus=false, scope="cursor" })]]

-- TODO
-- https://www.reddit.com/r/neovim/comments/nrz9hp/can_i_close_all_floating_windows_without_closing/h0lg5m1/
-- often the floating diagnostics or completion window just gets in the way,
-- and is really hard to close due to bugs - maybe we need some shortcut to
-- force close?
-- or maybe we'll add some mapping and learn to use it
