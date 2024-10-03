-- TODO https://github.com/mistweaverco/kulala.nvim/issues/78
return {
  "mistweaverco/kulala.nvim",
  -- enabled = false,
  -- dir = "~/Documents/kulala.nvim",
  opts = {
    default_view = "headers_body",
    icons = {
      inlay = {
        loading = "󰔟 ",
        done = "󰂞 ",
        error = " ",
      },
      lualine = "🐼",
    },
  },
  ft = "http",
  keys = {
    { "<leader>rs", "<Cmd>lua require('kulala').run()<CR>", desc = "Send the request" },
    { "<leader>rt", "<Cmd>lua require('kulala').toggle_view()<CR>", desc = "Toggle headers/body" },
    { "<leader>rp", "<Cmd>lua require('kulala').jump_prev()<CR>", desc = "Jump to previous request" },
    { "<leader>rn", "<Cmd>lua require('kulala').jump_next()<CR>", desc = "Jump to next request" },
  },
}
