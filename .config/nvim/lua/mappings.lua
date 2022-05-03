local g = vim.g -- global variables

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- TODO: what does this set_keymap from mjlbach do?
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ","

-- next/previous buffer
map('n', '<leader>l', ':bnext<CR>', { silent = true })
map('n', '<leader>h', ':bprevious<CR>', { silent = true })
map("n", "<TAB>", ":bnext<CR>", { silent = true })
map("n", "<S-TAB>", ":bprevious<CR>", { silent = true })

-- switch to alternate buffer
map('n', '<leader>#', ':b#<CR>')

-- close the current buffer without closing (famiu/bufdelete.nvim)
map('n', '<leader>d', ':silent Bdelete<CR>', { silent = true })

-- switch to buffers by number
map('n', '<leader>1', ':LualineBuffersJump 1<CR>', { noremap = true, silent = true })
map('n', '<leader>2', ':LualineBuffersJump 2<CR>', { noremap = true, silent = true })
map('n', '<leader>3', ':LualineBuffersJump 3<CR>', { noremap = true, silent = true })
map('n', '<leader>4', ':LualineBuffersJump 4<CR>', { noremap = true, silent = true })
map('n', '<leader>5', ':LualineBuffersJump 5<CR>', { noremap = true, silent = true })
map('n', '<leader>6', ':LualineBuffersJump 6<CR>', { noremap = true, silent = true })
map('n', '<leader>7', ':LualineBuffersJump 7<CR>', { noremap = true, silent = true })
map('n', '<leader>8', ':LualineBuffersJump 8<CR>', { noremap = true, silent = true })
map('n', '<leader>9', ':LualineBuffersJump 9<CR>', { noremap = true, silent = true })

-- move between windows
map('t', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
map('t', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
map('t', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
map('t', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
map('i', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
map('i', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
map('i', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
map('i', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
map('n', '<A-h>', '<C-w>h', { noremap = true })
map('n', '<A-j>', '<C-w>j', { noremap = true })
map('n', '<A-k>', '<C-w>k', { noremap = true })
map('n', '<A-l>', '<C-w>l', { noremap = true })

-- paste over currently selected text without yanking it
map("v", "p", '"_dP', { noremap = true })

-- keep search matches in the middle of the window and pulse the line when moving to them
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- backspace clears matches
map('n', '<BS>', ':nohlsearch<CR>', { silent = true })

-- emacs bindings in command line mode
map('c', '<C-a>', '<Home>', { noremap = true })
map('c', '<C-e>', '<End>', { noremap = true })

--
-- Telescope mappings
--
-- These are defined here instead of the telescope config, since we want
-- telescope to lazy-load
--

-- Search for files in your current working directory
map('n', '<C-p>', ':Telescope find_files<CR>')

-- Searches for the string under your cursor in your current working directory
-- map('n', '<leader>g', ':Telescope grep_string<CR>')

-- Search for a string in your current working directory
map('n', '<leader>g', ':Telescope live_grep<CR>')

-- Lists files and folders in your current working directory, open files,
-- navigate your filesystem, and create new files and folders
map('n', '<F7>', ':Telescope file_browser<CR>')

-- list buffers
map('n', ';', ':Telescope buffers<CR>')

-- vim: set sw=4 et:
