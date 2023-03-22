return {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
            },
        },
    },
    -- lsp should be installed with:
    -- rustup component add rust-analyzer
    ensure_installed = false,
    cmd = { "rustup", "run", "stable", "rust-analyzer", },
}
