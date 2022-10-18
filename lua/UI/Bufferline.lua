local _2afile_2a = "/home/truff/.config/nvim/fnl/UI/Bufferline.fnl"
local _2amodule_name_2a = "UI.Bufferline"
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
local bufferline = autoload("bufferline")
do end (_2amodule_locals_2a)["bufferline"] = bufferline
bufferline.setup({separator_style = "slant", diagnostics = "nvim_lsp"})
return _2amodule_2a