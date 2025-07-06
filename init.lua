require("paulantoine.core")
require("paulantoine.lazy")

vim.opt.fillchars = {
  foldopen = "", -- flèche vers le bas : bloc déplié
  foldclose = "", -- flèche vers la droite : bloc plié
  fold = " ", -- caractère de remplissage à l'intérieur du pli
  foldsep = " ", -- séparateur vertical, ici invisible
  eob = " ", -- cacher les ~ à la fin du buffer
}
