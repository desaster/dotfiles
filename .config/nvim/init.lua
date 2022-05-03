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

require("packer_setup")
require("mappings")
require("options")
--require("autocmd")

-- vim: set sw=4 et:
