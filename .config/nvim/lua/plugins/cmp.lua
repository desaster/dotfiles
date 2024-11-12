return {
    {
        "hrsh7th/nvim-cmp",
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            opts.sources = vim.tbl_filter(function(source)
                return source.name ~= "buffer"
            end, opts.sources)

            local cmp = require("cmp")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                -- completion menu randomly stays on screen, this will let us close it
                ["<C-E>"] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible then
                        if cmp.get_selected_entry() then
                            cmp.confirm({ select = false })
                        else
                            fallback()
                        end
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ["<C-Space>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- menu is open, go to next item
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                    -- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#tab-completion-configuration-highly-recommended
                    -- TODO: I don't understand when this is actually triggered
                    elseif cmp.visible() and has_words_before() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        -- cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
            local ret = {
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None
            }
            return LazyVim.merge({}, opts, ret)
        end,
    },
}
