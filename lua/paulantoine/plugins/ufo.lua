return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      -- Optionnel : 'neoclide/coc.nvim' si tu veux utiliser coc comme LSP client
    },
    event = "BufReadPost",
    config = function()
      -- Options de repliement
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Raccourcis clavier
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
