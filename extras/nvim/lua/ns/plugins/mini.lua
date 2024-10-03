return {
  -- TODO https://github.com/echasnovski/mini.nvim/issues/886
  -- {
  --   "echasnovski/mini.completion",
  --   event = "InsertEnter",
  --   opts = {},
  -- },
  {
    "echasnovski/mini.ai",
    opts = {},
    event = { "BufRead", "BufNewFile" },
  },

  {
    "echasnovski/mini-git",
    opts = {},
    main = "mini.git",
    event = { "BufRead", "BufNewFile" },
  },

  {
    "echasnovski/mini.diff",
    opts = {
      view = { style = "sign", priority = 9 },
    },
    event = { "BufRead", "BufNewFile" },
    keys = {
      { "<Leader>D", "<Cmd>lua MiniDiff.toggle_overlay()<CR>" },
    },
  },

  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".env"] = { glyph = "" },
      },
      filetype = {
        ["c"] = { glyph = "" },
      },
    },
    event = "VimEnter",
    config = function(_, opts)
      local mini_icons = require("mini.icons")
      mini_icons.setup(opts)
      mini_icons.mock_nvim_web_devicons()
    end,
  },

  {
    "echasnovski/mini.animate",
    opts = {},
    event = { "BufRead", "BufNewFile" },
  },

  {
    "echasnovski/mini.hipatterns",
    opts = function()
      local hipatterns = require("mini.hipatterns")
      return {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
    event = { "BufRead", "BufNewFile" },
  },

  {
    "echasnovski/mini.statusline",
    opts = {
      set_vim_settings = false,
    },
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.operators",
    opts = {
      replace = { prefix = "" },
    },
    keys = {
      { "g=", mode = { "n", "x" } },
      { "gx", mode = { "n", "x" } },
      { "gm", mode = { "n", "x" } },
      -- { "gr", mode = { "n", "x" } },
      -- { "gs", mode = { "n", "x" } },
    },
  },

  {
    "echasnovski/mini.splitjoin",
    opts = {},
    keys = {
      { "gS", mode = { "n", "x" } },
    },
  },

  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "x" } },
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {},
    keys = {
      { "sa", mode = { "n", "x" } },
      { "sd" },
      { "sr" },
      { "sh" },
      { "sf" },
      { "sF" },
    },
  },
}
