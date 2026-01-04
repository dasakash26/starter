-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "Tokyonight",
  transparency = true,
  hl_override = {
    Comment = { fg = "#8f93a2", italic = true },
    ["@comment"] = { fg = "#8f93a2", italic = true },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
    order = { "buffers", "tabs", "btns" },
  },
  -- add more ui options
}

return M
