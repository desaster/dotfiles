-- Copilot stuff is installed manually with :LazyExtras

local copilot_config = {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        opts = {
            -- copilot-cmp recommends disabling suggestion and panel
            -- modules, since they can interfere with copilot-cmp
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
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
