-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@class ChadrcConfig

local M = {}

M.ui = {
  tabufline = {
    lazyload = false,
  },
  cmp = {
    style = "atom", -- override from "default" to "atom"
  },
  statusline = {
    theme = "default",
    separator_style = "default",

    -- Custom statusline modules for C/C++ development
    overriden_modules = function()
      local st_modules = require "nvchad.statusline.modules"

      -- Add clangd status indicator to statusline
      local function clangd_status()
        local clients = vim.lsp.get_active_clients({ name = "clangd" })

        if #clients > 0 then
          local status = "⚙️ " -- Default status

          -- Get clangd status if available
          if clients[1].server_capabilities then
            status = "🔧"
          end

          return status
        end
        return ""
      end

      -- Return modules with custom ordering and additions
      return {
        mode = st_modules.mode,
        file = st_modules.file,
        clangd = clangd_status,
        git = st_modules.git,
        diagnostic = st_modules.diagnostics,
        lsp = st_modules.lsp,
        cwd = st_modules.cwd,
      }
    end,
  },
}

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    -- C/C++ specific highlighting improvements
    ["@function.c"] = { bold = true },
    ["@type.c"] = { italic = true },
    ["@keyword.c"] = { bold = true },
    ["@function.cpp"] = { bold = true },
    ["@type.cpp"] = { italic = true },
    ["@keyword.cpp"] = { bold = true },
  },
}

M.nvdash = {
  load_on_startup = true,
}

return M
