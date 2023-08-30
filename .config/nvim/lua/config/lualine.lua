local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
    return
end

vim.opt.showtabline = 2

-- https://www.reddit.com/r/neovim/comments/12g2dcz/any_way_to_get_the_fetching_status_of_copilot_in/jfkj9vr/
local copilot_indicator = function()
    local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
    if client == nil then
        return ""
    end

    if vim.tbl_isempty(client.requests) then
        return "" -- default icon whilst copilot is idle TODO: non-special font?
    end

    local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    return spinners[frame + 1]
end

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
    sections = {
        lualine_x = { copilot_indicator, 'encoding', 'fileformat', 'filetype' },
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
