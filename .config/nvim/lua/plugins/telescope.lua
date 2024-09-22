return {
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<C-p>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
            { ";", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
            { "<M-CR>", vim.lsp.buf.code_action, desc = "which_key_ignore", mode = { "n", "v" } },
            { "<leader>,", nil },
        },
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "node_modules"
                },
            },
            pickers = {
                find_files = {
                    -- prefer fd over ripgrep
                    -- https://www.reddit.com/r/linux4noobs/comments/egb644/fzf_newcomer_fd_or_ripgrep/fc5li3r/
                    find_command = function()
                        if 1 == vim.fn.executable("fd") then
                            return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
                        elseif 1 == vim.fn.executable("fdfind") then
                            return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
                        elseif 1 == vim.fn.executable("rg") then
                            return { "rg", "--files", "--color", "never", "-g", "!.git" }
                        elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
                            return { "find", ".", "-type", "f" }
                        elseif 1 == vim.fn.executable("where") then
                            return { "where", "/r", ".", "*" }
                        end
                    end,
                },
            },
        },
    }
}
