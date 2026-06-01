local opts = require "nvchad.configs.nvimtree"

opts.filters = vim.tbl_deep_extend("force", opts.filters or {}, {
  dotfiles = false,
  git_ignored = false,
})

opts.view = vim.tbl_deep_extend("force", opts.view or {}, {
  side = "right",
  width = 40,
})

return opts
