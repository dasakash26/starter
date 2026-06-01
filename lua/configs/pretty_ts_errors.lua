local M = {
  float_opts = {
    border = "rounded",
    max_width = 78,
    max_height = 15,
    wrap = true,
  },

  -- Keep TS explanations manual; <leader>dp opens this when you ask for it.
  auto_open = false,
  lazy_window = true,
}

local function error_title(code)
  return "🔴 Error (" .. code .. ")"
end

local function join_names(names)
  if #names == 1 then
    return "`" .. names[1] .. "`"
  end

  if #names == 2 then
    return "`" .. names[1] .. "` and `" .. names[2] .. "`"
  end

  local quoted = {}
  for _, name in ipairs(names) do
    table.insert(quoted, "`" .. name .. "`")
  end

  quoted[#quoted] = "and " .. quoted[#quoted]
  return table.concat(quoted, ", ")
end

local function strip_markdown(text)
  return text
    :gsub("%[([^%]]-)%]%((https?://[^)]-)%)", "%1")
    :gsub("https?://%S+", "")
    :gsub("🔗", "")
    :gsub("🌐", "")
    :gsub("🔴", "")
    :gsub("<b%d+>", "")
    :gsub("%*%*", "")
    :gsub("```[%w_-]*\n?", "")
    :gsub("```", "")
    :gsub("\n%s*#+%s*", "\n")
    :gsub("^%s*#+%s*", "")
    :gsub("\r", "")
    :gsub("[ \t]+\n", "\n")
    :gsub("\n\n+", "\n\n")
    :gsub("^%s+", "")
    :gsub("%s+$", "")
end

local function is_noise_line(line, code)
  local trimmed = vim.trim(line)

  if trimmed == "" or trimmed == "." or trimmed == ">" then
    return true
  end

  if code and trimmed == code then
    return true
  end

  return code and trimmed:match("^[%p%s]*Error%s*%(" .. code .. "%)[%p%s]*$") ~= nil
end

local function clean_message(text, code)
  local message = strip_markdown(text)
    :gsub("^%s*TS%d+%s*\n+", "")
    :gsub("^%s*Error%s*%([^)]-%)%s*", "")
    :gsub("^%s*" .. (code or "") .. "%s*", "")
    :gsub("^%s*Error%s*\n+", "")
    :gsub("^%s*Error%s*%([^)]-%)%s*\n+", "")
    :gsub("\n+%s*Error%s*\n+", "\n")

  local lines = {}
  for line in vim.gsplit(message, "\n", { plain = true }) do
    if not is_noise_line(line, code) then
      table.insert(lines, line)
    end
  end

  return vim.trim(table.concat(lines, "\n"))
end

local function parse_error(text)
  local cleaned = strip_markdown(text)
  local code = cleaned:match "Error%s*%((TS%d+)%)" or cleaned:match "(TS%d+)"

  return code, clean_message(cleaned, code)
end

local function group_key(code, message)
  local quoted_name = message:match "`([^`]+)`"
  local pattern = quoted_name and message:gsub("`" .. vim.pesc(quoted_name) .. "`", "`%s`", 1) or message

  return (code or "") .. "\n" .. pattern, quoted_name, pattern
end

local function group_errors(items)
  local groups = {}
  local order = {}

  for _, item in ipairs(items) do
    local code, message = parse_error(item)
    local key, quoted_name, pattern = group_key(code, message)

    if not groups[key] then
      groups[key] = {
        code = code,
        message = message,
        names = {},
        pattern = pattern,
      }
      table.insert(order, key)
    end

    if quoted_name then
      table.insert(groups[key].names, quoted_name)
    end
  end

  local lines = {}
  for _, key in ipairs(order) do
    local group = groups[key]
    local message = group.message

    if #group.names > 1 then
      message = group.pattern:format(join_names(group.names))
    end

    if group.code then
      table.insert(lines, error_title(group.code))
    end

    table.insert(lines, message)
  end

  return table.concat(lines, "\n\n")
end

local function patch_no_focus(diagnostics)
  if diagnostics._whatsup_no_focus then
    return
  end

  local show_formatted_error = diagnostics.show_formatted_error

  diagnostics.show_formatted_error = function(opts)
    opts = opts or {}

    if opts.focus_existing_window ~= false then
      return show_formatted_error(opts)
    end

    local set_current_win = vim.api.nvim_set_current_win
    vim.api.nvim_set_current_win = function() end

    local ok, result = pcall(show_formatted_error, opts)
    vim.api.nvim_set_current_win = set_current_win

    if not ok then
      error(result)
    end

    return result
  end

  diagnostics._whatsup_no_focus = true
end

local function patch_formatter(format)
  if format._whatsup_cleaned then
    return
  end

  local original = format.format_error_async
  local pending = {}

  format.format_error_async = function(diagnostic, callback)
    original(diagnostic, function(formatted)
      if not formatted then
        callback(formatted)
        return
      end

      local line = diagnostic.lnum or -1
      pending[line] = pending[line] or {
        items = {},
        callbacks = {},
        scheduled = false,
      }

      local batch = pending[line]
      table.insert(batch.items, formatted)
      table.insert(batch.callbacks, callback)

      if batch.scheduled then
        return
      end

      batch.scheduled = true
      vim.defer_fn(function()
        batch = pending[line]
        pending[line] = nil

        if not batch then
          return
        end

        batch.callbacks[#batch.callbacks](group_errors(batch.items))

        for index = 1, #batch.callbacks - 1 do
          batch.callbacks[index] ""
        end
      end, 20)
    end)
  end

  format._whatsup_cleaned = true
end

function M.setup()
  local diagnostics_ok, diagnostics = pcall(require, "pretty-ts-errors.diagnostics")
  if diagnostics_ok then
    patch_no_focus(diagnostics)
  end

  local format_ok, format = pcall(require, "pretty-ts-errors.format")
  if format_ok then
    patch_formatter(format)
  end
end

return M
