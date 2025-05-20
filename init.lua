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
    branch = "v2.5",
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

vim.cmd([[
  " 🌫️ Transparent Buffer Background
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE

  " 🚥 Transparent SignColumn (line numbers, diagnostics)
  highlight SignColumn guibg=NONE ctermbg=NONE

  " 🔍 Transparent Telescope Windows
  highlight TelescopeNormal guibg=NONE ctermbg=NONE
  highlight TelescopeBorder guibg=NONE ctermbg=NONE
  highlight TelescopePromptNormal guibg=NONE ctermbg=NONE
  highlight TelescopePromptBorder guibg=NONE ctermbg=NONE
  highlight TelescopeResultsNormal guibg=NONE ctermbg=NONE
  highlight TelescopeResultsBorder guibg=NONE ctermbg=NONE
  highlight TelescopePreviewNormal guibg=NONE ctermbg=NONE
  highlight TelescopePreviewBorder guibg=NONE ctermbg=NONE

  " 🌊 Floating Windows Transparency
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE

  " 📂 Transparent NvimTree
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE

  " 🪟 Transparent Status Line
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight TabLineFill guibg=NONE ctermbg=NONE

  " 💻 Terminal Background (no transparency for readability)
  highlight TermCursor guibg=#1e1e2e guifg=#cdd6f4
  highlight Terminal guibg=#1e1e2e guifg=#cdd6f4 ctermbg=0

  " 🚧 Vertical Split (semi-transparent for better contrast)
  highlight VertSplit guifg=#1e1e2e guibg=NONE ctermbg=NONE

  " ✨ Improved Floating Borders (slightly dim)
  highlight FloatBorder guifg=#575268 guibg=NONE

  " 🎨 Custom PopupMenu (for autocomplete and suggestions)
  highlight Pmenu guibg=NONE ctermbg=NONE
  highlight PmenuSel guibg=#44475a ctermbg=0
  highlight PmenuSbar guibg=#44475a ctermbg=0
  highlight PmenuThumb guibg=#6272a4 ctermbg=0


   highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight TabLineFill guibg=NONE ctermbg=NONE
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeVertSplit guifg=#1e1e2e guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
]])
