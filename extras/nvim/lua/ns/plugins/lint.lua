local eslint_d = { "eslint_d" }

local linters_by_ft = vim
  .iter({ "javascript", "javascriptreact", "typescript", "typescriptreact" })
  :fold({}, function(acc, v)
    acc[v] = eslint_d
    return acc
  end)

return {
  "mfussenegger/nvim-lint",
  enabled = false,
  ft = vim.tbl_keys(linters_by_ft),
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = linters_by_ft,
  },
  config = function(_, opts)
    require("lint").linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("ns/linter", {}),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
