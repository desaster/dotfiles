return {
    on_attach = function (client, bufnr, callback)
        -- TODO: This method is not recommended
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        callback(client, bufnr)
    end,
}
