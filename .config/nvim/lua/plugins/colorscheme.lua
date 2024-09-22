return {
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        priority = 1000,
        dependencies = { "nvim-lualine/lualine.nvim" },
        opts = function()
            vim.g.gruvbox_material_background = 'hard'
            return {
            }
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "gruvbox-material",
        },
    }
}
