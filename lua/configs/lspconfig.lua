
local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_nvim_lsp.default_capabilities()

local custom_on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)

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

local servers = {
  clangd = { },

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
    on_attach = custom_on_attach,
    capabilities = capabilities,
  },

  ts_ls = {
  init_options = {
    hostInfo = "neovim",
    tsserver = {
      tsdk = "/Users/akashdas/.nvm/versions/node/v23.8.0/lib/node_modules/typescript/lib",
    },
  },
  on_attach = custom_on_attach,
  capabilities = capabilities,
  },

  html = {},
  cssls = {},
  jsonls = {},
  tailwindcss = {},
}

for server, config in pairs(servers) do
  -- if on_attach or capabilities not set (empty config), set them
  config.on_attach = config.on_attach or custom_on_attach
  config.capabilities = config.capabilities or capabilities
  lspconfig[server].setup(config)
end

vim.o.updatetime = 500

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

