local nvchad_lsp = require "nvchad.configs.lspconfig"

nvchad_lsp.defaults()

local file_operation_capabilities = {
  workspace = {
    fileOperations = {
      didCreate = true,
      didDelete = true,
      didRename = true,
      willCreate = true,
      willDelete = true,
      willRename = true,
    },
  },
}

nvchad_lsp.capabilities = vim.tbl_deep_extend("force", nvchad_lsp.capabilities, file_operation_capabilities)

vim.lsp.config("*", {
  capabilities = nvchad_lsp.capabilities,
  on_init = nvchad_lsp.on_init,
})

require "configs.lsp_lines"

-- define clangd FIRST
vim.lsp.config("clangd", {
  cmd = {
    "/opt/homebrew/opt/llvm/bin/clangd",
    "--query-driver=/opt/homebrew/opt/llvm/bin/clang++",
    "--fallback-style=llvm",
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
    },
  },
})

vim.lsp.config("vtsls", {
  settings = {
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
    },
  },
})

vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
  },
})

local servers = {
  "html",
  "cssls",
  "jsonls",
  "eslint",
  "tailwindcss",
  "vtsls",
  "emmet_language_server",
  "bashls",
  "dockerls",
  "yamlls",
  "pyright",
  "prismals",
}

-- then enable
vim.lsp.enable(servers)
vim.lsp.enable "clangd"
vim.lsp.enable "rust_analyzer"

-- read :h vim.lsp.config for changing options of lsp servers
