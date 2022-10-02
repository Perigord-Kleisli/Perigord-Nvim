local _2afile_2a = "fnl/Lang/CodeRunner.fnl"
local _2amodule_name_2a = "Lang.CodeRunner"
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
local code_runner = autoload("code_runner")
do end (_2amodule_locals_2a)["code-runner"] = code_runner
code_runner.setup({mode = "toggle", startInsert = true, filetype = {haskell = "cd $dir && runghc $fileName", rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt", python = "python3 -u", apl = "dyalog -script DYALOG_LINEEDITOR_MODE=1", idris2 = "idris2 $fileName -o $fileNameWithoutExt && ./build/exec/$fileNameWithoutExt", cpp = "cd $dir && c++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt", c = "cd $dir && cc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"}})
return _2amodule_2a