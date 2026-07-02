local ignored_filetypes = {
  "gitcommit",
  "NvimTree",
  "TelescopePrompt",
  "lazy",
  "mason",
  "trouble",
}

return {
  trigger_events = {
    immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
    defer_save = { "InsertLeave", "TextChanged" },
    cancel_deferred_save = { "InsertEnter" },
  },

  condition = function(buf)
    local bo = vim.bo[buf]
    local name = vim.api.nvim_buf_get_name(buf)

    return name ~= ""
      and bo.buftype == ""
      and not bo.readonly
      and bo.modifiable
      and not vim.tbl_contains(ignored_filetypes, bo.filetype)
  end,

  debounce_delay = 1000,
  noautocmd = true,
}
