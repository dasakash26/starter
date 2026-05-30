-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- Dashboard helpers keep the whole NvDash panel aligned as one box.
local dash_gutter = ""
local dash_inner_width = 67

local function dash_wrap(line)
  return dash_gutter .. line .. dash_gutter
end

local function dash_rule(left, right)
  return dash_wrap(left .. string.rep("─", dash_inner_width) .. right)
end

local function dash_named_rule(left, label, right)
  local title = "─ " .. label .. " "
  local fill = dash_inner_width - vim.api.nvim_strwidth(title)
  return dash_wrap(left .. title .. string.rep("─", math.max(fill, 0)) .. right)
end

local dash_border_top = dash_named_rule("┌", "runtime://workspace", "┐")
local dash_border_mid = dash_rule("├", "┤")
local dash_border_bottom = dash_rule("└", "┘")

local function dash_line(text)
  local padding = dash_inner_width - vim.api.nvim_strwidth(text)
  return dash_wrap("│" .. text .. string.rep(" ", math.max(padding, 0)) .. "│")
end

local dash_empty = dash_line ""

local function dash_center(text)
  local padding = dash_inner_width - vim.api.nvim_strwidth(text)
  local left = math.floor(math.max(padding, 0) / 2)
  local right = math.max(padding, 0) - left
  return dash_wrap("│" .. string.rep(" ", left) .. text .. string.rep(" ", right) .. "│")
end

local function dash_section(label)
  return dash_named_rule("├", label, "┤")
end

local function dash_button(label, keys, cmd)
  return {
    multicolumn = true,
    no_gap = true,
    keys = keys,
    cmd = cmd,
    { txt = dash_gutter .. "│    ", hl = "NvDashAscii" },
    { txt = label, hl = "NvdashButtons", pad = "full" },
    { txt = keys, hl = "NvDashFooter" },
    { txt = "  │" .. dash_gutter, hl = "NvDashAscii" },
  }
end

local function dash_empty_button(hl)
  return {
    txt = dash_empty,
    hl = hl or "NvdashButtons",
    no_gap = true,
  }
end

M.base46 = {
  theme = "catppuccin",

  hl_override = {
    Comment = { italic = true },
    NvDashAscii = { fg = "#89b4fa" },
    NvDashFooter = { fg = "#f5c2e7" },
    NvdashButtons = { fg = "#cdd6f4" },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    "",
    "",
    dash_border_top,

    dash_empty,
    dash_empty,

    dash_center "████  █   █ █   █ █████ █████ █   █ █████",
    dash_center "█   █ █   █ ██  █   █     █   ██ ██ █    ",
    dash_center "████  █   █ █ █ █   █     █   █ █ █ ████ ",
    dash_center "█  █  █   █ █  ██   █     █   █   █ █    ",
    dash_center "█   █  ███  █   █   █   █████ █   █ █████",

    dash_empty,
    dash_empty,

    dash_center "make the abstract executable",

    dash_empty,
    dash_empty,
    dash_empty,

    dash_section "actions",
  },

  buttons = {
    dash_empty_button(),
    dash_empty_button(),

    dash_button("  Find File", "ff", "Telescope find_files"),
    dash_button("  Recent Files", "fr", "Telescope oldfiles"),
    dash_button("󰈭  Search Text", "fg", "Telescope live_grep"),
    dash_empty_button(),
    dash_button("󰙅  File Tree", "fe", "NvimTreeToggle"),
    dash_button("󰒡  Diagnostics", "dd", "Trouble diagnostics toggle"),
    dash_button("  TODOs", "dt", "Trouble todo toggle"),
    dash_button("󰒲  Plugins", "ll", "Lazy"),
    dash_empty_button(),
    dash_button("󰏗  Tools", "mm", "Mason"),
    dash_button("  Mappings", "ch", "NvCheatsheet"),

    dash_empty_button(),
    dash_empty_button(),

    { txt = dash_border_mid, hl = "NvDashFooter", no_gap = true },

    dash_empty_button "NvDashFooter",

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return dash_center("  loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms)
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    dash_empty_button "NvDashFooter",

    { txt = dash_border_bottom, hl = "NvDashFooter", no_gap = true },
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
