-- Load default mappings for nvchad
require "nvchad.mappings"

local map = vim.keymap.set

-- Basic editing mappings
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Telescope mappings for fuzzy finding
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Show Buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help Tags" })

-- C/C++ specific mappings
map("n", "<leader>cc", ":Telescope lsp_incoming_calls<CR>", { desc = "C/C++: Show Callers" })
map("n", "<leader>cr", ":Telescope lsp_references<CR>", { desc = "C/C++: Find References" })
map("n", "<leader>ci", ":Telescope lsp_implementations<CR>", { desc = "C/C++: Find Implementations" })
map("n", "<leader>cd", ":Telescope lsp_definitions<CR>", { desc = "C/C++: Find Definitions" })

-- Oil mappings (under leader 'o' to avoid conflicts)
-- Open Oil in normal mode using a dedicated prefix
map("n", "<C-e>", ":Oil<CR>", { desc = "Open Oil Explorer" })
-- Optionally, open Oil in a floating window
map("n", "<leader>ee", function()
  require("oil").open_float()
end, { desc = "Open Oil (Floating)" })
-- Display Oil's keymap help
map("n", "<leader>oh", function()
  require("oil").open_keymaps_help()
end, { desc = "Oil Keymaps Help" })

-- Harpoon file bookmarks (using <leader>m prefix for "mark")
map("n", "<leader>ma", function() require("harpoon.mark").add_file() end, { desc = "Mark File" })
map("n", "<leader>mm", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Marks Menu" })
map("n", "<leader>m1", function() require("harpoon.ui").nav_file(1) end, { desc = "Mark 1" })
map("n", "<leader>m2", function() require("harpoon.ui").nav_file(2) end, { desc = "Mark 2" })
map("n", "<leader>m3", function() require("harpoon.ui").nav_file(3) end, { desc = "Mark 3" })

-- Trouble diagnostics (under <leader>x prefix)
map("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
map("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
map("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })

-- Search and replace with Spectre (using <leader>s prefix)
map("n", "<leader>sr", function() require("spectre").toggle() end, { desc = "Replace in Files" })
map("n", "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,
  { desc = "Replace Current Word" })

-- Session management with Persistence
map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Session" })

-- LSP mappings for navigation and documentation
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })

-- Terminal mapping using toggleterm.nvim
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Toggle comments (if using Comment.nvim)
map("n", "<leader>c", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Toggle Comment" })

-- Terminal escape mapping
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Toggle diagnostic virtual text
map("n", "<leader>e", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
end, { noremap = true, silent = true })

-- Additional LSP mappings for definitions and hovers
map("n", "<leader>o", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "<leader>p", vim.lsp.buf.hover, { desc = "Peek Definition" })

-- Telescope LSP symbol mappings
map("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { desc = "Find Document Symbols" })
map("n", "<leader>fw", ":Telescope lsp_workspace_symbols<CR>", { desc = "Find Workspace Symbols" })

-- Remapped saving: using <leader>w instead of <C-s> to avoid conflicts
map("n", "<leader>w", ":w<CR>", { desc = "Save file (Normal mode)" })
map("i", "<leader>w", "<Esc>:w<CR>i", { desc = "Save file (Insert mode)" })

-- Alternate terminal toggle mapping if desired
map("n", "<C-`>", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- (Optional) Additional mapping for Git integration via LazyGit, if installed
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- Folding with nvim-ufo
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
