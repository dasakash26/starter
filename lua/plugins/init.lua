return {
  -- Completion and syntax come first because other plugins build on filetypes/LSP.
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Language tooling: base LSP first, then language-specific helpers.
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    opts = {},
  },

  {
    "dmmulroy/ts-error-translator.nvim",
    event = "LspAttach",
    opts = {
      auto_attach = true,
    },
  },

  {
    "erichdongubler/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require "configs.lsp_lines"
    end,
  },

  -- Diagnostics and TODO views.
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VimEnter",
    config = function()
      require("todo-comments").setup {}
    end,
  },

  -- Formatting runs on write; detailed formatter setup lives in configs/conform.lua.
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- Editor workflow helpers with small inline configs.
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
        width = 40,
      },
    },
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

  -- Competitive programming workflow stays isolated from general web/dev tooling.
  {
    "xeluxee/competitest.nvim",
    dependencies = "muniftanjim/nui.nvim",
    cmd = "CompetiTest",
    config = function()
      require("competitest").setup(require "configs.competitest")
    end,
  },
}
