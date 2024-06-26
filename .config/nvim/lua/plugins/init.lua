return {

    -- Theme
    {
        'sainnhe/gruvbox-material',
        config = function() require('config/colorscheme') end,
    },

    -- Fancy statusline
    {
        'nvim-lualine/lualine.nvim',
        config = function() require('config/lualine') end,
        event = 'VimEnter',
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false, -- Lazy loading is not recommended.
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function() require('config/nvim-tree') end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function() require('config/treesitter') end,
    },

    -- Comment out stuff with gc, gcc etc https://github.com/numToStr/Comment.nvim#-usage
    {
        'numToStr/Comment.nvim',
        config = function() require('config/comment') end,
    },

    -- show indentation guides on blank lines
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function() require('config/indent') end,
    },

    -- fuzzy finder (see mappings.lua)
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        -- TODO cmd = 'Telescope', -- lazy-load
        config = function() require('config/telescope') end,
    },

    -- delete buffers without messing up window layout (see Bdelete in mappings.lua)
    -- TODO: sometimes just throws a bunch of errors
    {
        'ojroques/nvim-bufdel',
        config = function() require('config/nvim-bufdel') end,
    },

    -- terminal window toggling solution
    {
        'akinsho/toggleterm.nvim',
        config = function() require('config/toggleterm') end,
    },

    -- sigh, completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function() require('config/cmp') end,
    },

    -- language server support
    -- NOTE: `git init` so project root is recognized
    --
    -- TODO: before upgrading packages, check out
    -- https://github.com/williamboman/mason.nvim/issues/1090#issuecomment-1478113100
    {
        -- quickstart configurations for the Nvim LSP client.
        'neovim/nvim-lspconfig',
        dependencies = {
            -- easy way to install lsp servers, :checkhealth mason
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Allow use of prettierd, eslint_d
            'nvimtools/none-ls.nvim',
            'nvimtools/none-ls-extras.nvim',
            'jay-babu/mason-null-ls.nvim',

            -- progress thingie
            -- NOTE: needs tsconfig.json for ts to work
            {
                'j-hui/fidget.nvim'
            },

            -- neovim lua stuff, needs to be setup before lspconfig
            'folke/neodev.nvim',
        },
        config = function() require('config/lsp') end,
    },

    -- java, doesn't use lspconfig, see ftplugin/java.lua
    { 'mfussenegger/nvim-jdtls' },

    -- GitHub co-pilot
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function() require('config/copilot') end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = false, -- Enable debugging
            -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
        -- TODO: add config file
    },

    -- colorize hex codes #dadada
    {
        'brenoprata10/nvim-highlight-colors',
        config = function() require('config/nvim-highlight-colors') end,
    }
}

-- Things to try in the future:

-- https://github.com/stevearc/dressing.nvim
-- I think this lets us move stuff like code actions to a neat select dropdown

-- https://github.com/kosayoda/nvim-lightbulb
-- Show lightbulb if there are code actions available

-- vim: set sw=4 et:
