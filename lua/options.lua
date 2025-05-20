require "nvchad.options"

-- add yours here!
local opt = vim.opt

-- Performance options
opt.lazyredraw = true           -- Don't redraw while executing macros
opt.synmaxcol = 240             -- Max column for syntax highlight
opt.updatetime = 300            -- Faster completion and better UX
opt.timeoutlen = 300            -- Faster key sequence completion

-- Development options
opt.scrolloff = 8               -- Lines of context when scrolling
opt.sidescrolloff = 8           -- Columns of context when scrolling
opt.signcolumn = "yes"          -- Always show the signcolumn
opt.completeopt = "menu,menuone,noselect"  -- Better completion experience

-- C/C++ specific options
opt.formatoptions:append("c")   -- Auto-wrap comments using textwidth
opt.formatoptions:append("q")   -- Allow formatting comments with 'gq'
opt.formatoptions:append("j")   -- Remove comment leader when joining lines
