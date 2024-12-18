return {
    {
        "ibhagwan/fzf-lua",
        keys = {
            { "<C-p>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
            { ";", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
            { "<M-CR>", vim.lsp.buf.code_action, desc = "which_key_ignore", mode = { "n", "v" } },
            { "<leader>,", nil },
        }
    }
}
