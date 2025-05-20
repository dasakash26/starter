return function()
  require("noice").setup({
    lsp = {
      progress = { enabled = false },
    },
    messages = {
      -- Using nui.nvim for views
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      -- Disable specific notifications
      enabled = true,
      view_search = false, -- Disable search notifications
    },
    routes = {
      -- Hide write/save notifications
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written", -- Hide "written" messages
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "lines", -- Hide "X lines, Y bytes" messages
        },
        opts = { skip = true },
      },
      -- Additional filters to hide auto-save notifications
      {
        filter = {
          event = "msg_show",
          find = "AutoSave", -- Hide AutoSave plugin messages
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "saved", -- Hide any message containing "saved"
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "write", -- Hide any message containing "write"
        },
        opts = { skip = true },
      },
    },
  })
end
