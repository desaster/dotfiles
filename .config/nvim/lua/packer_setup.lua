local execute = vim.api.nvim_command
local fn = vim.fn

--
-- Install packer (if not installed)
--

local packer_bootstrap = nil
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ "git", "clone", "https://github.com/smhc/packer.nvim", install_path })
    fn.system({ 'git', '-C', install_path, 'checkout', 'snapshot_load' })
    fn.system({ 'patch', '-p1', './data/nvim/site/pack/packer/start/packer.nvim/lua/packer.lua', 'packer-fix.lua' })
    execute("packadd packer.nvim")
end

--
-- Initialize packer
--

local packer = require 'packer'
packer.init {
    -- snapshot located in config since I also want it in version control
    snapshot_path = vim.fn.stdpath('config'),
    -- PR has a bug that requires the path again here
    snapshot = require('packer.util').join_paths(vim.fn.stdpath('config'), 'packer-lock.json'),
    disable_commands = false
}
packer.reset()

--
-- Specify packages
--

require('plugins')

--
-- If packer was just installed, install packages
--

if packer_bootstrap then
    vim.cmd 'autocmd User PackerComplete ++once lua require("packer").compile(nil, false)'
    packer.install()
end

-- TODO: how to use packages directly after bootstrapping?

--
-- Custom commands for package management
--

--cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]

-- use :PackerSyncAndLock to create a snapshot in packer-lock.json
vim.api.nvim_create_user_command('PackerSyncAndLock', function()
    vim.cmd 'autocmd User PackerComplete ++once lua require("packer").snapshot("packer-lock.json")'
    require("packer").sync()
end, { bang = false })

-- vim: set sw=4 et:
