-- we install dap manually with LazyExtras, so let's only return their configs if
-- they are installed, or else the configs would cause them to be installed
if not LazyVim.has("nvim-dap") then
    return
end

return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },

            { "<S-F5>", function() require("dap").terminate() end, desc = "Debug: Terminate", },
            { "<F17>", function() require("dap").terminate() end, desc = "Debug: Terminate", },

            { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
            { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
            { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Breakpoint" },

            { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
            { "<F23>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
        },
    },
    {
        -- disable in favor of nvim-dap-view
        "rcarriga/nvim-dap-ui",
        enabled = false
    },
    {
        "igorlfs/nvim-dap-view",
        keys = {
            { "<F12>", "<cmd>DapViewToggle<CR>" , desc = "Debug: Dap View Toggle" },
        },
        opts = {
            winbar = {
                controls = {
                    -- https://igorlfs.github.io/nvim-dap-view/control-bar
                    enabled = true,
                },
                sections = { "watches", "scopes", "breakpoints", "repl" }, -- c64 dev
                show_keymap_hints = false, -- save space in a narrow terminal
                base_sections = {
                    breakpoints = { label = function (len) return len > 80 and "Breakpoints" or "Brk" end, keymap = "B" },
                    scopes = { label = function (len) return len > 80 and "Scopes" or "Sco" end, keymap = "S" },
                    exceptions = { label = function (len) return len > 80 and "Exceptions" or "Exc" end, keymap = "E" },
                    watches = { label = function (len) return len > 80 and "Watches" or "Wtc" end, keymap = "W" },
                    threads = { label = function (len) return len > 80 and "Threads" or "Thr" end, keymap = "T" },
                    repl = { label = "REPL", keymap = "R" },
                    sessions = { label = function (len) return len > 80 and "Sessions" or "Ses" end, keymap = "K" },
                    console = { label = function (len) return len > 80 and "Console" or "Con" end, keymap = "C" },
                },
            },
            auto_toggle = true,
        }
    }
}

