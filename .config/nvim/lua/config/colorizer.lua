local status_ok, colorizer = pcall(require, 'colorizer')
if not status_ok then
    return
end

colorizer.setup({
    filetypes = {
        "conf",
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "lua",
        "yaml",
    },
    user_default_options = { mode = "background", },
})
