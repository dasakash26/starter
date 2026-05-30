require("nvchad.configs.lspconfig").defaults()

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

local servers = {
  "html",
  "cssls",
  "jsonls",
  "eslint",
  "tailwindcss",
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
