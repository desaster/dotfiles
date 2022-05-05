local jdtls_jar = vim.env.JDTLS_JAR
local jdtls_config = vim.env.JDTLS_CONFIG

-- export JDTLS_CONFIG="$HOME/neovim/jdtls/config_linux/"
-- export JDTLS_JAR="$HOME/neovim/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

-- ensure we were given path to the jdtls JAR file
if (vim.fn.empty(vim.env.JDTLS_JAR) > 0 or
        vim.fn.filereadable(vim.env.JDTLS_JAR) ~= 1) then
    print('jdtls jar not found JDTLS_JAR')
    return
end

-- ensure we were given path to the jdtls config directory
if (vim.fn.empty(vim.env.JDTLS_CONFIG) > 0 or
        vim.fn.isdirectory(vim.env.JDTLS_CONFIG) ~= 1) then
    print('jdtls config directory not found JDTLS_CONFIG')
    return
end

-- ensure we can figure out te neovim cace directory (this should never fail)
if (vim.fn.empty(vim.fn.stdpath('cache')) > 0 or
        vim.fn.isdirectory(vim.fn.stdpath('cache')) ~= 1) then
    print('neovim cache directory not found ' .. vim.fn.stdpath('cache'))
    return
end

-- create the base directory for all workspaces
local ws_dir = vim.fn.stdpath('cache') .. '/jdtls-workspaces/'
if vim.fn.isdirectory(ws_dir) ~= 1 then
    vim.fn.mkdir(ws_dir, '')
end

-- and create this one specific workspace directory
local jdtls_workspace = ws_dir .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
if vim.fn.isdirectory(jdtls_workspace) ~= 1 then
    vim.fn.mkdir(jdtls_workspace, '')
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        'java', -- or '/path/to/java11_or_newer/bin/java'
                -- depends on if `java` is in your $PATH env variable and if it points to the right version.
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_jar,
        '-configuration', jdtls_config,
        -- See `data directory configuration` section in the README
        '-data', jdtls_workspace
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
        }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },

    on_attach = function(client, bufnr)
        -- using null-ls for formatting...
        --client.resolved_capabilities.document_formatting = false
        --client.resolved_capabilities.document_range_formatting = false

        require("jdtls.setup").add_commands()
        --require("jdtls").setup_dap({ hotcodereplace = "auto" })
        --require("hb/lsp/keymap").setup_lsp_keymaps(client, bufnr)

        require('mappings').setup_lsp_keymaps(client, bufnr)
        -- TODO: add extra keybindings from https://github.com/mfussenegger/nvim-jdtls#usage
    end
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
