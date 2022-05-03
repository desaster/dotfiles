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

-- fuzzy finder (see mappings.lua)
use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope', -- lazy-load
    config = get_config('telescope')
}

-- delete buffers without messing up window layout (see mappings.lua)
use 'famiu/bufdelete.nvim'

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
    'neovim/nvim-lspconfig',
    requires = {
        -- easy way to install lsp servers to data/nvim/lsp_servers/
        'williamboman/nvim-lsp-installer',
        -- diagnostics messages from eslint
        'jose-elias-alvarez/null-ls.nvim',
        -- progress thingie
        'j-hui/fidget.nvim';
    },
    config = get_config('lsp')
})

-- colorize hex codes
use({
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = get_config('colorizer'),
 })

-- vim: set sw=4 et:
