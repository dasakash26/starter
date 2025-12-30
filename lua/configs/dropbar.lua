local M = {}

function M.setup()
  local dropbar = require('dropbar')

  dropbar.setup({
    icons = { kinds = {} }, -- disable icons for minimal look
    padding = { left = 0, right = 0 },
    bar = {
      pick = { formats = { lsp = true, treesitter = true, markdown = true } }, -- ensure all available sources are used
    },
  })

  local dropbar_api = require('dropbar.api')
  vim.keymap.set('n', '<Leader>9', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
  vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
  vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

  -- Use subtle pale colors (like inactive tabs)
  local pale_fg = "#4b5263"    -- dim gray
  local current_fg = "#6c7086" -- soft highlight

  vim.api.nvim_set_hl(0, "DropBarIcon", { fg = pale_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DropBarKind", { fg = pale_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DropBarText", { fg = pale_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DropBarCurrent", { fg = current_fg, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DropBarIconUI", { fg = pale_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DropBarContext", { fg = pale_fg, bg = "NONE" })
end

return M
