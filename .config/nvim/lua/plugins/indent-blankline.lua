return {
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = function()
            vim.cmd [[hi IblIndent ctermfg=109 guifg=#32302f]] -- a bit darker than default
            return {
                indent = {
                    char = '▏', -- narrower than default
                    tab_char = '▏', -- narrower than default
                },
                scope = {
                    enabled = true, -- HINT: scope can be toggled with :IBLToggleScope
                    char = '▏', -- same char, but highlight color will be different
                    show_start = false,
                    show_end = false,
                },
            }
        end,
    }
}
