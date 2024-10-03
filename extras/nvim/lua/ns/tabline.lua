-- ### TABLINE ###
local M = {}

function M.render()
  local tabpages = vim.api.nvim_list_tabpages()
  local cur_tabpage = vim.api.nvim_get_current_tabpage()
  local items = {}
  for _, tabpage in ipairs(tabpages) do
    local win = vim.api.nvim_tabpage_get_win(tabpage)
    local num = vim.api.nvim_tabpage_get_number(tabpage)
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    local filename = vim.fn.fnamemodify(name, ":t")

    filename = #filename == 0 and "[No Name]" or filename

    local hl_group = tabpage == cur_tabpage and "TabLineSel" or "TabLine"

    table.insert(items, string.format("%%#%s# %s: %s %%*", hl_group, num, filename))
  end

  return table.concat(items, "")
end

M.render()

vim.api.nvim_set_option_value("tabline", "%{%v:lua.require('ns.tabline').render()%}", {})

return M
