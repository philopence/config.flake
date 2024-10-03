local prettier = { "prettierd", "prettier", stop_after_first = true }

local formatters_by_ft = vim.tbl_deep_extend(
  "force",
  {
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
  },
  vim
    .iter({
      "json",
      "html",
      "css",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "astro",
      "markdown",
    })
    :fold({}, function(acc, v)
      acc[v] = prettier
      return acc
    end)
)

return {
  "stevearc/conform.nvim",
  ft = vim.tbl_keys(formatters_by_ft),
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  keys = {
    {
      "<Leader>cf",
      function()
        require("conform").format()
      end,
    },
  },
  opts = {
    formatters_by_ft = formatters_by_ft,
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
}
