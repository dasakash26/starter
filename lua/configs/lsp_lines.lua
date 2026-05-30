local M = {}

if vim.islist then
  vim.tbl_islist = vim.islist
end

require("lsp_lines").setup()

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    focusable = false,
    source = "if_many",
  },
}

function M.toggle()
  local enabled = require("lsp_lines").toggle()
  vim.diagnostic.config { virtual_text = false }
  return enabled
end

return M
