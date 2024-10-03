local M = {}

function M.setup()
  require("ns.rc")
  require("ns.tabline")
  require("ns.lazy").setup()

  vim.cmd.colorscheme(vim.env.PALETTE or "default")
end

return M
