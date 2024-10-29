local M = {}
M.select = function()
  local buf = vim.api.nvim_get_current_buf()
  local tsnode = require('ibl.scope').get(buf, require('ibl.config').get_config(buf))

  if tsnode then
    local start_row, _, end_row, end_col = tsnode:range()
    vim.api.nvim_buf_set_mark(buf, '>', start_row + 1, 0, {})
    vim.api.nvim_buf_set_mark(buf, '<', end_row + 1, end_col, {})
    vim.cmd("normal! gv")
  end
end

M.delete = function()
  local buf = vim.api.nvim_get_current_buf()
  local tsnode = require('ibl.scope').get(buf, require('ibl.config').get_config(buf))

  if tsnode then
    local start_row, _, end_row, _ = tsnode:range()
    vim.api.nvim_buf_set_lines(buf, start_row, end_row, false, {})
  end
end

return M
