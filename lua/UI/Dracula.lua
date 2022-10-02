local _2afile_2a = ".config/nvim/fnl/UI/Dracula.fnl"
local _2amodule_name_2a = "UI.Dracula"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
vim.g.italic_comment = true
vim.g.dracula_colors = {bg = "#09090A", menu = "#080a0c", visual = "#272568", selection = "#232057"}
vim.cmd("\n  try \n      colorscheme dracula\n  catch \n      echo \"Error Configuring: dracula.nvim\"\n  endtry")
vim.cmd("highlight debugPC guibg=#10504A")
vim.cmd("highlight TreeSitterContext guibg=#081220")
vim.cmd("highlight TreesitterContextLineNumber guifg=#8A888A gui=underline")
vim.cmd("highlight CopilotSuggestion guifg=#8292B4 guibg=#202A21")
return _2amodule_2a