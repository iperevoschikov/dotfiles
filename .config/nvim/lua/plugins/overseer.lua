return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction" },
  opts = {
    "toggleterm",
    direction = "horizontal",
    auto_scroll = true,
    close_on_exit = false,
  },
  keys = {
    { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
    { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
    { "<leader>ob", "<cmd>OverseerRun dotnet_build<cr>", desc = "Build (.NET)" },
    { "<leader>ot", "<cmd>OverseerRun dotnet_test<cr>", desc = "Test (.NET)" },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- 🔨 BUILD
    overseer.register_template({
      name = "dotnet_build",
      builder = function()
        return {
          cmd = { "dotnet" },
          args = { "build" },
          components = {
            "default",
            "on_output_quickfix", -- парсинг ошибок
            "on_result_diagnostics", -- интеграция с LSP diagnostics
          },
        }
      end,
    })

    -- 🧪 TEST
    overseer.register_template({
      name = "dotnet_test",
      builder = function()
        return {
          cmd = { "dotnet" },
          args = { "test" },
          components = {
            "default",
            "on_output_quickfix",
          },
        }
      end,
    })

    -- 🚀 RUN (для текущего проекта)
    overseer.register_template({
      name = "dotnet_run",
      builder = function()
        return {
          cmd = { "dotnet" },
          args = { "run" },
          components = {
            "default",
          },
        }
      end,
    })
  end,
}
