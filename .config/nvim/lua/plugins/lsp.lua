return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local diagnostic_goto = function(next, severity)
                local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
                severity = severity and vim.diagnostic.severity[severity] or nil
                return function()
                    go({ severity = severity })
                end
            end

            local ret = {
                servers = {
                    ['*'] = {
                        keys = {
                            { "<F8>", diagnostic_goto(true) },
                            { "<S-F8>", diagnostic_goto(false) },
                            -- Actually, shift-F8 may appear as F20
                            -- 1. check the escape code with: showkey -a
                            -- 2. create a debug log with: nvim -V3log
                            -- 3 .search for the escape code under --- Terminal info ---
                            { "<F20>", diagnostic_goto(false) }
                        }
                    }
                },
                diagnostics = {
                    -- disable virtual text, it often doesn't fit anyway
                    virtual_text = false,

                    -- diagnostics in the number column would be added like
                    -- this, but now I'm actually starting to use the
                    -- signcolumn since it's used for more stuff (like dap)
                    --
                    -- signs = {
                    --     numhl = {
                    --         [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                    --         [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                    --         [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                    --         [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                    --     },
                    -- },

                    float = {
                        -- always show source in diagnostic float so we can
                        -- see if the error is from the linter or the compiler
                        source = true
                    }
                },
                inlay_hints = {
                    -- disable inlay hints since they often just puke out a bunch of errors:
                    --   vtsls: -32603: Request textDocument/inlayHint failed with message: <semantic> TypeScript Server Error (5.3.2)
                    --   Debug Failure. Unexpected node.^M
                    --   Node IndexSignature was unexpected.
                    enabled = false
                },
            }
            return LazyVim.merge({}, opts, ret)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
    }
}
