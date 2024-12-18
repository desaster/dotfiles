return {
    {
        -- https://github.com/saghen/blink.cmp
        "saghen/blink.cmp",
        opts = function(_, opts)
            local ret = {
                -- https://github.com/saghen/blink.cmp?tab=readme-ov-file#configuration
                completion = {
                    accept = {
                        auto_brackets = {
                            enabled = false,
                        },
                    },
                    list = {
                        selection = 'manual' -- do not preselect completion items
                    },
                },
                keymap = {
                    preset = 'enter',
                    -- Cycle selections with tab, shift-tab
                    ['<Tab>'] = { 'select_next', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                },
            }
            return LazyVim.merge({}, opts, ret)
        end,
    },
}
