return function()
  require("keycast").setup({
    -- Customize the style of the keystroke popup
    display = {
      -- Position and appearance of keystroke display
      position = "bottom", -- 'top' | 'bottom' | 'statusline'
      style = "bordered", -- 'minimal' | 'simple' | 'bordered'
      
      -- Size of keystroke display
      width = 45,
      height = 1,
      
      -- Border style
      border = "rounded", -- 'none' | 'single' | 'double' | 'rounded'
      
      -- Timeouts for displaying and fading out the keystrokes
      timeout = 2000, -- The time in ms for how long a keystroke should be shown
      fade_timeout = 500, -- Duration of the fading effect
    },
    
    -- Optional text to show when no key has been pressed yet
    no_pretext = "",
    
    -- Optional text to show after a keystroke
    posttext = "",
    
    -- Key to keystroke mapping (useful for special keys)
    key_map = {},
    
    -- Keys to ignore when displaying
    ignore_keys = {},
  })
  
  -- Start keycast automatically
  vim.cmd("KeycastStart")
end
