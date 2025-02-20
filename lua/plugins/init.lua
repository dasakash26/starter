return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
    },
  },

  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        server = {
          -- Optional: add any tsserver configuration here.
          -- Example: disable formatting if you use another formatter.
          -- on_attach = function(client, bufnr)
          --   client.server_capabilities.documentFormattingProvider = false
          -- end,
        },
      })
    end,
  },

  {
    "davidosomething/format-ts-errors.nvim",
    config = function()
      require("format-ts-errors").setup({
        add_markdown = true,    -- wrap output with markdown ```ts ``` markers
        start_indent_level = 0, -- initial indent
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm", -- Loads the plugin when the command is invoked
    config = function()
      require("toggleterm").setup {
        -- Your custom configuration here (if any)
      }
    end,
  }
}
