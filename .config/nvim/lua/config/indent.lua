-- TODO: have extra chars toggleable with hotkey
--vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")

vim.cmd [[hi IblIndent ctermfg=109 guifg=#32302f]] -- a bit darker than default

local status_ok, ibl = pcall(require, 'ibl')
if not status_ok then
    return
end

-- :help ibl.config
ibl.setup {
    enabled = true, -- HINT: ibl can be toggled with :IBLToggle
    indent = { char = '▏' }, -- narrower than default
    scope = {
        enabled = true, -- HINT: scope can be toggled with :IBLToggleScope
        char = '▏', -- same char, but highlight color will be different
        show_start = false,
        show_end = false,
    },
    --scope = { exclude = { language = { "lua" } } },
}
