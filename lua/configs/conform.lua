local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    java = { "google-java-format" }
  },

  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },

  -- autosave_changes = {
  --   timeout_ms = 10000,
  -- }
}

return options
