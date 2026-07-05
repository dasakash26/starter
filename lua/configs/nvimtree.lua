local opts = require "nvchad.configs.nvimtree"

return vim.tbl_deep_extend("force", opts, {
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  view = {
    side = "right",
    width = 40,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    icons = {
      hint = " ",
      info = " ",
      warning = " ",
      error = " ",
    },
  },
  renderer = {
    highlight_git = "none",
    highlight_diagnostics = "name",
    highlight_opened_files = "icon",
    icons = {
      git_placement = "after",
      show = {
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "M",
          staged = "A",
          unmerged = "≠",
          renamed = "R",
          untracked = "U",
          deleted = "D",
          ignored = " ",
        },
      },
    },
  },
  update_focused_file = {
    update_root = true,
  },
})
