local M = {}

local enabled = false
local float_opts = { border = "rounded", focusable = false, source = "if_many" }

local function set_config(opts)
  pcall(vim.diagnostic.config, opts)
end

set_config({ virtual_text = false, virtual_lines = false, float = float_opts })

function M.toggle()
  enabled = not enabled
  local ok = pcall(vim.diagnostic.config, { virtual_text = false, virtual_lines = enabled, float = float_opts })
  if not ok then
    local ok2 = pcall(vim.diagnostic.config, { virtual_text = enabled, virtual_lines = false, float = float_opts })
    if ok2 then
      vim.notify("virtual_lines unsupported — falling back to virtual_text", vim.log.levels.WARN)
    else
      vim.notify("Failed to set diagnostics configuration", vim.log.levels.ERROR)
    end
  else
    vim.notify("Diagnostic virtual lines " .. (enabled and "enabled" or "disabled"))
  end
  return enabled
end

function M.open_float()
  vim.diagnostic.open_float(nil, vim.tbl_extend("force", float_opts, { scope = "cursor" }))
end

return M
