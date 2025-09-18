return {
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck", -- TODO: I don't know how to set this up
                "shfmt",
                "eslint-lsp",
                "lua-language-server",
                "prettier",
                "vtsls",
            },
        },
    },
}
