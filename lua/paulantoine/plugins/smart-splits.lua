return {
  "mrjones2014/smart-splits.nvim",
  init = function()
    -- recommended mappings
    -- resizing splits
    -- these keymaps will also accept a range,
    -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
    vim.keymap.set("n", "<A-Left>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-Down>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-Up>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-Right>", require("smart-splits").resize_right)
  end,
}
