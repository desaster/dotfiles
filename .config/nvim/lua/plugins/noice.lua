-- search with noice is somehow bugged so the text is invisible
-- this temporary workaround is from https://github.com/folke/noice.nvim/issues/892#issuecomment-2260017355
-- vim.api.nvim_create_autocmd("CmdlineChanged", {
--   group = vim.api.nvim_create_augroup("update_search_redraw", {}),
--   desc = "Update search redraw",
--   callback = function()
--     vim.schedule(function()
--       vim.cmd("redraw")
--     end)
--   end,
-- })

return {
    {
        "folke/noice.nvim",
        -- disable the whole thing, popups are distracting and this plugin
        -- would take some time to configure all the messaging properly
        enabled = false,
    },
}
