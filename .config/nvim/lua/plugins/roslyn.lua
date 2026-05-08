return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = false,
        csharp_ls = false,
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
}
