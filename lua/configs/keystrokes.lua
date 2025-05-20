return function()
  require("keystrokes").setup({
    -- How long to show the keystroke
    timeout = 2000,
    
    -- Where to show the keystroke (either "statusline" or "winbar")
    position = "statusline",
    
    -- Format of the keystroke.
    -- %s is replaced with the actual keys pressed
    format = "󰌌 %s",
    
    -- Enable/disable showing the keystroke
    enabled = true,
    
    -- The highlight group to use for the message
    highlight = "KeystrokesPopup",
    
    -- Create the highlight group if it doesn't exist yet
    create_highlight = true,
    
    -- Highlight group for the popup
    -- This uses highlight groups already defined by your colorscheme if they exist
    highlight_config = {
      -- Background color
      bg = "NONE",
      -- Foreground color
      fg = "#eeeeee",
      -- Bold text
      bold = true,
      -- Italic text
      italic = false,
    },
    
    -- Keys to explicitly ignore
    blacklist = {
      "h", "j", "k", "l",           -- Consider ignoring basic movements
      "<Left>", "<Right>", "<Up>", "<Down>",
    },
  })
end
