return {
  lsp = {
    progress = { enabled = true },
    signature = { enabled = false },
    hover = { enabled = false }, -- keep native float hover
    message = { enabled = false },
  },

  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
  },

  routes = {
    -- Suppress save messages like "23L, 500B written"
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },

    -- Optional: suppress "Already at newest change"
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "Already at newest change",
      },
      opts = { skip = true },
    },

    -- Optional: suppress "No lines in buffer"
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "No lines in buffer",
      },
      opts = { skip = true },
    },
  },
}
