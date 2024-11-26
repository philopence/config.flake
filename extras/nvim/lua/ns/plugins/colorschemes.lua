return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      styles = {
        italic = true,
      },
      highlight_groups = {
        NormalFloat = { fg = "text", bg = "base" },
        FloatBorder = { fg = "highlight_high", bg = "base" },
        TelescopeBorder = { link = "FloatBorder" },
        CmpItemKindField = { link = "@field" },
        CmpItemKindKeyword = { link = "@keyword" },
      },
    },
  },
  {
    "savq/melange-nvim",
    priority = 1000,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    priority = 1000,
    config = function()
      vim.g.moonflyItalics = false

      local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "moonfly",
        callback = function()
          vim.api.nvim_set_hl(0, "VertSplit", { fg = "#2e2e2e", bg = "#080808" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#080808" })
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#80a0ff" })
          vim.api.nvim_set_hl(0, "CursorLine", { link = "NONE" })
          vim.api.nvim_set_hl(0, "DocBorder", { fg = "#2e2e2e", bg = "#080808" })
          vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#2e2e2e", bg = "#080808" })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#c6c6c6", bg = "#323437" })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = "#c6c6c6", bg = "#323437" })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = "#c6c6c6", bg = "#323437" })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = "#c6c6c6", bg = "#323437" })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = "#c6c6c6", bg = "#323437" })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = "#c6c6c6", bg = "#323437" })
          vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = "#c6c6c6", bg = "#2e2e2e" })
          vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = "#c6c6c6", bg = "#2e2e2e" })
          vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#c6c6c6", bg = "#2e2e2e" })
          -----------------------------
          -- borderless
          -- vim.api.nvim_set_hl(0, "DocNormal", { bg = "#121212" })
          -- vim.api.nvim_set_hl(0, "DocBorder", { fg = "#121212", bg = "#121212" })
          -- vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#161616" })
          -- vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#161616", bg = "#161616" })
          -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#121212", bg = "#121212" })
          -- vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
          -- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#080808" })
          -- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#080808", bg = "#36c692" })
          -- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#1C1C1C", bg = "#080808" })
        end,
        group = custom_highlight,
      })
    end,
  },
}
