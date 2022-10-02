local _2afile_2a = "fnl/Lang/Dap.fnl"
local _2amodule_name_2a = "Lang.Dap"
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
local virtual_text, dap, dapui, dap_python = autoload("nvim-dap-virtual-text"), autoload("dap"), autoload("dapui"), autoload("dap-python")
do end (_2amodule_locals_2a)["virtual-text"] = virtual_text
_2amodule_locals_2a["dap"] = dap
_2amodule_locals_2a["dapui"] = dapui
_2amodule_locals_2a["dap-python"] = dap_python
vim.fn.sign_define("DapBreakpoint", {text = "\226\172\163", texthl = "ErrorMsg"})
vim.fn.sign_define("DapBreakpointCondition", {text = "\239\159\152", texthl = "ErrorMsg"})
vim.fn.sign_define("DapLogPoint", {text = "\239\128\175", texthl = "String"})
virtual_text.setup({commented = true})
dapui.setup()
dap.adapters.haskell = {type = "executable", command = "haskell-debug-adapter", args = {}}
dap.configurations.haskell = {{type = "haskell", request = "launch", name = "Debug", internalConsoleOptions = "openOnSessionStart", workspace = "${workspaceFolder}", startup = "${workspaceFolder}/app/Main.hs", startupFunc = "", startupArgs = "", stopOnEntry = true, mainArgs = "", ghciInitialPrompt = "Prelude>", ghciPrompt = "\206\187: ", ghciCmd = "cabal exec -- ghci-dap -fexternal-interpreter --interactive -i -i${workspaceFolder}", ghciEnv = vim.empty_dict(), logFile = (vim.fn.stdpath("cache") .. "/haskell-dap.log"), logLevel = "WARNING", forceInspect = false}}
local function _1_()
  return dapui.open()
end
dap.listeners.after.event_initialized["dapui_config"] = _1_
local function _2_()
  return dapui.close()
end
dap.listeners.after.event_terminated["dapui_config"] = _2_
local function _3_()
  return dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = _3_
dap_python.setup("/home/truff/.nix-profile/bin/python")
dap.adapters.lldb = {type = "executable", attach = {pidProperty = "pid", pidSelect = "ask"}, command = "lldb-vscode", env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"}, name = "lldb"}
local function _4_()
  return vim.fn.input("Program: ", (vim.fn.getcwd() .. "/target/debug/"), "file")
end
dap.configurations.rust = {{type = "lldb", name = "Debug", request = "launch", program = _4_}}
local function _5_()
  return vim.fn.input("Program: ", (vim.fn.getcwd() .. "/"), "file")
end
dap.configurations.cpp = {{type = "lldb", name = "Debug", request = "launch", program = _5_}}
local function _6_()
  return vim.fn.input("Program: ", (vim.fn.getcwd() .. "/"), "file")
end
dap.configurations.c = {{type = "lldb", name = "Debug", request = "launch", program = _6_}}
local function _7_()
  return vim.fn.input("Program: ", (vim.fn.getcwd() .. "/"), "file")
end
dap.configurations.cpp = {{type = "lldb", name = "Debug", request = "launch", program = _7_}}
return _2amodule_2a