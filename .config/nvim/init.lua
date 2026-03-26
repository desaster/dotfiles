--
-- Configuring neovim is hell. This is yet another attempt.
--
-- This time with LazyVim!
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

vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    -- paste = {
    --     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    --     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    -- },
    -- alacritty has `osc52 = "CopyPaste"`, but it does not work for some
    -- reason, so let's just disable paste this method stops neovim from
    -- doing the annoying "Waiting for OSC 52 response from the terminal."
    paste = {
        ['+'] = function() return { {}, 'v' } end,
        ['*'] = function() return { {}, 'v' } end,
    },
}

-- Debugging
_G.dd = function(...)
    require("util.debug").dump(...)
end
vim.print = _G.dd

-- LazyVim
require("config.lazy")
