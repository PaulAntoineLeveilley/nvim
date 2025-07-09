return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    -- Setup hlslens
    require("hlslens").setup()

    local kopts = { noremap = true, silent = true }

    -- Raccourcis
    vim.keymap.set("n", "n", function()
      vim.cmd("execute('normal! ' .. v:count1 .. 'n')")
      require("hlslens").start()
    end, kopts)

    vim.keymap.set("n", "N", function()
      vim.cmd("execute('normal! ' .. v:count1 .. 'N')")
      require("hlslens").start()
    end, kopts)

    vim.keymap.set("n", "*", function()
      vim.cmd("normal! *")
      require("hlslens").start()
    end, kopts)

    vim.keymap.set("n", "#", function()
      vim.cmd("normal! #")
      require("hlslens").start()
    end, kopts)

    vim.keymap.set("n", "g*", function()
      vim.cmd("normal! g*")
      require("hlslens").start()
    end, kopts)

    vim.keymap.set("n", "g#", function()
      vim.cmd("normal! g#")
      require("hlslens").start()
    end, kopts)

    -- Clear search highlight
    vim.keymap.set("n", "<Leader>nh", "<Cmd>noh<CR>", kopts)
  end,
}
