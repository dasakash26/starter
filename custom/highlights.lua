local M = {}

M.override = {
  Comment                  = { fg = "#FF9E64", italic = true },
  LineNr                   = { fg = "#5eacd3" },
  CursorLineNr             = { fg = "#FF9E64", bold = true },
  Cursor                   = { bg = "#FF9E64" },
  CursorLine               = { bg = "#1a1a1a" },
  CursorColumn             = { bg = "#1a1a1a" },
  Visual                   = { bg = "#44475a" },
  Search                   = { fg = "#000000", bg = "#FF9E64", bold = true },
  IncSearch                = { fg = "#000000", bg = "#FF9E64", bold = true },
  TabLineSel               = { fg = "#FF9E64", bold = true },
  Normal                   = { bg = "NONE" },
  NormalNC                 = { bg = "NONE" },
  EndOfBuffer              = { bg = "NONE" },
  VertSplit                = { bg = "NONE" },
  StatusLine               = { fg = "#00FFFF", bg = "NONE" },
  StatusLineNC             = { fg = "#666666", bg = "NONE" },
  NvimTreeFolderName       = { fg = "#82aaff" },
  NvimTreeOpenedFolderName = { fg = "#FF9E64", bold = true },
  NvimTreeIndentMarker     = { fg = "#6272a4" },

  -- Enhanced syntax
  Keyword                  = { fg = "#c792ea", bold = true },
  Identifier               = { fg = "#82aaff" },
  Function                 = { fg = "#8be9fd", bold = true },
  String                   = { fg = "#f1fa8c" },
  Number                   = { fg = "#bd93f9" },
  Type                     = { fg = "#ffb86c" },
}

return M
