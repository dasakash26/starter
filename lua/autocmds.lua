require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local user = augroup("UserConfig", { clear = true })

autocmd("TextYankPost", {
  group = user,
  callback = function()
    vim.highlight.on_yank {
      timeout = 150,
    }
  end,
})

autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = user,
  command = "if getcmdwintype() == '' | checktime | endif",
})

autocmd("LspAttach", {
  group = user,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/codeAction") then
      local opts = function(desc)
        return { buffer = args.buf, desc = "LSP " .. desc }
      end

      local function run(kind)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        for _, c in ipairs(clients) do
          local params = vim.tbl_extend("force", vim.lsp.util.make_range_params(0, c.offset_encoding), {
            context = { only = { kind }, diagnostics = {} }
          })
          c:request("textDocument/codeAction", params, function(err, result)
            if err or not result then return end
            for _, r in ipairs(result) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, c.offset_encoding)
              end
            end
          end)
        end
      end

      vim.keymap.set("n", "<leader>im", function()
        run("source.addMissingImports")
      end, opts "Add missing imports")

      vim.keymap.set("n", "<leader>io", function()
        run("source.organizeImports")
      end, opts "Organize imports")
    end
  end,
})

local format = augroup("Format", { clear = true })
autocmd("BufWritePre", {
  group = format,
  pattern = "*.tsx,*.ts,*.jsx,*.js",
  callback = function(args)
    local clients = vim.lsp.get_clients({ bufnr = args.buf })
    for _, client in ipairs(clients) do
      local params = vim.tbl_extend("force", vim.lsp.util.make_range_params(0, client.offset_encoding), {
        context = { only = { "source.organizeImports", "source.fixAll", "source.addMissingImports" }, diagnostics = {} }
      })
      local result = client:request_sync("textDocument/codeAction", params, 1000, args.buf)
      for _, r in ipairs(result and result.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        end
      end
    end
  end,
})


