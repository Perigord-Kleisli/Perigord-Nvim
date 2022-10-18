local _2afile_2a = "/home/truff/.config/nvim/fnl/Lang/Null-ls.fnl"
local _2amodule_name_2a = "Lang.Null-ls"
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
local null_ls = autoload("null-ls")
do end (_2amodule_locals_2a)["null-ls"] = null_ls
do
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local hover = null_ls.builtins.hover
  null_ls.setup({debug = false, sources = {formatting.stylua, formatting.asmfmt, formatting.brittany, formatting.cabal_fmt, formatting.clang_format, formatting.cmake_format, formatting.fnlfmt, formatting.markdownlint, formatting.nixfmt, diagnostics.cppcheck, diagnostics.pylint, diagnostics.luacheck, diagnostics.shellcheck, diagnostics.write_good, code_actions.shellcheck, hover.dictionary, null_ls.builtins.code_actions.gitsigns}})
end
return _2amodule_2a