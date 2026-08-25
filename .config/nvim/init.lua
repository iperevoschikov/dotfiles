-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

vim.opt.exrc = true
vim.opt.secure = true

vim.opt.errorformat = vim.o.errorformat .. ",%f(%l\\,%c):\\ error\\ %m,%f(%l\\,%c):\\ warning\\ %m"
