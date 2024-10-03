return {
  "stevearc/quicker.nvim",
  enabled = false,
  event = "FileType qf",
  opts = {},
  keys = {
    {
      "<leader>xq",
      function()
        require("quicker").toggle()
      end,
      desc = "Toggle quickfix",
    },
    {
      "<leader>xl",
      function()
        require("quicker").toggle({ loclist = true })
      end,
      desc = "Toggle loclist list",
    },
  },
}
