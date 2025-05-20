local function keystrokes()
  -- Return this directly since showcmdloc is set to statusline
  -- This space will be used by Vim to show keystrokes
  return ""
end

return function()
  -- Get colors from current colorscheme for better integration
  local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
  }

  -- System resource usage (CPU/Memory)
  local function system_resources()
    -- Only show on Unix-like systems where we can get this info
    if vim.fn.has('unix') == 0 then return "" end
    
    local mem_info = ""
    local cpu_info = ""
    
    -- Try to get memory usage (macOS/Linux compatible)
    local handle = io.popen("command -v vm_stat >/dev/null 2>&1 && vm_stat | grep 'Pages free:' | awk '{print $3}' || free -m | awk 'NR==2{printf \"%.1f%%\", $3*100/$2}'")
    if handle then
      mem_info = handle:read("*a"):gsub("\n", "")
      handle:close()
      
      -- Format macOS output 
      if mem_info:match("^%d+%.") then
        local pages_free = tonumber(mem_info)
        if pages_free then
          -- Rough estimate for macOS
          mem_info = string.format("Mem: %.1f%%", 100 - (pages_free * 4096 / 1073741824) * 100)
        end
      else
        mem_info = "Mem: " .. mem_info
      end
    end
    
    -- Try to get CPU usage (compatible with macOS/Linux)
    local handle2 = io.popen("command -v top >/dev/null 2>&1 && top -l 1 -n 0 | grep 'CPU usage' | awk '{print $3}' || top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4\"%\"}'")
    if handle2 then
      cpu_info = handle2:read("*a"):gsub("\n", "")
      handle2:close()
      
      if cpu_info ~= "" then
        cpu_info = "CPU: " .. cpu_info 
      end
    end
    
    -- Return the combined information
    if mem_info ~= "" or cpu_info ~= "" then
      return cpu_info .. " " .. mem_info
    end
    return ""
  end

  -- Current time
  local function current_time()
    return " " .. os.date("%H:%M") -- 24-hour format
  end

  -- Git blame info for current line
  local function git_blame_line()
    local blame = vim.b.gitsigns_blame_line
    if not blame or blame == "" then return "" end
    
    local name = blame:match("author (.+),")
    local time = blame:match(", (%d%d%d%d%-%d%d%-%d%d)")
    
    if name and time then
      return "󰊢 " .. name .. " (" .. time .. ")"
    end
    return ""
  end

  -- File permission info
  local function file_permissions()
    local file = vim.fn.expand("%:p")
    if file == nil or file == "" then return "" end
    
    local stats = vim.loop.fs_stat(file)
    if not stats then return "" end
    
    local mod = stats.mode
    
    -- Convert to rwx format
    local result = ""
    local rwx = {"---", "--x", "-w-", "-wx", "r--", "r-x", "rw-", "rwx"}
    
    -- User permissions
    local user_perm = math.floor(mod / 64) % 8 + 1
    result = result .. "u:" .. rwx[user_perm]
    
    return result
  end

  -- Session info
  local function session_info()
    local ok, persistence = pcall(require, "persistence")
    if not ok then return "" end
    
    if persistence.current then
      local session_name = vim.fn.fnamemodify(persistence.current, ":t:r")
      return "󰆓 " .. session_name
    end
    return ""
  end
  
  -- Treesitter status
  local function treesitter_status()
    local ok, ts = pcall(require, "nvim-treesitter.parsers")
    if not ok then return "" end
    
    local lang = ts.get_parser(0)
    if not lang then return "No TS" end
    
    return "󰙅 TS"
  end

  -- Show current function/method under cursor
  local function lsp_current_function()
    local ok, gps = pcall(require, "nvim-navic")
    if not ok then return "" end
    local location = gps.get_location()
    if not location or location == "" then return "" end
    return " " .. location
  end

  -- Detect file size and return warning if it's too large
  local function file_size()
    local file = vim.fn.expand("%:p")
    if file == nil or file == "" or file == " " then return "" end
    local size = vim.fn.getfsize(file)
    
    if size <= 0 then
      return ""
    elseif size < 1024 then
      return size .. "B"
    elseif size < 1024 * 1024 then
      return string.format("%.1fKB", size / 1024)
    else
      return string.format("%.1fMB", size / (1024 * 1024))
    end
  end

  -- LSP clients attached to buffer
  local function lsp_clients()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if #clients == 0 then return "No LSP" end
    
    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end
    
    return " " .. table.concat(client_names, ", ")
  end

  -- Detect indentation style
  local function indentation()
    if vim.opt.expandtab:get() then
      return "Spaces: " .. vim.opt.tabstop:get()
    else
      return "Tab: " .. vim.opt.tabstop:get()
    end
  end

  -- Current project info
  local function project_info()
    local cwd = vim.fn.getcwd()
    local project_name = vim.fn.fnamemodify(cwd, ":t")
    return " " .. project_name
  end

  -- Get the current macro recording state
  local function macro_recording()
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
      return "Recording @" .. reg
    end
    return ""
  end

  -- Show word count in certain filetypes
  local function word_count()
    local filetypes = { "markdown", "text", "tex", "md" }
    if not vim.tbl_contains(filetypes, vim.bo.filetype) then
      return ""
    end
    
    return " " .. tostring(vim.fn.wordcount().words) .. " words"
  end

  -- Custom mode indicators with better names
  local mode_map = {
    ['n']    = 'NORMAL',
    ['no']   = 'OP-PENDING',
    ['nov']  = 'OP-PENDING',
    ['noV']  = 'OP-PENDING',
    ['no\22'] = 'OP-PENDING',
    ['niI']  = 'NORMAL',
    ['niR']  = 'NORMAL',
    ['niV']  = 'NORMAL',
    ['v']    = 'VISUAL',
    ['V']    = 'V-LINE',
    ['\22']  = 'V-BLOCK',
    ['s']    = 'SELECT',
    ['S']    = 'S-LINE',
    ['\19']  = 'S-BLOCK',
    ['i']    = 'INSERT',
    ['ic']   = 'INSERT',
    ['ix']   = 'INSERT',
    ['R']    = 'REPLACE',
    ['Rc']   = 'REPLACE',
    ['Rv']   = 'V-REPLACE',
    ['Rx']   = 'REPLACE',
    ['c']    = 'COMMAND',
    ['cv']   = 'EX',
    ['ce']   = 'EX',
    ['r']    = 'PROMPT',
    ['rm']   = 'MORE',
    ['r?']   = 'CONFIRM',
    ['!']    = 'SHELL',
    ['t']    = 'TERMINAL',
  }

  -- Setup the statusline
  require('lualine').setup({
    options = {
      theme = 'catppuccin',
      globalstatus = true, -- Use global statusline
      icons_enabled = true,
      component_separators = { left = '│', right = '│' }, -- More subtle component separators
      section_separators = { left = '', right = '' },     -- Bold section separators
      disabled_filetypes = {
        statusline = {'dashboard', 'alpha', 'starter'},
        winbar = {'dashboard', 'alpha', 'starter'},
      },
      ignore_focus = {},
      always_divide_middle = true,
      refresh = {
        statusline = 50, -- Faster refresh for more responsive indicators
        tabline = 100,
        winbar = 100,
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            return mode_map[vim.api.nvim_get_mode().mode] or str
          end,
          padding = { left = 1, right = 1 },
          icon = {
            '', -- Custom mode icon
            align = 'left',
            color = { fg = colors.blue, gui = 'bold' },
          },
        },
      },
      lualine_b = {
        {
          'branch',
          icon = '',
          padding = { left = 1, right = 1 },
        },
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
          padding = { left = 1, right = 1 },
        },
        {
          macro_recording,
          color = { fg = colors.red, gui = 'bold' },
        },
        {
          git_blame_line,  -- New component for git blame info
          color = { fg = colors.yellow },
          padding = { left = 1, right = 1 },
          cond = function() 
            return package.loaded['gitsigns'] ~= nil
          end,
        },
      },
      lualine_c = {
        {
          'filetype',
          icon_only = true,
          padding = { left = 1, right = 0 },
        },
        {
          'filename',
          path = 1, -- Show relative path
          symbols = {
            modified = ' [+]',
            readonly = ' [RO]',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
          padding = { left = 0, right = 1 },
        },
        {
          file_size,
          padding = { left = 1, right = 1 },
          color = { fg = colors.green },
        },
        {
          file_permissions, -- New component showing file permissions
          padding = { left = 1, right = 1 },
          color = { fg = colors.orange },
        },
        {
          'searchcount',
          padding = { left = 1, right = 1 },
        },
        { 
          lsp_current_function,
          padding = { left = 1, right = 1 },
          color = { fg = colors.magenta },
        },
      },
      lualine_x = {
        {
          word_count,
          color = { fg = colors.cyan },
          padding = { left = 1, right = 1 },
        },
        {
          'fileformat',
          symbols = {
            unix = 'LF',    -- Unix (LF)
            dos = 'CRLF',   -- Windows (CRLF)
            mac = 'CR',     -- Mac (CR)
          },
          padding = { left = 1, right = 1 },
        },
        {
          'encoding',
          fmt = string.upper,
          padding = { left = 1, right = 1 },
        },
        {
          indentation,
          padding = { left = 1, right = 1 },
          color = { fg = colors.blue },
        },
        {
          treesitter_status, -- New component showing treesitter status
          padding = { left = 1, right = 1 },
          color = { fg = colors.green },
        },
      },
      lualine_y = {
        {
          'diagnostics',
          sources = {'nvim_diagnostic', 'nvim_lsp'},
          sections = {'error', 'warn', 'info', 'hint'},
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ', 
            hint = ' '
          },
          diagnostics_color = {
            error = { fg = colors.red },
            warn = { fg = colors.yellow },
            info = { fg = colors.blue },
            hint = { fg = colors.cyan },
          },
          colored = true,
          update_in_insert = true,
          always_visible = false,
          padding = { left = 1, right = 1 },
        },
        {
          lsp_clients,
          padding = { left = 1, right = 1 },
          color = { fg = colors.violet, gui = 'bold' },
        },
        {
          session_info, -- New component showing session info
          padding = { left = 1, right = 1 },
          color = { fg = colors.magenta },
        },
      },
      lualine_z = {
        {
          system_resources, -- New component showing system resources
          padding = { left = 1, right = 1 },
          color = { fg = colors.orange },
        },
        {
          project_info,
          padding = { left = 1, right = 0 },
          color = { fg = colors.blue, gui = 'bold' },
        },
        {
          'location',
          padding = { left = 1, right = 0 },
        },
        {
          'progress',
          padding = { left = 1, right = 0 },
        },
        {
          current_time, -- New component showing current time
          padding = { left = 1, right = 1 },
          color = { fg = colors.cyan, gui = 'bold' },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {'quickfix', 'trouble', 'fugitive', 'nvim-tree', 'symbols-outline', 'toggleterm', 'oil'},
  })
end
