-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- disable conceal for markdown to prevent hiding link information
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "markdown" },
    callback = function()
        vim.wo.conceallevel = 0
    end,
})

-- don't let lazyvim set spellchecking for us
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
