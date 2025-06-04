vim.g.mapleader = " "

local keymap = vim.keymap --for conciseness

keymap.set("i", "<leader>jk", "<ESC>", {desc = "Exit insert mode with jk"})

keymap.set("n","<leader>nh", ":nolh<CR>", {desc= "clear search history highlights"})


