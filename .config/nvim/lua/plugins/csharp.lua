return {
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
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
          args = { "format", "whitespace", "--folder", "--include", "$FILENAME" },
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

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "Issafalcon/neotest-dotnet",
    },
    opts = function()
      local neotest_dotnet = require("neotest-dotnet")

      return {
        log_level = 1, -- включаем отладку, чтобы видеть команды
        adapters = {
          neotest_dotnet({
            dap = {
              adapter_name = "coreclr",
              justMyCode = false,
            },
            -- важно под Windows: адаптер будет искать .csproj, если нет .sln
            discovery_root = "project",
          }),
        },
      }
    end,
  },
}
