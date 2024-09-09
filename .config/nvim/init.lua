--
-- Configuring neovim is hell. This is yet another attempt.
--

-- Plan:
-- * Add one thing at a time
-- * Do not add another thing until the one thing works in an acceptable manner
-- * Use packer's snapshot feature to do some kind of a lock file to avoid updates breaking everything
-- 	(NOTE: this currently works in a rather complicated manner)
--

-- use node from nvm if version number is specified
-- export NEOVIM_NODE_VERSION=v16.14.2
-- to verify:
--   :checkhealth
if vim.fn.has('unix') == 1 and vim.fn.empty(vim.env.NEOVIM_NODE_VERSION) == 0 then
    local preferred_version = vim.env.NEOVIM_NODE_VERSION
    if string.sub(preferred_version, 1, 1) == 'v' then
        preferred_version = string.sub(preferred_version, 2)
    end

    -- primarily use nvm
    local nvm_node_dir = vim.env.HOME .. '/.nvm/versions/node/v' .. preferred_version .. '/bin/'
    -- alternatively mise
    local mise_node_dir = vim.env.HOME .. '/.local/share/mise/installs/node/' .. preferred_version .. '/bin/'

    if (vim.fn.isdirectory(nvm_node_dir) ~= 0) then
        vim.env.PATH = nvm_node_dir .. ':' .. vim.env.PATH
    elseif (vim.fn.isdirectory(mise_node_dir) ~= 0) then
        vim.env.PATH = mise_node_dir .. ':' .. vim.env.PATH
    end
end

require("utils")
require("mappings").setup_keymaps()
require("lazy_setup")
require("options")
--require("autocmd")

-- vim: set sw=4 et:
