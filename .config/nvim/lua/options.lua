-- shortcuts
local g = vim.g -- global variables
local opt = vim.opt -- editor options

-- TODO: add comments

-- hide buffers instead of closing them, allows changing buffers with unsaved changes
opt.hidden = true
opt.infercase = true
opt.joinspaces = true
opt.lazyredraw = true -- do not redraw screen while running macros
opt.linebreak = true
opt.magic = true
opt.modeline = true -- read modelines inside files
opt.showmode = true
opt.splitright = true -- put ne window right of the current one
-- TODO: set pastetoggle=<F10>
opt.report = 0
opt.selection = 'exclusive'
opt.shortmess = 'aoOIt'
opt.showbreak = '←'
opt.virtualedit = 'block'

-- don't continue comment when inserting new line with 'o' or Enter
opt.formatoptions:remove('o') -- o
opt.formatoptions:remove('r') -- enter
-- something magically resets this setting, so let's do this ugly hack:
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        opt.formatoptions:remove('o')
        opt.formatoptions:remove('r')
    end,
})

opt.mouse = 'a' -- mouse should work even in terminal

opt.updatetime = 300

-- line numbers
opt.numberwidth = 3 -- leave room for 3 digits by default
opt.number = true -- traditional, also adds current line number to relative numbering
opt.relativenumber = true -- relative for easy jumping around

opt.showmode = false -- disable mode in command line, it's already in statusline

-- indentation
opt.tabstop = 8 -- real tab is always 8, if you want something else, use spaces
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.wrap = false -- wrap long lines
opt.textwidth = 78
opt.breakindent = true
opt.breakindentopt = 'shift:3'
opt.colorcolumn = '80'

-- backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- undo
opt.undolevels = 5000
opt.undofile = true

-- symbols
opt.fillchars = {
    vert = '│', -- vertical separator in splits, etc
    fold = '\\' -- folded blocks TODO: ugly
}
opt.list = true
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

-- never show signcolumn, we are coloring the line numbers instead
opt.signcolumn = 'no'

-- disable built-in plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- vim: set sw=4 et:
