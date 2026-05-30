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
    [=[       /\                 /\       ]=],
    [=[      / \'._   (\_/)   _.'/ \      ]=],
    [=[     /_.''._'--('.')--'_.''._\     ]=],
    [=[     | \_ / `;=/ " \=;` \ _/ |     ]=],
    [=[      \/ `\__|`\___/`|__/` \/      ]=],
    [=[              \(/|\)/              ]=],
    "",
    "night shift, ready to build",
    "",
  },

  buttons = {
    { txt = "find file", keys = "ff", cmd = "Telescope find_files" },
    { txt = "recent files", keys = "fr", cmd = "Telescope oldfiles" },
    { txt = "search text", keys = "fg", cmd = "Telescope live_grep" },
    { txt = "file tree", keys = "fe", cmd = "NvimTreeToggle" },
    { txt = "diagnostics", keys = "dd", cmd = "Trouble diagnostics toggle" },
    { txt = "todos", keys = "dt", cmd = "Trouble todo toggle" },
    { txt = "plugins", keys = "ll", cmd = "Lazy" },
    { txt = "tools", keys = "mm", cmd = "Mason" },
    { txt = "mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "-", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "ready with " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },

    { txt = "-", hl = "NvDashFooter", no_gap = true, rep = true },
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
