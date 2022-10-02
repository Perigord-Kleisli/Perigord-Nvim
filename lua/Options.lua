local _2afile_2a = "fnl/Options.fnl"
local _2amodule_name_2a = "Options"
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
vim.o.iskeyword = (vim.o.iskeyword .. ",-")
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.wrap = false
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.wo.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.undofile = true
vim.o.undodir = "/tmp/nvim-undos"
vim.g.mapleader = " "
vim.o.timeoutlen = 300
vim.o.mouse = "a"
vim.g.termguicolors = true
vim.o.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_create_autocmd({"InsertEnter"}, {pattern = "*", command = "set norelativenumber"})
vim.api.nvim_create_autocmd({"InsertLeave"}, {pattern = "*", command = "set relativenumber"})
local function _1_()
  return vim.highlight.on_yank({higroup = "visual", timeout = 180})
end
vim.api.nvim_create_autocmd({"TextYankPost"}, {pattern = "*", callback = _1_})
vim.g.apl_prefix_key = "."
vim.g.Hexokinase_highlighters = {"backgroundfull"}
vim.api.nvim_create_autocmd({"TermEnter"}, {pattern = "*", command = "set nocursorline"})
return _2amodule_2a