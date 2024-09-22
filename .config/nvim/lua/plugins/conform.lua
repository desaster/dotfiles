local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                ["javascript"] = prettier,
                ["javascriptreact"] = prettier,
                ["typescript"] = prettier,
                ["typescriptreact"] = prettier,
            },
            log_level = vim.log.levels.INFO,
        }
    }
}
