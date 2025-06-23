require "nvchad.mappings"

local map = vim.keymap.set

-- Normal Mode mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file (Normal mode)" })

-- Insert Mode mappings
map("i", "jk", "<ESC>")
map("i", "<leader>w", "<Esc>:w<CR>i", { desc = "Save file (Insert mode)" })

-- Terminal Mode: Escape to Normal
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- LSP Mappings (Native)
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to References" })
map("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Lspsaga-enhanced
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
map("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "Finder: Def/Impl/Refs" })
map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Symbol Outline" })
