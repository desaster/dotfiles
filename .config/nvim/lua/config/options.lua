-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g = vim.g -- global variables
local opt = vim.opt -- editor options

opt.infercase = true
opt.joinspaces = true
-- apparently this is only meant to be used temporarily
-- opt.lazyredraw = true
opt.showmode = true
opt.report = 0
opt.selection = 'exclusive'
opt.showbreak = '←'

-- don't continue comment when inserting new line with 'o' or Enter
opt.formatoptions:remove { 'r', 'o' }
-- ftplugin/typescript.vim resets this setting, so let's do this ugly hack.
-- To find out what it was that last modified the option, use:
-- :verb set formatoptions
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        opt.formatoptions:remove { 'r', 'o' }
    end,
})

opt.updatetime = 300

opt.numberwidth = 3 -- leave room for 3 digits by default
opt.number = true -- traditional, also adds current line number to relative numbering
opt.relativenumber = true -- relative for easy jumping around

opt.showmode = false -- disable mode in command line, it's already in statusline

-- indentation
opt.tabstop = 8 -- real tab is always 8, if you want something else, use spaces
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.textwidth = 78
opt.breakindent = true
opt.breakindentopt = 'shift:3'
opt.colorcolumn = '80'

-- backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- undo
opt.undolevels = 10000
opt.undofile = true

-- symbols
opt.fillchars = {
    vert = '│', -- vertical separator in splits, etc
}

opt.list = true -- Show some invisible characters (tabs...
opt.listchars = {
    tab = '→ ',     -- actual tabs
    trail = '·',    -- trailing spaces
    extends = '»',  -- concealed text right
    precedes = '«', -- concealed text left
    nbsp = '×'      -- non-breakable space character (0xA0 (160 decimal) and U+202F)
}

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = false
opt.showmatch = true
opt.hlsearch = true
opt.sidescroll = 8
--opt.scrolloff = 8
opt.gdefault = true -- default to s/fdsf/fdsf/g

-- disable spell checking by default, since it's usually the wrong language
-- and annoys more than helps
-- to enable, :set spell and :set spelllang=fi (or whatever language)
opt.spell = false

-- Disable confirm to save changes, since I'm not used to it
opt.confirm = false

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false

-- Disable LazyVim autoformatting globally
vim.g.autoformat = false

vim.g.trouble_lualine = true

-- disable animations as they are slow and annoying
vim.g.snacks_animate = false

-- don't use cmp (or blink) for ai suggestions
vim.g.ai_cmp = false

-- unnamedplus seems convenient, but in practice it gets in the way too much
opt.clipboard:remove("unnamedplus")
