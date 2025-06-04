vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs and indentaion
opt.tabstop = 2 --spaces for tab
opt.shiftwidth = 2 --2 spaces for indent width
opt.expandtab = true --expand tab to spaces
opt.autoindent  = true --copy indent from curent line when starting new one

-- search settings
opt.ignorecase = true --ignore case when searching
opt.smartcase = true --if you include mixed case in search assumes you want case sensitive
