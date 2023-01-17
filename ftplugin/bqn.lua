local hydra = require("Mapping.Lang")
local cmd = (require("hydra.keymap-util")).cmd
local const_eval_3f = true
local function constant_eval()
  if ((vim.bo.filetype == "bqn") and const_eval_3f) then
    local bqn = require("bqn")
    return bqn.evalBQN(0, (vim.api.nvim_win_get_cursor(0))[1])
  else
    return nil
  end
end
local function toggle_const_eval()
  do
    local bqn = require("bqn")
    if ((vim.bo.filetype == "bqn") and const_eval_3f) then
      bqn.clearBQN(0, (vim.api.nvim_win_get_cursor(0))[1])
    else
      bqn.evalBQN(0, (vim.api.nvim_win_get_cursor(0))[1])
    end
  end
  const_eval_3f = not const_eval_3f
  return nil
end
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {callback = constant_eval})
local function clear_bqn()
  local bqn = require("bqn")
  local _let_3_ = vim.api.nvim_win_get_cursor(0)
  local line = _let_3_[1]
  return bqn.clearBQN(math.max(0, (line - 1)), line)
end
vim.api.nvim_set_keymap("n", "K", cmd("BQNExplain"), {desc = "Explain expression"})
vim.keymap.set("n", "<C-CR>", clear_bqn, {desc = "Close result"})
hydra({["extra-heads"] = {{"E", toggle_const_eval, {desc = "Toggle constant evaluation", exit = true}}, {"c", cmd("BQNClearAfterLine"), {desc = "Clear all results past cursor", exit = true}}, {"C", cmd("BQNClearFile"), {desc = "Clear all results in file", exit = true}}}})
return vim.diagnostic.hide()
