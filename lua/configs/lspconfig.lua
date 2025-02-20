
-- Load NVChad's default LSP configuration (provides on_attach, on_init, capabilities, etc.)
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")  -- NVChad defaults
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Define a custom on_attach that calls NVChad's on_attach and sets up auto-format on save.
local custom_on_attach = function(client, bufnr)
  -- Call the default NVChad on_attach to setup common keymaps and settings.
  nvlsp.on_attach(client, bufnr)

  -- Auto-format on save if the server supports formatting.
  if client.server_capabilities.documentFormattingProvider then
    local group = vim.api.nvim_create_augroup("LspFormatting_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

-- Configure LSP servers.
local servers = {
  html = {},
  cssls = {},
  ts_ls = {  -- TypeScript/JavaScript (and React)
    init_options = {
      hostInfo = "neovim",
      tsserver = {
        -- Adjust the tsdk path as necessary; here it points to your global TypeScript installation.
        tsdk = "/Users/akashdas/.nvm/versions/node/v23.8.0/lib/node_modules/typescript/lib",
      },
    },
  },
  clangd = {},   -- C/C++
  jdtls = {},    -- Java
  lua_ls = {},   -- Lua
  jsonls = {},   -- JSON
  rust = {},
}

for server, config in pairs(servers) do
  config.on_attach = custom_on_attach
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end

