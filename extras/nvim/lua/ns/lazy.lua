local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

function M.setup()
  require("lazy").setup({
    spec = {
      { import = "ns.plugins" },
    },
    defaults = {
      lazy = true,
    },
    install = {
      colorscheme = { "default" },
    },
    change_detection = {
      notify = false,
    },
  })
end

return M
