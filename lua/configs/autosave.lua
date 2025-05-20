return function()
  require("auto-save").setup({
    enabled = true,
    debounce_delay = 5000,
    silent = true,
    execution_message = {
      message = function()
        return "" -- Return empty string to suppress message
      end,
    },
    -- Disable all auto-save notifications
    write_all_buffers = false,
    on_off_commands = false,
    clean_command_line_interval = 0,
    show_notification = false,
  })
  
  -- Capture and suppress AutoSave messages via autocmd
  vim.api.nvim_create_autocmd({"BufWritePre", "BufWritePost"}, {
    pattern = "*",
    callback = function()
      -- Clear command line immediately after any buffer write
      vim.defer_fn(function()
        vim.cmd("echo ''")
      end, 1)
    end,
  })
end
