return function()
  require("bufferline").setup({
    options = {
      -- Enhanced styling and appearance
      mode = "buffers",
      themable = true,
      numbers = function(opts)
        return string.format('%s·%s', opts.ordinal, opts.raise(opts.id))
      end,
      
      -- Custom close button
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      
      -- Visual indicators
      indicator = {
        icon = '▎', -- More visible indicator
        style = 'icon',
      },
      
      -- Buffer separators with improved visibility
      separator_style = {
        "slant",  -- You can use "thick", "thin", "slant", or a custom table
      },
      
      -- Enhanced visual elements
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      
      -- Buffer name formatting
      name_formatter = function(buf)
        if buf.name:match('%.md') then
          return ' ' .. buf.name  -- Markdown icon
        end
        return buf.name
      end,
      
      -- Maximum buffer name length
      max_name_length = 18,
      max_prefix_length = 15,
      truncate_names = true,
      
      -- Tab behavior
      tab_size = 18,
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      
      -- Improved diagnostics integration - more useful!
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = true,
      diagnostics_indicator = function(count, level)
        local icons = {
          error = " ",
          warning = " ",
          info = " ",
          hint = " ",
        }
        local icon = icons[level:lower()] or ""
        return " " .. icon .. count
      end,
      
      -- Custom sorting - makes navigation more logical
      sort_by = function(buffer_a, buffer_b)
        -- Sort by directory path then by name
        local dir_a = vim.fn.fnamemodify(buffer_a.path, ":h")
        local dir_b = vim.fn.fnamemodify(buffer_b.path, ":h")
        
        if dir_a == dir_b then
          return buffer_a.name < buffer_b.name
        else
          return dir_a < dir_b
        end
      end,
      
      -- Enhanced hover actions
      hover = {
        enabled = true,
        delay = 150,
        reveal = {'close'}
      },
      
      -- Improved offsets for other windows like file explorer
      offsets = {
        {
          filetype = "oil",
          text = "File Explorer",
          text_align = "center",
          separator = true,
          highlight = "Directory",
          padding = 1,
        },
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      
      -- Custom highlights to make it visually striking
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
        diagnostic_selected = {
          bold = true,
        },
        info_selected = {
          bold = true,
        },
        info_diagnostic_selected = {
          bold = true,
        },
      },
      
      -- Group related buffers together - very useful!
      groups = {
        options = {
          toggle_hidden_on_enter = true
        },
        items = {
          {
            name = "Tests",
            highlight = {gui = "underline"},
            auto_close = true,
            matcher = function(buf)
              return buf.name:match('_test') or buf.name:match('test_') or buf.name:match('spec')
            end,
          },
          {
            name = "Docs",
            highlight = {gui = "undercurl"},
            auto_close = false,
            matcher = function(buf)
              return buf.name:match('%.md') or buf.name:match('%.txt')
            end,
          }
        }
      }
    }
  })
  
  -- Keymaps to make tab navigation faster
  vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>$', '<cmd>BufferLineGoToBuffer -1<cr>', {noremap = true, silent = true})
  
  -- Quick buffer sorting and grouping
  vim.api.nvim_set_keymap('n', '<leader>be', '<cmd>BufferLineSortByExtension<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>BufferLineSortByDirectory<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>bt', '<cmd>BufferLineTogglePin<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>BufferLineGroupClose ungrouped<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>bg', '<cmd>BufferLinePickClose<cr>', {noremap = true, silent = true})
end
