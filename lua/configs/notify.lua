return function()
  vim.cmd([[ highlight NotifyBackground guibg=#000000 ]]) -- creates the highlight group with black bg
  
  local config = {
    background_colour = "NotifyBackground",
    timeout = 1000, -- shorter timeout (1 second)
    max_width = 50,
    render = "minimal", -- Use minimal render mode
  }
  
  require("notify").setup(config)
  -- Set as default notification system
  vim.notify = require("notify")
end
