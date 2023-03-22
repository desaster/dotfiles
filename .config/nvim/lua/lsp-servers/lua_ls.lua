return {
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                -- seems like this shouldn't be global,
                -- but then again we only use lua for nvim
                globals = { 'vim' } -- TODO: this doesn't work
            }
        },
    },
}
