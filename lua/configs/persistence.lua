local setup = {
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
  options = { "buffers", "curdir", "tabpages", "winsize" },
  pre_save = nil,
}

local keys = {
  { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
  { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
  { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
}

return {
  setup = setup,
  keys = keys,
}
