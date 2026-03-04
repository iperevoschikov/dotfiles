return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    local dap = require("dap")
    require("netcoredbg-macOS-arm64").setup(dap)
  end,
}
