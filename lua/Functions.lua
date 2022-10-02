local _2afile_2a = "fnl/Functions.fnl"
local _2amodule_name_2a = "Functions"
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
local repl
do
  local _1_ = vim.bo.filetype
  if (_1_ == "lua") then
    repl = "luajit"
  elseif (_1_ == "fennel") then
    repl = "fennel"
  elseif (_1_ == "haskell") then
    repl = "ghci"
  elseif (_1_ == "python") then
    repl = "python"
  elseif (_1_ == "lisp") then
    repl = "sbcl"
  elseif (_1_ == "javascript") then
    repl = "node"
  elseif (_1_ == "nix") then
    repl = "nix repl"
  elseif true then
    local _ = _1_
    repl = os.getenv("SHELL")
  else
    repl = nil
  end
end
_2amodule_2a["repl"] = repl
local function alternative(fa, fb, ...)
  local status_ok, result = pcall(fa, ...)
  if status_ok then
    return result
  else
    return fb(...)
  end
end
_2amodule_2a["alternative"] = alternative
local function maybe(fa, b, ...)
  local function _4_()
    return b
  end
  return alternative(fa, _4_, ...)
end
_2amodule_2a["maybe"] = maybe
local function _5_(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen(("ls -a \"" .. directory .. "\""))
  for filename in pfile:lines() do
    i = (i + 1)
    do end (t)[i] = filename
  end
  pfile:close()
  return t
end
scandir = _5_
return _2amodule_2a