local lspconfig = require('lspconfig')

-- null-ls will magically enable diagnostics messages from eslint
require('null-ls').setup {}

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

    -- highlight current diagnostics (e.g. an error)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

    -- jump to next diagnostic (e.g. an error)
    buf_set_keymap('n', '<F8>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<S-F8>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)

    -- disable formatting in favour of eslint formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

require('nvim-lsp-installer').setup {
    automatic_installation = true -- TODO: this doesn't work
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

vim.diagnostic.config({
  virtual_text = false, -- disable virtual text, it often doesn't fit anyway
  float = {
    --source = "always", -- TODO: could be nice with shorter source strings
  },
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
