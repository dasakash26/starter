-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    "",
    "┌─────────────────────────────────────────────┐",
    "│  ████  █   █ █   █ █████ █████ █   █ █████  │",
    "│  █   █ █   █ ██  █   █     █   ██ ██ █      │",
    "│  ████  █   █ █ █ █   █     █   █ █ █ ████   │",
    "│  █  █  █   █ █  ██   █     █   █   █ █      │",
    "│  █   █  ███  █   █   █   █████ █   █ █████  │",
    "│                                             │",
    "│        make the abstract executable         │",
    "└─────────────────────────────────────────────┘",
    "",
  },

  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fr", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Search Text", keys = "fg", cmd = "Telescope live_grep" },
    { txt = "󰙅  File Tree", keys = "fe", cmd = "NvimTreeToggle" },
    { txt = "󰒡  Diagnostics", keys = "dd", cmd = "Trouble diagnostics toggle" },
    { txt = "  TODOs", keys = "dt", cmd = "Trouble todo toggle" },
    { txt = "󰒲  Plugins", keys = "ll", cmd = "Lazy" },
    { txt = "󰏗  Tools", keys = "mm", cmd = "Mason" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Runtime loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
M.ui = {
  tabufline = {
    lazyload = false,
    order = { "buffers", "tabs", "btns" },
  },
}

M.mason = {
  pkgs = {
    "html-lsp",
    "css-lsp",
    "json-lsp",
    "eslint-lsp",
    "tailwindcss-language-server",
    "emmet-language-server",
    "typescript-language-server",
    "bash-language-server",
    "dockerfile-language-server",
    "yaml-language-server",
    "prettier",
    "prisma-language-server",
  },
}

return M
