local lualine = require('lualine')

vim.opt.showtabline = 2

lualine.setup({
    options = {
        theme = 'gruvbox-material',
        -- icons enabled forces some devicons for "fileformat"
        icons_enabled = false,

        -- disable separators, no devicons
        section_separators = '',
        component_separators = '',

        -- but here are some examples of what we could use
        --section_separators = { "", "" },
        --component_separators = { "", "" },
        --component_separators = { "|", "|" },
        --section_separators = {'', ''},
        --component_separators = {'', ''}
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode = 2 -- show buffer index & filename
            }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    }
})
