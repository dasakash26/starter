require "nvchad.mappings"

local map = vim.keymap.set

-- Normal Mode mappings
map("n", "<leader>s", ":w<CR>", { desc = "Save file (Normal mode)" })

-- Insert Mode mappings
map("i", "jk", "<ESC>")
map("i", "<leader>s", "<Esc>:w<CR>i", { desc = "Save file (Insert mode)" })

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

map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition", silent = true })
map("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "Finder: Def/Impl/Refs" })
map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Symbol Outline" })
map("n", "<leader>fi", ":Telescope import<CR>", { desc = "Telescope: Import missing modules" })
map("n", "<leader><Leader>", ":Telescope find_files<CR>", { desc = "Telescope: Find Files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope: Live Grep" })

-- codeforces
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

-- yank file
map("n", "<leader>yy", 'ggVG"+y', { desc = "Yank full file to clipboard" })

-- copilot
local function toggle_copilot()
  local copilot_enabled = vim.fn["copilot#Enabled"]()
  if copilot_enabled == 1 then
    vim.cmd "Copilot disable"
    print "Copilot Disabled"
  else
    vim.cmd "Copilot enable"
    print "Copilot Enabled"
  end
end

map("n", "<leader>cs", "<Plug>(copilot-suggest)", { desc = "Copilot Manually Trigger Suggestion" })
map("n", "<leader>ct", toggle_copilot, { silent = true, desc = "Copilot Toggle On/Off" })
map("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = "Copilot Accept Suggestion",
})
map("i", "<Right>", 'copilot#Accept("\\<Right>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = "Copilot Accept / Cursor Right",
})

-- tab fix
map("i", "<Tab>", "    ", { noremap = true, silent = true })
map("i", "<C-e>", function()
  if require("luasnip").expandable() then
    require("luasnip").expand()
  end
end, { silent = true, desc = "Expand Snippet" })

map({ "i", "s" }, "<C-f>", function()
  if require("luasnip").jumpable(1) then
    require("luasnip").jump(1)
  end
end, { silent = true, desc = "Snippet Jump Forward" })

map({ "i", "s" }, "<C-b>", function()
  if require("luasnip").jumpable(-1) then
    require("luasnip").jump(-1)
  end
end, { silent = true, desc = "Snippet Jump Backward" })
