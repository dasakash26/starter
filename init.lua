vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v3.0", -- Update to v3.0
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Consolidated transparency settings
vim.cmd([[
  " Transparency + Contrast UI elements
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight TabLineFill guibg=NONE ctermbg=NONE

  " Comment Highlight (improved visibility)
  highlight Comment guifg=#FF9E64 gui=italic ctermfg=DarkYellow

  " Line numbers
  highlight LineNr guifg=#5eacd3
  highlight CursorLineNr guifg=#FF9E64 gui=bold

  " Cursor & selection
  highlight Cursor guibg=#FF9E64
  highlight CursorLine guibg=#1a1a1a
  highlight CursorColumn guibg=#1a1a1a
  highlight Visual guibg=#44475a guifg=NONE

  " Search
  highlight Search guibg=#FF9E64 guifg=#000000 gui=bold
  highlight IncSearch guibg=#FF9E64 guifg=#000000 gui=bold

  " Tabline
  highlight TabLine guibg=NONE guifg=#888888
  highlight TabLineSel guibg=NONE guifg=#FF9E64 gui=bold

  " Telescope
  highlight TelescopeNormal guibg=NONE ctermbg=NONE
  highlight TelescopeBorder guibg=NONE ctermbg=NONE
  highlight TelescopePromptNormal guibg=NONE ctermbg=NONE
  highlight TelescopePromptBorder guibg=NONE ctermbg=NONE
  highlight TelescopeResultsNormal guibg=NONE ctermbg=NONE
  highlight TelescopeResultsBorder guibg=NONE ctermbg=NONE
  highlight TelescopePreviewNormal guibg=NONE ctermbg=NONE
  highlight TelescopePreviewBorder guibg=NONE ctermbg=NONE

  " Floating + NvimTree
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
  highlight NvimTreeFolderName guifg=#82aaff
  highlight NvimTreeOpenedFolderName guifg=#FF9E64 gui=bold
  highlight NvimTreeIndentMarker guifg=#6272a4

  " PopupMenu
  highlight Pmenu guibg=NONE ctermbg=NONE
  highlight PmenuSel guibg=#44475a ctermbg=0
  highlight PmenuSbar guibg=#44475a ctermbg=0
  highlight PmenuThumb guibg=#6272a4 ctermbg=0

  " GitSigns
  highlight GitSignsAdd guifg=#50fa7b
  highlight GitSignsChange guifg=#f1fa8c
  highlight GitSignsDelete guifg=#ff5555

  " Diagnostics
  highlight DiagnosticError guifg=#ff5555
  highlight DiagnosticWarn guifg=#f1fa8c
  highlight DiagnosticInfo guifg=#8be9fd
  highlight DiagnosticHint guifg=#50fa7b
]])
