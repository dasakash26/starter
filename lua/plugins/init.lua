return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

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
        "html", "css", "tsx",
      },
    },
  },

  { "nvim-tree/nvim-web-devicons", opts = {} },

  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        server = {
          -- Optional tsserver settings
          -- Example: disable formatting if using other formatter
          -- on_attach = function(client, bufnr)
          --   client.server_capabilities.documentFormattingProvider = false
          -- end,

          on_attach = function()
            local map = vim.keymap.set
            map("n", "<C-i>", ":TypescriptAddMissingImports<CR>", { desc = "Auto Import Missing" })
            map("n", "<M-r>", ":TypescriptRenameFile<CR>", { desc = "Rename File" })
            map("n", "<M-o>", ":TypescriptOrganizeImports<CR>", { desc = "Organize Imports" })
            map("n", "<M-u>", ":TypescriptRemoveUnused<CR>", { desc = "Remove Unused Variables" })
          end,
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
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP Completion
      "hrsh7th/cmp-buffer",       -- Buffer completion
      "hrsh7th/cmp-path",         -- Path completion
      "hrsh7th/cmp-cmdline",      -- Command-line completion
      "L3MON4D3/LuaSnip",         -- Snippets
      "saadparwaiz1/cmp_luasnip", -- Snippets completion
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion manually
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
          ["<Tab>"] = cmp.mapping.select_next_item(),        -- Navigate down
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),      -- Navigate up
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP suggestions
          { name = "luasnip" },  -- Snippets
          { name = "buffer" },   -- Buffer words
          { name = "path" },     -- File path suggestions
        }),
      })
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        finder = {
          keys = {
            vsplit = "v",
            split = "s",
            edit = "o",
          },
        },
        lightbulb = { enable = false }
      })
    end,
  },

  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        debounce_delay = 5000,
      })
    end,
    lazy = false,
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Uses `nvim-notify`
    },
    config = function()
      require("noice").setup({
        lsp = {
          progress = { enabled = false },
        },
      })
    end,
    lazy = false,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    opts = {},
    lazy = false,
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    config = function()
      require("oil").setup({
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
        default_file_explorer = true,
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        -- Window-local options to use for oil buffers
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
        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = false,
        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = false,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        -- You can set the delay to false to disable cleanup entirely
        -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          -- Enable or disable LSP file operations
          enabled = true,
          -- Time to wait for LSP file operations to complete before skipping
          timeout_ms = 1000,
          -- Set to true to autosave buffers that are updated with LSP willRenameFiles
          -- Set to "unmodified" to only save unmodified buffers
          autosave_changes = false,
        },
        -- Constrain the cursor to the editable parts of the oil buffer
        -- Set to `false` to disable, or "name" to keep it on the file names
        constrain_cursor = "editable",
        -- Set to true to watch the filesystem for changes and reload oil
        watch_for_changes = false,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = false,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return false
          end,
          natural_order = "fast",
          case_insensitive = false,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
          -- Customize the highlight group for the file name
          highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
            return nil
          end,
        },
        -- Extra arguments to pass to SCP when moving/copying files over SSH
        extra_scp_args = {},
        -- EXPERIMENTAL support for performing file operations with git
        git = {
          -- Return true to automatically git add/mv/rm files
          add = function(path)
            return false
          end,
          mv = function(src_path, dest_path)
            return false
          end,
          rm = function(path)
            return false
          end,
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
          get_win_title = nil,
          -- preview_split: Split direction: "auto", "left", "right", "above", "below".
          preview_split = "auto",
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        -- Configuration for the file preview window
        preview_win = {
          -- Whether the preview window is automatically updated when the cursor is moved
          update_on_cursor_moved = true,
          -- How to open the preview window "load"|"scratch"|"fast_scratch"
          preview_method = "fast_scratch",
          -- A function that returns true to disable preview on a file e.g. to avoid lag
          disable_preview = function()
            return false
          end,
          -- Window-local options to use for preview window buffers
          win_options = {},
        },
        -- Configuration for the floating action confirmation window
        confirmation = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
          max_width = 0.9,
          -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
          min_width = { 40, 0.4 },
          -- optionally define an integer/float for the exact width of the preview window
          width = nil,
          -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a single value or a list of mixed integer/float types.
          -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
          max_height = 0.9,
          -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
          min_height = { 5, 0.1 },
          -- optionally define an integer/float for the exact height of the preview window
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
        -- Configuration for the floating SSH window
        ssh = {
          border = "rounded",
        },
        -- Configuration for the floating keymaps help window
        keymaps_help = {
          border = "rounded",
        },
      })
    end,
    lazy = false,
  },

  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.cmd([[ highlight NotifyBackground guibg=#000000 ]]) -- creates the highlight group with black bg
      require("notify").setup({
        background_colour = "NotifyBackground",
      })
    end,
  },

  -- 🪞 Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "catppuccin",
          section_separators = '',
          component_separators = '',
        },
      }
    end
  },

  -- 🧩 Tabline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup {}
    end,
  },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       transparent_background = true,
  --       integrations = {
  --         nvimtree = {
  --           enabled = true,
  --           transparent_panel = true, -- Transparent NvimTree panel
  --         },
  --         lualine = true,
  --         telescope = {
  --           enabled = true,
  --           transparent = true, -- Transparent Telescope UI
  --         },
  --         notify = true,
  --         which_key = true,
  --       }
  --     })
  --     vim.cmd.colorscheme("catppuccin")
  --   end
  -- }


}
