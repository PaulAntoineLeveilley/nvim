return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({})
    vim.keymap.set("n", "<leader>K", "<cmd>Lspsaga hover_doc<CR>")
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
