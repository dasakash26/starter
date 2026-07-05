require "nvchad.mappings"

local map = vim.keymap.set

-- Editing basics.
-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "j", "gj", { noremap = true, silent = true })
map("n", "k", "gk", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down + center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up + center" })
map("n", "<C-f>", "<C-f>zz", { desc = "Page down + center" })
map("n", "<C-b>", "<C-b>zz", { desc = "Page up + center" })

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Search and navigation.
map("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep (text)" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- LSP lookup and diagnostics.
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Symbols (document)" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Symbols (workspace)" })
map("n", "<leader>dl", function()
  require("configs.lsp_lines").open_float()
end, { desc = "Line diagnostic" })
map("n", "<leader>dp", "<cmd>PrettyTsError<CR>", { desc = "TS error popup" })
map("n", "<leader>dP", "<cmd>PrettyTsErrors<CR>", { desc = "TS errors list" })
map("n", "<leader>du", "<cmd>PrettyTsToggleAuto<CR>", { desc = "Toggle TS error popup" })

-- Code helpers.
map("n", "<leader>fi", function()
  require("lazy").load { plugins = { "telescope-import.nvim" }, wait = true }
  vim.cmd "Telescope import"
end, { desc = "Imports" })

-- File-level utility mappings.
map("n", "<leader>yy", 'ggVG"+y', { desc = "Yank full file to clipboard" })
map("n", "<leader>yf", function()
  vim.notify(vim.fn.expand "%:p")
end, { desc = "Show current file path" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")

-- LSP lines are intentionally opt-in to keep diagnostics quiet by default.
map("n", "<leader>l", function()
  require("configs.lsp_lines").toggle()
end, { desc = "Toggle LSP lines" })

-- Trouble and TODO navigation. Use <leader>d* to avoid NvChad's <leader>x buffer close.
map("n", "<leader>dd", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<leader>dD", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
map("n", "<leader>do", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols" })
map("n", "<leader>dr", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "LSP references" })
map("n", "<leader>dq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix" })

-- File tree.
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })

-- Move buffers in tabufline.
map("n", "<A-S-h>", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "Move buffer left" })
map("n", "<A-S-l>", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "Move buffer right" })
map("n", "<leader>bh", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "Move buffer left" })
map("n", "<leader>bl", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "Move buffer right" })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Competitive programming.
map("n", "<leader>tr", "<cmd>CompetiTest run<CR>", { desc = "Run Testcases", noremap = true, silent = true })
map("n", "<leader>ta", "<cmd>CompetiTest add_testcase<CR>", { desc = "Add Testcase", noremap = true, silent = true })
map("n", "<leader>te", "<cmd>CompetiTest edit_testcase<CR>", { desc = "Edit Testcase", noremap = true, silent = true })
map(
  "n",
  "<leader>td",
  "<cmd>CompetiTest delete_testcase<CR>",
  { desc = "Delete Testcase", noremap = true, silent = true }
)

map(
  "n",
  "<leader>tp",
  "<cmd>CompetiTest receive problem<CR>",
  { desc = "Receive Problem", noremap = true, silent = true }
)
map(
  "n",
  "<leader>tc",
  "<cmd>CompetiTest receive contest<CR>",
  { desc = "Receive Contest", noremap = true, silent = true }
)
map(
  "n",
  "<leader>ts",
  "<cmd>CompetiTest receive testcases<CR>",
  { desc = "Receive Testcases", noremap = true, silent = true }
)

map(
  "n",
  "<leader>tS",
  "<cmd>CompetiTest receive status<CR>",
  { desc = "Receive Status", noremap = true, silent = true }
)
map(
  "n",
  "<leader>tP",
  "<cmd>CompetiTest receive persistently<CR>",
  { desc = "Start Persistent Receive", noremap = true, silent = true }
)
map("n", "<leader>tX", "<cmd>CompetiTest receive stop<CR>", { desc = "Stop Receiving", noremap = true, silent = true })
