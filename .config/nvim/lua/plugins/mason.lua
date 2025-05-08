return {
    {
        "williamboman/mason.nvim",
        version = "^1.0.0", -- pinned version as a workaround https://github.com/LazyVim/LazyVim/issues/6039#issuecomment-2856227817
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
    {
        "mason-org/mason-lspconfig.nvim",
        version = "^1.0.0", -- pinned version as a workaround
    },
}
