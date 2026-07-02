-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  hl_override = {
    Comment = { italic = true },
    NvDashAscii = { fg = "#89b4fa" },
    NvDashBorder = { fg = "#89b4fa" },
    NvDashFooter = { fg = "#f5c2e7" },
    NvdashButtons = { fg = "#cdd6f4" },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = require "configs.dashboard"

M.ui = {
  transparency = true,
  cmp = {
    icons = true,
    style = "flat_dark",
  },
  telescope = {
    style = "bordered",
  },
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
    "vtsls",
    "bash-language-server",
    "dockerfile-language-server",
    "yaml-language-server",
    "prettier",
    "prisma-language-server",
  },
}

return M
