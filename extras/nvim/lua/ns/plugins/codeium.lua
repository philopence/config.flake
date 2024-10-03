-- return {
--   "monkoose/neocodeium",
--   event = "VeryLazy",
--   config = function()
--     local neocodeium = require("neocodeium")
--     neocodeium.setup()
--     vim.keymap.set("i", "<A-f>", neocodeium.accept)
--     vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete)
--   end,
-- }
--
-- return {
--   "monkoose/neocodeium",
--   opts = function()
--     local filetypes = { "lua", "typescript", "typescriptreact", "json", "html", "css" }
--     return {
--       -- manual = true,
--       enabled = function(bufnr)
--         return vim.tbl_contains(filetypes, vim.api.nvim_get_option_value("filetype", { buf = bufnr }))
--       end,
--     }
--   end,
--   event = "VeryLazy",
--   keys = {
--     { "<C-y>", "<Cmd>lua require('neocodeium').accept()<CR>", mode = { "i" } },
--     { "<C-x>", "<Cmd>lua require('neocodeium').cycle_or_complete()<CR>", mode = { "i" } },
--     { "<C-c>", "<Cmd>lua require('neocodeium').clear()<CR>", mode = { "i" } },
--   },
-- }

return {
  "Exafunction/codeium.vim",
  enabled = false,
  event = "InsertEnter",
  config = function()
    vim.g.codeium_disable_bindings = 1

    vim.g.codeium_filetypes_disabled_by_default = true

    vim.g.codeium_filetypes = {
      json = true,
      html = true,
      css = true,
      typescript = true,
      typescriptreact = true,
      lua = true,
    }

    vim.g.codeium_manual = true

    vim.keymap.set("i", "<C-x>", "<Cmd>call codeium#CycleOrComplete()<CR>")
    vim.keymap.set("i", "<C-y>", vim.fn["codeium#Accept"], { expr = true, silent = true })
    vim.keymap.set("i", "<C-c>", "<Cmd>call codeium#Clear()<CR>")
  end,
}
