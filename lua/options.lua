require "nvchad.options"

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})
