local _2afile_2a = "fnl/UI/Indent-Blankline.fnl"
local _2amodule_name_2a = "UI.Indent-Blankline"
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
local indent_blankline = autoload("indent_blankline")
do end (_2amodule_locals_2a)["indent-blankline"] = indent_blankline
vim.opt.termguicolors = true
vim.opt.list = true
do end (vim.opt.listchars):append("space:\226\139\133")
do end (vim.opt.listchars):append("eol:\226\134\180")
vim.g.indentLine_char_list = {"\226\139\133", "\226\148\134", "\226\148\138", "|", "\194\166", "\194\166", "\194\166"}
vim.g.indentLine_enabled = 1
indent_blankline.setup({show_end_of_line = true, show_current_context = true, show_current_context_start = true})
return _2amodule_2a