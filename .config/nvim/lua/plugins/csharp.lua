return {
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "dotnet-format" },
      },
      formatters = {
        ["dotnet-format"] = {
          command = "dotnet",
          args = { "format", "--include", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c_sharp" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }
    end,
  },

  -- Neotest для .NET тестов
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {},
      },
    },
  },
}
