return {
    {
        "folke/snacks.nvim",
        opts = {
            notifier = {
                enabled = false
            },
            dashboard = {
                enabled = false
            },
            terminal = {
                win = {
                    style = "float",
                    width = math.floor(vim.o.columns * 0.75),
                    height = math.floor(vim.o.lines * 0.75),
                },
            },
        }
    }
}
