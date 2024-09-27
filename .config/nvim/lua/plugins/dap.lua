-- we install dap manually with LazyExtras, so let's only return their configs if
-- they are installed, or else the configs would cause them to be installed
if not LazyVim.has("nvim-dap") then
    return
end

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },
}

