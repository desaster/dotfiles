-- Copilot stuff is installed manually with :LazyExtras

local copilot_config = {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        keys = {
            { "<leader>ai", "<cmd>Copilot toggle<cr>", desc = "Toggle (Copilot)" },
        },
        opts = {
            -- copilot-cmp recommends disabling suggestion and panel
            -- modules, since they can interfere with copilot-cmp
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = not vim.g.ai_cmp, -- enable only if not using cmp/blink for ai suggestions
                auto_trigger = true,
                hide_during_completion = vim.g.ai_cmp,
                keymap = {
                    -- accept = "<tab>",
                    -- accept_word = "...",
                    -- accept_line = "...",
                    next = "<M-n>",
                    prev = "<M-p>",
                    dismiss = "<M-BS>", -- C-BS is more difficult to bind
                },
            },
        },
    },
}

local copilot_chat_config = {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        opts = {
            auto_insert_mode = false,
        },
    }
}

-- we install these plugins manually, so let's only return their configs if
-- they are installed, or else the configs would cause them to be installed

local ret = {}

if LazyVim.has("copilot.lua") then
    table.insert(ret, copilot_config)
end

if LazyVim.has("CopilotChat.nvim") then
    table.insert(ret, copilot_chat_config)
end

return ret
