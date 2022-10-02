local _2afile_2a = "fnl/Lang/Treesitter.fnl"
local _2amodule_name_2a = "Lang.Treesitter"
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
local treesitter_context, treesitter, parsers = autoload("treesitter-context"), autoload("nvim-treesitter.configs"), autoload("nvim-treesitter.parsers")
do end (_2amodule_locals_2a)["treesitter-context"] = treesitter_context
_2amodule_locals_2a["treesitter"] = treesitter
_2amodule_locals_2a["parsers"] = parsers
treesitter.setup({ensure_installed = {"toml", "bash", "c", "cpp", "fennel", "haskell", "python", "rust", "javascript", "lua", "html", "scss", "markdown", "nix", "html", "regex"}, indent = {enable = true}, autopairs = {enable = true}, highlight = {enable = true}, matchup = {enable = true}, rainbow = {enable = true}, playground = {enable = true}, refactor = {highlight_current_scope = {enable = false}}, textobjects = {lsp_interop = {enable = true}, swap = {enable = true}, select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner"}}}})
treesitter_context.setup({enable = true})
return _2amodule_2a