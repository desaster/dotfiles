--
-- Configuring neovim is hell. This is yet another attempt.
--
-- Plan:
-- * Add one thing at a time
-- * Do not add another thing until the one thing works in an acceptable manner
-- * Use packer's snapshot feature to do some kind of a lock file to avoid updates breaking everything
-- 	(NOTE: this currently works in a rather complicated manner)
--

local cmd = vim.cmd

-- use node from nvm if version number is specified
-- export NEOVIM_NODE_VERSION=v16.14.2
-- to verify:
--   :checkhealth
if (vim.fn.has('unix') == 1 and vim.fn.empty(vim.env.NEOVIM_NODE_VERSION) == 0) then
    local node_dir = vim.env.HOME .. '/.nvm/versions/node/' .. vim.env.NEOVIM_NODE_VERSION .. '/bin/'
    if (vim.fn.isdirectory(node_dir)) then
        vim.env.PATH = node_dir .. ':' .. vim.env.PATH
    end
end

require("packer_setup")
require("mappings").setup_keymaps()
require("options")
--require("autocmd")

-- vim: set sw=4 et:
