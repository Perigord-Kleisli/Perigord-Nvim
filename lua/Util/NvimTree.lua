local _2afile_2a = "fnl/Util/NvimTree.fnl"
local _2amodule_name_2a = "Util.NvimTree"
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
local nvim_tree = autoload("nvim-tree")
do end (_2amodule_locals_2a)["nvim-tree"] = nvim_tree
nvim_tree.setup({update_focused_file = {enable = true}, diagnostics = {enable = true, show_on_dirs = true}, renderer = {add_trailing = true, group_empty = true, highlight_opened_files = "all"}})
return _2amodule_2a