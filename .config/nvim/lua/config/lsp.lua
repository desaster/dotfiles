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

-- progress thingie
local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
    fidget.setup {
        sources = {
            ['null-ls'] = {
                -- disable until https://github.com/j-hui/fidget.nvim/issues/122
                ignore = true
            }
        }
    }
end

-- neodev development plugin
-- https://github.com/folke/neodev.nvim#-setup
local neodev_ok, neodev = pcall(require, 'neodev')
if neodev_ok then
    neodev.setup({})
end

-- do something on lsp attach
local function on_attach(client, bufnr)
    require('mappings').setup_lsp_keymaps(client, bufnr)
end

-- list of servers with settings, etc
local servers = require('lsp-servers')

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason.setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

-- Generate a list of servers for the ensure_installed option.
-- This allows some servers to specify ensure_installed = false
local get_ensure_installed = function(servertbl)
    local ensure_installed = {}
    for i, v in pairs(servertbl) do
        if (v.ensure_installed == nil or v.ensure_installed == true) then
            table.insert(ensure_installed, i)
        end
    end
    return ensure_installed
end

mason_lspconfig.setup {
    automatic_installation = true,
    ensure_installed = get_ensure_installed(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        local opts = {
            capabilities = capabilities,
            -- allow servers table to override on_attach
            on_attach = (servers[server_name] ~= nil and servers[server_name].on_attach ~= nil) and
                function (server, bufnr)
                    return servers[server_name].on_attach(server, bufnr, on_attach)
                end or
                on_attach,
            -- settings are optional
            settings = (servers[server_name] ~= nil and servers[server_name].settings ~= nil) and
                servers[server_name].settings or
                {},
        }
        -- servers table may optionally set cmd
        if (servers[server_name] ~= nil and servers[server_name].cmd ~= nil) then
            opts.cmd = servers[server_name].cmd
        end
        lspconfig[server_name].setup(opts)
    end,
}

local command_resolver = require("null-ls.helpers.command_resolver")

-- TODO: read this list from somewhere, just like with lsp servers
mason_null_ls.setup({
    ensure_installed = {
        'prettierd',
        'eslint_d',
        'jq',
    },

    -- Run `require("null-ls").setup`.
    -- Will automatically install masons tools based on selected sources in `null-ls`.
    -- Can also be an exclusion list.
    -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
    automatic_installation = false,

    -- Whether sources that are installed in mason should be automatically set up in null-ls.
    -- Removes the need to set up null-ls manually.
    -- Can either be:
    --  - false: Null-ls is not automatically registered.
    --  - true: Null-ls is automatically registered.
    --  - { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
    --  Ex: { types = { eslint_d = {'formatting'} } }
    automatic_setup = false,

    handlers = {
        -- default handler, acts like auto setup
        function(source_name, methods)
            -- all sources with no handler get passed here
            require('mason-null-ls.automatic_setup')(source_name, methods)
        end,
        prettierd = function()
            null_ls.register(null_ls.builtins.formatting.prettierd.with({
                filetypes = {
                    "typescript",
                    "typescriptreact",
                    "javascript",
                    "javascriptreact"
                },
                --- resolver that searches for a local node_modules executable and falls back to a global executable
                -- TODO: is this already used by default?
                dynamic_command = command_resolver.from_node_modules(),
            }))
        end,
        eslint_d = function()
            -- found this here https://github.com/mattdonnelly/dotfiles/blob/master/config/nvim/lua/user/plugins/lsp/null_ls.lua#L48
            -- maybe it helps with errors?
            local opts = {
                --- resolver that searches for a local node_modules executable and falls back to a global executable
              dynamic_command = command_resolver.from_node_modules(),
            }
            null_ls.register(null_ls.builtins.diagnostics.eslint_d.with(opts))
            null_ls.register(null_ls.builtins.code_actions.eslint_d.with(opts))
        end,
        jq = function()
           null_ls.register(null_ls.builtins.formatting.jq)
        end
    }
})

null_ls.setup({
    on_attach = on_attach,
    debug = false,
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
