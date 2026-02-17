vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs and indentaion
opt.tabstop = 2 --spaces for tab
opt.shiftwidth = 2 --2 spaces for indent width
opt.expandtab = true --expand tab to spaces
opt.autoindent = true --copy indent from curent line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true --ignore case when searching
opt.smartcase = true --if you include mixed case in search assumes you want case sensitive

opt.cursorline = true

--colors
opt.termguicolors = true
opt.background = "light"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start" --allow backspace to work as intended

--clipboard
opt.clipboard:append("unnamedplus")

--split windows
opt.splitright = true --split vertical window to the right
opt.splitbelow = true --split horizontal window to the bottom

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "text", "python" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Formatter SQL sur une sélection ou plage de lignes
vim.api.nvim_create_user_command("FormatSQL", function(opts)
  local range = string.format("%d,%d", opts.line1, opts.line2)
  vim.cmd(range .. "!sql-formatter --language postgresql")
end, { range = true })
