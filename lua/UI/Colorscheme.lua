local _2afile_2a = "fnl/UI/Colorscheme.fnl"
local _2amodule_name_2a = "UI.Colorscheme"
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
local autoload = (require("aniseed.autoload")).autoload
local dracula = autoload("dracula")
do end (_2amodule_locals_2a)["dracula"] = dracula
dracula.setup({colors = {bg = "#09090A", menu = "#080a0c", visual = "#272568", selection = "#232057"}, italic_comment = true})
vim.cmd("\n  try \n      colorscheme dracula\n  catch \n      echo \"Error Configuring: dracula.nvim\"\n  endtry")
vim.cmd("highlight debugPC guibg=#10504A")
vim.cmd("highlight TreeSitterContext guibg=#081220")
vim.cmd("highlight TreesitterContextLineNumber guifg=#8A888A gui=underline")
vim.g.gitblame_highlight_group = "NonText"
vim.g.gitblame_ignored_filetypes = {"NvimTree", "TelescopePrompt"}
return _2amodule_2a