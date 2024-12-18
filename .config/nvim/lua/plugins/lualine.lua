return {
    {
        "nvim-lualine/lualine.nvim",
        -- On initial setup, setting up lualine pukes out this:
        --      Error detected while processing /home/bob/.config/nvim/init.lua:
        --      Failed to run `config` for lualine.nvim
        --      ...local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua:203:
        --      module 'trouble' not found:
        -- There was a fix done: https://github.com/LazyVim/LazyVim/issues/3944
        -- but it does not work for me.
        -- Two options, either disable trouble in lualine: vim.g.trouble_lualine = false
        -- or add trouble as a dependency for lualine, so 'require' works for it early
        --
        -- Additionally lualine now throws an error: attempt to index global 'Snacks'
        -- So we'll add snacks.nvim as a dependency as well
        dependencies = {
            "folke/trouble.nvim",
            "snacks.nvim"
        },

        event = "VeryLazy",
        keys = {
            { "<leader>1", "<cmd>LualineBuffersJump 1<cr>", desc = "which_key_ignore" },
            { "<leader>2", "<cmd>LualineBuffersJump 2<cr>", desc = "which_key_ignore" },
            { "<leader>3", "<cmd>LualineBuffersJump 3<cr>", desc = "which_key_ignore" },
            { "<leader>4", "<cmd>LualineBuffersJump 4<cr>", desc = "which_key_ignore" },
            { "<leader>5", "<cmd>LualineBuffersJump 5<cr>", desc = "which_key_ignore" },
            { "<leader>6", "<cmd>LualineBuffersJump 6<cr>", desc = "which_key_ignore" },
            { "<leader>7", "<cmd>LualineBuffersJump 7<cr>", desc = "which_key_ignore" },
            { "<leader>8", "<cmd>LualineBuffersJump 8<cr>", desc = "which_key_ignore" },
            { "<leader>9", "<cmd>LualineBuffersJump 9<cr>", desc = "which_key_ignore" },
        },
        opts = function(_, opts)
            -- for i, section in ipairs(opts.sections.lualine_c) do
            --     if section[1] == "diagnostics" then
            --         -- disable symbols, colors are enough
            --         opts.sections.lualine_c[i].symbols = {
            --             error = "",
            --             warn = "",
            --             info = "",
            --             hint = "",
            --         }
            --     end
            -- end

            -- to look at sections, you can use:
            -- :lua vim.print(require('lualine').get_config().sections)

            -- remove the clock from lualine_z, I have enough clocks
            table.remove(opts.sections.lualine_z, 1)

            for i, section in ipairs(opts.sections.lualine_y) do
                -- move "location" from y to z
                if (section[1] == "location") then
                    table.insert(opts.sections.lualine_z, section)
                    table.remove(opts.sections.lualine_y, i)
                end

                -- patch in the padding value for progress
                if (section[1] == "progress") then
                    opts.sections.lualine_y[i].padding.right = 1
                end
            end

            -- using lualine's tabline instead of bufferline, since this
            -- themes out properly out of the box with gruvbox-material
            local ret = {
                tabline = {
                    lualine_a = {
                        {
                            'buffers',
                            mode = 2 -- show buffer index & filename
                        }
                    },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            }

            LazyVim.merge(opts, ret)
            return opts
        end
    },
}
