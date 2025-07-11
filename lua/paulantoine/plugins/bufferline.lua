return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
    },
  },
  config = function()
    require("bufferline").setup({
      options = {
        separator_style = "slant", -- tu peux changer ici
      },
    })
  end,
}
