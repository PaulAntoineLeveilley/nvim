local M = {}

local ruff_cache = {}

local function find_ruff_root(path)
  return vim.fs.root(path, {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  })
end

local function can_use_project_ruff(root)
  if not root then
    return false
  end

  if ruff_cache[root] ~= nil then
    return ruff_cache[root]
  end

  local uv = vim.fn.exepath("uv")
  if uv == "" then
    ruff_cache[root] = false
    return false
  end

  local result = vim
    .system({ uv, "run", "--no-sync", "ruff", "--version" }, {
      cwd = root,
      text = true,
    })
    :wait()

  local ok = result.code == 0
  ruff_cache[root] = ok
  return ok
end

local function get_uvx()
  local uvx = vim.fn.exepath("uvx")
  if uvx == "" then
    return nil
  end

  return uvx
end

local function get_path(path)
  if path and path ~= "" then
    return path
  end

  return vim.api.nvim_buf_get_name(0)
end

function M.get_ruff_runner(path)
  local root = find_ruff_root(get_path(path))
  local uvx = get_uvx()

  if uvx then
    return {
      root = root,
      command = uvx,
      prefix_args = { "ruff" },
      uses_uvx = true,
      uses_uv = false,
    }
  end

  if can_use_project_ruff(root) then
    return {
      root = root,
      command = vim.fn.exepath("uv"),
      prefix_args = { "run", "--no-sync", "ruff" },
      uses_uvx = false,
      uses_uv = true,
    }
  end

  return {
    root = root,
    command = vim.fn.exepath("ruff") ~= "" and vim.fn.exepath("ruff") or "ruff",
    prefix_args = {},
    uses_uvx = false,
    uses_uv = false,
  }
end

function M.get_ruff_lsp_cmd(path)
  local runner = M.get_ruff_runner(path)
  local cmd = vim.deepcopy(runner.prefix_args)
  table.insert(cmd, "server")

  if runner.uses_uvx or runner.uses_uv then
    table.insert(cmd, 1, runner.command)
    return cmd
  end

  return { runner.command, "server" }
end

function M.get_ruff_debug_info(path)
  local target = get_path(path)
  local root = find_ruff_root(target)
  local runner = M.get_ruff_runner(target)
  local lsp_cmd = M.get_ruff_lsp_cmd(target)
  local lsp_clients = vim.lsp.get_clients({ bufnr = 0, name = "ruff" })
  local active_lsp_cmd = nil

  if #lsp_clients > 0 then
    active_lsp_cmd = lsp_clients[1].config.cmd
  end

  return {
    buffer = target,
    cwd = vim.fn.getcwd(),
    root = root,
    uvx = get_uvx(),
    uv = vim.fn.exepath("uv"),
    system_ruff = vim.fn.exepath("ruff"),
    uses_uvx = runner.uses_uvx,
    uses_uv = runner.uses_uv,
    formatter_command = runner.command,
    formatter_args_prefix = runner.prefix_args,
    resolved_format_example = vim.list_extend(vim.deepcopy(runner.prefix_args), { "check", "--fix" }),
    configured_lsp_cmd = lsp_cmd,
    active_lsp_cmd = active_lsp_cmd,
    cache = root and ruff_cache[root] or nil,
  }
end

function M.debug_current_buffer()
  local info = M.get_ruff_debug_info()
  vim.notify(vim.inspect(info), vim.log.levels.INFO, { title = "Ruff debug" })
  return info
end

function M.reset_ruff_cache()
  ruff_cache = {}
  vim.notify("Ruff project cache cleared", vim.log.levels.INFO, { title = "Ruff debug" })
end

function M.setup()
  vim.api.nvim_create_user_command("RuffDebug", function()
    M.debug_current_buffer()
  end, { desc = "Show the resolved Ruff command for the current buffer" })

  vim.api.nvim_create_user_command("RuffDebugReset", function()
    M.reset_ruff_cache()
  end, { desc = "Clear cached Ruff project detection" })
end

return M
