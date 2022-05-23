local packer = require('packer')
local use = packer.use

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local get_config = function (name)
    return string.format('require("config/%s")', name)
end

-- Package manager
use {
    'smhc/packer.nvim',
    branch = 'snapshot_load'
}

-- EditorConfig support
use { 'gpanders/editorconfig.nvim' }

-- Theme
use {
    'sainnhe/gruvbox-material',
    config = get_config('colorscheme')
}

-- Fancy statusline
use({
    'nvim-lualine/lualine.nvim',
    config = get_config('lualine'),
    event = 'VimEnter'
})

-- Better syntax highlighting, or something
use({
    'nvim-treesitter/nvim-treesitter',
    config = get_config('treesitter'),
    run = ':TSUpdate'
})

-- Comment out stuff with gc, gcc etc https://github.com/numToStr/Comment.nvim#-usage
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

-- show indentation guides on blank lines
use {
    'lukas-reineke/indent-blankline.nvim',
    config = get_config('indent')
}

-- fuzzy finder (see mappings.lua)
use {
    'nvim-telescope/telescope.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-file-browser.nvim"
    },
    cmd = 'Telescope', -- lazy-load
    config = get_config('telescope')
}

-- delete buffers without messing up window layout (see mappings.lua)
-- TODO: sometimes just throws a bunch of errors
use 'famiu/bufdelete.nvim'


-- terminal window toggling solution
use {
    'akinsho/toggleterm.nvim',
    config = get_config('toggleterm')
}

-- sigh, completion
use { 'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
    },
    config = get_config('cmp'),
}

-- language server support
use({
    -- quickstart configurations for the Nvim LSP client.
    'neovim/nvim-lspconfig',
    requires = {
        -- easy way to install lsp servers to data/nvim/lsp_servers/
        'williamboman/nvim-lsp-installer',
        -- progress thingie
        'j-hui/fidget.nvim';
    },
    config = get_config('lsp')
})

-- java, doesn't use lspconfig, see ftplugin/java.lua
use 'mfussenegger/nvim-jdtls'

-- colorize hex codes
use({
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = get_config('colorizer'),
})

-- Things to try in the future:

-- https://github.com/stevearc/dressing.nvim
-- I think this lets us move stuff like code actions to a neat select dropdown

-- vim: set sw=4 et:
