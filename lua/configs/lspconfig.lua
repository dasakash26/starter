local default_config = require("nvchad.configs.lspconfig")
local on_attach = default_config.on_attach
local capabilities = default_config.capabilities

local lspconfig = require("lspconfig")

-- LSP servers for MERN + TypeScript + C++
local servers = {
  "ts_ls",  -- JavaScript/TypeScript
  "html",   -- HTML
  "cssls",  -- CSS
  "jsonls", -- JSON
  "eslint", -- Linting JS/TS
  "clangd", -- C/C++
  "prismals",
}

local on_attach = function(client, bufnr)
  -- Format on save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Optional: customize Lua LS for Neovim dev
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})
