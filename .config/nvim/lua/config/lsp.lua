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

local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
    return
end

local mason_null_ls_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_ok then
    return
end

local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
    -- progress
    fidget.setup {}
end

-- do something on lsp attach
local function on_attach(client, bufnr)
    require('mappings').setup_lsp_keymaps(client, bufnr)
end

-- TODO: maybe local override for this
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- eslint = {},
    tsserver = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                -- seems like this shouldn't be global,
                -- but then again we only use lua for nvim
                globals = { 'vim' }
            }
        },
    },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- TODO: stuff should appear in ~/.local/share/nvim/ where?
mason.setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- TODO: read this list from somewhere, and allow it to be overwritten locally
mason_null_ls.setup({
    ensure_installed = {
        'prettierd',
        'eslint_d'
    },
    automatic_installation = false,
    automatic_setup = false,
})

local command_resolver = require("null-ls.helpers.command_resolver")

mason_null_ls.setup_handlers({
    -- default handler, acts like auto setup
    function(source_name, methods)
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    prettierd = function()
      null_ls.register(null_ls.builtins.formatting.prettier.with({
        disabled_filetypes = { "html.handlebars", "json" }
      }))
    end,
    eslint_d = function(source_name, methods)
        -- found this here https://github.com/mattdonnelly/dotfiles/blob/master/config/nvim/lua/user/plugins/lsp/null_ls.lua#L48
        -- maybe it helps with errors?
        local opts = {
          dynamic_command = command_resolver.from_node_modules(),
        }
        -- null_ls.register(null_ls.builtins.formatting.eslint_d).with(opts)
        null_ls.register(null_ls.builtins.diagnostics.eslint_d.with(opts))
        null_ls.register(null_ls.builtins.code_actions.eslint_d.with(opts))
    end,
})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier
    }
})

--
-- NOTE: for java config, look in ftplugin/java.lua
--

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
