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
    config = require("configs.autosave"),
    lazy = false,
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Uses `nvim-notify`
    },
    config = require("configs.noice"),
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
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = require("configs.oil"),
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
    opts = require("configs.fidget"),
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = require("configs.persistence").setup,
  },

  -- Only one instance of nvim-notify with config in separate file
  {
    "rcarriga/nvim-notify",
    config = require("configs.notify"),
  },

  -- 🪞 Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("configs.lualine"),
  },

  -- 🧩 Tabline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("configs.bufferline"),
  },

  -- 🔍 Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
      -- Enable telescope fzf native
      require("telescope").load_extension("fzf")
    end,
  },

  -- 💬 Easy commenting
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("Comment").setup()
    end,
  },

  -- ⚒️ Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- 🔖 File bookmarks
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({})
    end,
    -- Keys defined in mappings.lua
  },

  -- 🚦 Better diagnostics display
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    -- Keys defined in mappings.lua
  },

  -- 🔄 Project-wide search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    -- Keys defined in mappings.lua
  },
  
  -- 📝 Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    config = function()
      require("todo-comments").setup({
        -- Keywords recognized as todo comments
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })
    end,
    -- Use telescope binding from the central keybindings file
  },
  -- Alternative: which-key for showing available keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    },
  },
}
