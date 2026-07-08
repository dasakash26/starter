return {
  -- Completion and syntax come first because other plugins build on filetypes/LSP.
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "astro", "xml", "markdown" },
    opts = {},
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat",
          "NormalSB",
          "FloatBorder",
        },
      })
      require("transparent").clear_prefix "NvimTree"
      require("transparent").clear_prefix "NvDash"
      require("transparent").clear_prefix "Tb"
    end,
  },
  -- File operations load with nvim-tree; LSP capabilities are declared in lspconfig.
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  -- Language tooling: base LSP first, then language-specific helpers.
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "youyoumu/pretty-ts-errors.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    cmd = { "PrettyTsError", "PrettyTsErrors", "PrettyTsToggleAuto" },
    opts = require "configs.pretty_ts_errors",
    config = function(_, opts)
      local pretty_ts_errors = require "pretty-ts-errors"
      pretty_ts_errors.setup(opts)
      require("configs.pretty_ts_errors").setup()
    end,
  },

  -- Diagnostics and TODO views.
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  -- Formatting runs on write; detailed formatter setup lives in configs/conform.lua.
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- Autosave triggers real writes; Conform still formats on BufWritePre.
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    event = { "InsertLeave", "TextChanged", "BufLeave", "FocusLost" },
    cmd = "ASToggle",
    keys = {
      { "<leader>ua", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
    },
    opts = require "configs.autosave",
  },

  -- Editor workflow helpers with small inline configs.
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    opts = require "configs.nvimtree",
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      require("lazy").load { plugins = { "nvim-lsp-file-operations" } }
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension "import"
    end,
  },

  {
    "folke/which-key.nvim",
    opts = require "configs.whichkey",
  },


  -- Competitive programming workflow stays isolated from general web/dev tooling.
  {
    "xeluxee/competitest.nvim",
    dependencies = "muniftanjim/nui.nvim",
    cmd = "CompetiTest",
    config = function()
      require("competitest").setup(require "configs.competitest")
    end,
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = require "configs.leetcode",
  },
  {
    "3rd/image.nvim",
    build = false,
    dependencies = {
      "kiyoon/magick.nvim",
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
    },
  },
}
