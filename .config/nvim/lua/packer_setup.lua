local execute = vim.api.nvim_command
local fn = vim.fn

--
-- Install packer (if not installed)
--

local packer_bootstrap = nil
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        -- "https://github.com/wbthomason/packer.nvim",
        "-b",
        "feat/lockfile",
        "https://github.com/EdenEast/packer.nvim", -- Packer with lockfile support. Remove once it lands in upstream.
        install_path,
    }
    print "Fresh Packer installation. Close and reopen Neovim to activate."
    execute("packadd packer.nvim")
end

--
-- Initialize packer
--


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- local packer = require 'packer'
packer.init {
    -- disable_commands = false,
    display = {
        -- TODO: floating window is annoyingly pink when theme is not yet installed
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
    git = {
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
    lockfile = {
        enable = true,
        regen_on_update = true,
        path = require('packer.util').join_paths(vim.fn.stdpath('config'), 'packer-lock.json'),
    }
}
--packer.reset()

--
-- Specify packages
--

require('plugins')

--
-- If packer was just installed, install packages
--

if packer_bootstrap then
    -- vim.cmd 'autocmd User PackerComplete ++once lua require("packer").compile(nil, false)'
    -- packer.install()
    packer.sync()
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
