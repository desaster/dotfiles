-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- next/previous buffer
-- now set in lua/plugins/bufferline.lua
keymap.set('n', '<leader>l', ':bnext<CR>', { noremap = true, silent = true, desc = "Next Buffer" })
keymap.set('n', '<leader>h', ':bprevious<CR>', { noremap = true, silent = true, desc = "Prev Buffer" })

-- switch to alternate buffer
keymap.set('n', '<leader>#', ':b#<CR>', { noremap = true, silent = true, desc = "Switch to Other Buffer" })

-- move between windows
keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', opts)
keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', opts)
keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', opts)
keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', opts)
keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', opts)
keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', opts)
keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', opts)
keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', opts)
keymap.set('n', '<A-h>', '<C-w>h', opts)
keymap.set('n', '<A-j>', '<C-w>j', opts)
keymap.set('n', '<A-k>', '<C-w>k', opts)
keymap.set('n', '<A-l>', '<C-w>l', opts)

-- toggle terminal
keymap.set({ "n", "i", "t" }, "<F4>", Snacks.terminal.toggle, { desc = "Toggle term" })

-- paste over currently selected text without yanking it
keymap.set("v", "p", '"_dP', opts)

-- keep search matches in the middle of the window and pulse the line when moving to them
keymap.set('n', 'n', 'nzzzv', opts)
keymap.set('n', 'N', 'Nzzzv', opts)

-- backspace clears matches
keymap.set('n', '<BS>', ':nohlsearch<CR>', opts)

-- emacs bindings in command line mode
keymap.set('c', '<C-a>', '<Home>', opts)
keymap.set('c', '<C-e>', '<End>', opts)

-- I keep accidentally hitting q:, which opens some ex window.
-- Slowly typing q: still seems to open ex, which is ok.
keymap.set('n', 'q:', ':q')

-- useful things
keymap.set('n', '<F3>', ':lua require("util.misc").toggle_crap()<CR>')
