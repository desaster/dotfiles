-- TODO: have extra chars toggleable with hotkey
--vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")

vim.cmd [[hi IndentBlankLineChar ctermfg=109 guifg=#32302f]] -- a bit darker than default
vim.cmd [[hi link IndentBlankLineContextChar LineNr]] -- lighter color context

local status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not status_ok then
    return
end

indent_blankline.setup {
    -- some characters to use ¦┆│⎸ ▏
    char = '▏', -- hopefully this works everywhere. if not, comment it out
    show_current_context = true, -- uses treesitter
    show_current_context_start = false,
}
