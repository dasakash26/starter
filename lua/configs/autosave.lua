return function()
  require("auto-save").setup({
    -- Completely disable auto-save
    enabled = false,
    
    -- These settings will only apply if you manually enable it later
    -- with the :ASToggle command
    execution_message = {
      message = function()
        return "" -- Return empty string to suppress message
      end,
    },
    debounce_delay = 5000,
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 0,
    show_notification = false,
  })
  
  -- Clear command line after any buffer write to hide "written" messages
  vim.api.nvim_create_autocmd({"BufWritePre", "BufWritePost"}, {
    pattern = "*",
    callback = function()
      vim.defer_fn(function()
        vim.cmd("echo ''")
      end, 10)
    end,
  })
  
  -- Print confirmation that auto-save is disabled
  vim.notify("Auto-save has been disabled", vim.log.levels.INFO)
end
