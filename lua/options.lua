require "nvchad.options"

-- add yours here!
local opt = vim.opt

-- Performance options
opt.lazyredraw = true -- Don't redraw while executing macros
opt.synmaxcol = 240   -- Max column for syntax highlight
opt.updatetime = 300  -- Faster completion and better UX
opt.timeoutlen = 300  -- Faster key sequence completion

-- Development options
opt.scrolloff = 8                         -- Lines of context when scrolling
opt.sidescrolloff = 8                     -- Columns of context when scrolling
opt.signcolumn = "yes"                    -- Always show the signcolumn
opt.completeopt = "menu,menuone,noselect" -- Better completion experience

-- C/C++ specific options
opt.formatoptions:append("c") -- Auto-wrap comments using textwidth
opt.formatoptions:append("q") -- Allow formatting comments with 'gq'
opt.formatoptions:append("j") -- Remove comment leader when joining lines

-- Show pressed keys in the command line
opt.showcmd = true
opt.showcmdloc = "statusline" -- Show in the status line (Neovim feature)

-- Suppress various messages
opt.shortmess:append("s") -- Don't show "search hit BOTTOM" messages
opt.shortmess:append("I") -- Don't show intro message
opt.shortmess:append("c") -- Don't show ins-completion messages
opt.shortmess:append("W") -- Don't show "written" messages

-- Don't show message on save
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function() vim.cmd("echon ''") end,
})

vim.o.foldcolumn = '1'  -- '0' to hide, '1' or '2' to show fold column
vim.o.foldlevel = 99    -- ensure all folds are open
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- enable folding
