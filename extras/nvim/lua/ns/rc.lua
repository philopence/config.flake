-- global variables.
-- options
-- keymaps
-- autocmds
-- diagnostics
-- filetypes

-- ### GLOBAL VARIABLES ###

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ### OPTIONS ###

local options = {
  termguicolors = true,
  showcmd = false,
  showmode = false,
  showmatch = false,
  ruler = false,
  cursorline = true,
  list = true,
  listchars = "tab:▸ ,trail:·,extends:…,precedes:…,nbsp:␣,conceal:…", -- tab: ⭲
  fillchars = "fold: ,eob: ",
  wrap = true,
  linebreak = true,
  breakindent = true,
  ignorecase = true,
  infercase = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  scrolloff = 5,
  sidescrolloff = 5,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 0,
  softtabstop = -1,
  updatetime = 100,
  timeoutlen = 500,
  undofile = true,
  laststatus = 3,
  -- statusline = "%F%m%r%=%c/%l:%L %P",
  -- winbar = "%t%m%r",
  mouse = "",
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  cmdheight = 0,
  jumpoptions = "stack",
  completeopt = "menu,menuone,noinsert",
  pumheight = 9,
  foldtext = "",
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  -- foldenable = false,
  foldlevel = 1024,
  -- foldcolumn = "1",
}

for k, v in pairs(options) do
  vim.api.nvim_set_option_value(k, v, {})
end

-- ### KEYMAPS ###

for _, key in ipairs({
  " ",
  "s",
  "S",
  "<BS>",
}) do
  vim.keymap.set({ "n", "x" }, key, "<NOP>")
end

vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- COLEMAK-DH
for _, key in ipairs({ "<Down>", "<Up>" }) do
  vim.keymap.set({ "n", "x" }, key, function()
    return vim.v.count == 0 and "g" .. key or key
  end, { expr = true })
end

vim.keymap.set("n", "U", "<Cmd>redo<CR>")

vim.keymap.set("n", "<Esc>", "<Cmd>nohls<CR>")

vim.keymap.set({ "n", "x" }, "gy", '"+y')
vim.keymap.set("n", "gp", '"+p')
vim.keymap.set("x", "gp", '"+P')

vim.keymap.set("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true })

-- vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

vim.keymap.set("n", "go", function()
  vim.fn.append(vim.fn.line(".") or 0, vim.fn["repeat"]({ "" }, vim.v.count1))
end, {})
vim.keymap.set("n", "gO", function()
  vim.fn.append(vim.fn.line(".") - 1, vim.fn["repeat"]({ "" }, vim.v.count1))
end, {})

vim.keymap.set("n", "<C-Down>", "<Cmd>wincmd w<CR>")
vim.keymap.set("n", "<C-Up>", "<Cmd>wincmd W<CR>")
vim.keymap.set("n", "<C-Left>", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "<C-Right>", "<Cmd>tabnext<CR>")

vim.keymap.set("n", "gI", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end)

-- ### AUTOCMDS ###

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("ns/colorscheme", {}),
  callback = function(ev)
    if ev.match == "default" and vim.o.background == "dark" then
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimDarkGrey3" })
      vim.api.nvim_set_hl(0, "CursorLine", { link = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "NvimDarkGrey4", bg = "NvimDarkGrey2" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NvimDarkGrey2" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "NvimDarkGrey3" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "NvimLightYellow", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "NvimLightYellow", bold = true })
      vim.api.nvim_set_hl(0, "TabLine", { fg = "NvimLightGrey4", bg = "NvimDarkGrey2" })
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("ns/disable_inlay_hint", {}),
  desc = "disable inlay hint",
  callback = function()
    vim.lsp.inlay_hint.enable(false)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("ns/yank_highlight", {}),
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("ns/last_location", {}),
  desc = "Go to the last location when opening a buffer",
  callback = function()
    vim.fn.setpos(".", vim.fn.getpos([['"]]))
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
    vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
  end,
})

-- ### DIAGNOSTICS ###

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  float = {
    border = "rounded",
    source = true,
  },
})

-- ### FILETYPES ###

vim.filetype.add({
  extension = {
    ["http"] = "http",
    ["mdx"] = "mdx",
  },
})

vim.treesitter.language.register("markdown", { "mdx" })
