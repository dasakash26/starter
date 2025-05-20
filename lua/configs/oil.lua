return function()
  require("oil").setup({
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    default_file_explorer = true,
    columns = {
      "icon",
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    
    -- Window-local options
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    
    -- Additional configuration (truncated for brevity)
    -- For the full configuration, see the original plugin setup
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    
    -- Rest of your oil configuration...
  })
end
