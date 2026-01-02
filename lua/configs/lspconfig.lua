local default_config = require "nvchad.configs.lspconfig"
local on_attach = default_config.on_attach
local capabilities = default_config.capabilities

-- List of LSP servers
local servers = {
  "ts_ls", -- JavaScript/TypeScript
  "html", -- HTML
  "cssls", -- CSS
  "jsonls", -- JSON
  "eslint", -- Linting JS/TS
  "clangd", -- C/C++
  "prismals",
  "pyright",
  "lua_ls", -- Lua (Neovim)
}

-- Add format-on-save behavior
on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { bufnr = bufnr }
      end,
    })
  end
end

-- Configure all servers
for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server == "lua_ls" then
    opts.settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    }
  end
  if server == "pyright" then
    opts.settings = {
      python = {
        -- proper path to your venv when using uv
        pythonPath = vim.fn.finddir(".venv", ".;") .. "/bin/python",
      },
    }
  end

  -- New API for Neovim 0.11+
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
