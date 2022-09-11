local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
    return
end

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
    return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
    return
end

local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
    -- progress
    fidget.setup{}
end


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- do something on lsp attach
local function on_attach(client, bufnr)
    require('mappings').setup_lsp_keymaps(client, bufnr)
end

-- TODO: stuff should appear in ~/.local/share/nvim/ where?
mason.setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }

    -- TODO: disable automatic installation of ccls and svls
}

mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua" },
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

--
-- NOTE: for java config, look in ftplugin/java.lua
--

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.eslint.setup {
    capabilities = capabilities
}

lspconfig.ccls.setup {
    filetypes = { "c", "cpp" },
    on_attach = on_attach,
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
