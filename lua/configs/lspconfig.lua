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
  
  -- Add clangd-specific keymaps if this is the clangd server
  if client.name == "clangd" then
    local map = vim.keymap.set
    local opts = { buffer = bufnr, noremap = true, silent = true }
    
    map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr, desc = "Switch Source/Header" })
    map("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<CR>", { buffer = bufnr, desc = "Type Hierarchy" })
    map("n", "<leader>cs", "<cmd>ClangdSymbolInfo<CR>", { buffer = bufnr, desc = "Symbol Info" })
    map("n", "<leader>cm", "<cmd>ClangdMemoryUsage<CR>", { buffer = bufnr, desc = "Memory Usage" })
  end
end

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = "utf-8" }),
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    on_attach = custom_on_attach,
  },
  
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
        telemetry = {
          enable = false,
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

vim.o.updatetime = 300  -- Faster diagnostic updates

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

