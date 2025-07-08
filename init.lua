require("paulantoine.core")
require("paulantoine.lazy")

vim.opt.fillchars = {
  foldopen = "", -- flèche vers le bas : bloc déplié
  foldclose = "", -- flèche vers la droite : bloc plié
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "Outline",
  callback = function()
    vim.defer_fn(function()
      if vim.bo.filetype == "Outline" then
        vim.opt_local.relativenumber = true
      end
    end, 0)
  end,
})
