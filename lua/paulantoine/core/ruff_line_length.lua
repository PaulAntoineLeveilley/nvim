local function get_ruff_line_length()
  local toml_path = vim.fn.getcwd() .. "/pyproject.toml"
  local f = io.open(toml_path, "r")
  if not f then
    return 88
  end -- valeur par défaut si pas trouvé
  local content = f:read("*a")
  f:close()

  -- Cherche la ligne line-length = <nombre>
  local line = content:match("line%-length%s*=%s*(%d+)")
  if line then
    return tonumber(line)
  else
    return 88
  end
end

-- Autocmd pour Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local limit = get_ruff_line_length()
    vim.opt_local.colorcolumn = tostring(limit)

    -- Highlight rouge pour la ligne colorcolumn
    vim.cmd("highlight ColorColumn ctermbg=red guibg=#FF0000")
  end,
})
