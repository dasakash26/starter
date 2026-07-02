require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local user = augroup("UserConfig", { clear = true })

autocmd("TextYankPost", {
  group = user,
  callback = function()
    vim.highlight.on_yank {
      timeout = 150,
    }
  end,
})

autocmd({ "FocusGained", "BufEnter" }, {
  group = user,
  command = "checktime",
})
