require "nvchad.mappings"

local map = vim.keymap.set

-- Enter command mode quickly with ';'
map("n", ";", ":", { desc = "Enter command mode" })

-- Exit insert mode using 'jk'
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Toggle file explorer (NvimTree)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Telescope key mappings for fuzzy finding:
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Show Buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help Tags" })

-- LSP mappings for navigation and documentation:
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })

-- Toggle integrated terminal (using toggleterm.nvim)
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Toggle comments (if using Comment.nvim)
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Toggle Comment" })
