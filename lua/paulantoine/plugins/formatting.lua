return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local python_tools = require("paulantoine.core.python_tools")

    local function ruff_args(ctx, subcommand, extra_args)
      local runner = python_tools.get_ruff_runner(ctx.filename)
      local args = vim.deepcopy(runner.prefix_args)

      table.insert(args, subcommand)
      vim.list_extend(args, extra_args)

      return args
    end

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        cmake = { "cmake-format" },
        python = { "ruff_fix", "ruff_format" },
        tex = { "tex-fmt" },
        plaintex = { "tex-fmt" },
      },
      formatters = {
        ruff_fix = {
          command = function(_, ctx)
            return python_tools.get_ruff_runner(ctx.filename).command
          end,
          args = function(_, ctx)
            return ruff_args(ctx, "check", {
              "--fix",
              "--force-exclude",
              "--exit-zero",
              "--no-cache",
              "--stdin-filename",
              "$FILENAME",
              "-",
            })
          end,
          stdin = true,
          cwd = function(_, ctx)
            return python_tools.get_ruff_runner(ctx.filename).root
          end,
        },
        ruff_format = {
          command = function(_, ctx)
            return python_tools.get_ruff_runner(ctx.filename).command
          end,
          args = function(_, ctx)
            return ruff_args(ctx, "format", {
              "--force-exclude",
              "--stdin-filename",
              "$FILENAME",
              "-",
            })
          end,
          range_args = function(_, ctx)
            return ruff_args(ctx, "format", {
              "--force-exclude",
              "--range",
              string.format(
                "%d:%d-%d:%d",
                ctx.range.start[1],
                ctx.range.start[2] + 1,
                ctx.range["end"][1],
                ctx.range["end"][2] + 1
              ),
              "--stdin-filename",
              "$FILENAME",
              "-",
            })
          end,
          stdin = true,
          cwd = function(_, ctx)
            return python_tools.get_ruff_runner(ctx.filename).root
          end,
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
