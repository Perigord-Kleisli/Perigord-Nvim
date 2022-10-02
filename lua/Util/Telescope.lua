local _2afile_2a = "fnl/Util/Telescope.fnl"
local _2amodule_name_2a = "Util.Telescope"
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
local actions, telescope, Func, themes = autoload("telescope.actions"), autoload("telescope"), autoload("Functions"), autoload("telescope.themes")
do end (_2amodule_locals_2a)["actions"] = actions
_2amodule_locals_2a["telescope"] = telescope
_2amodule_locals_2a["Func"] = Func
_2amodule_locals_2a["themes"] = themes
telescope.setup({defaults = {winblend = 1, file_ignore_patterns = {"__pycache__", "node_modules", ".jpg", ".jpeg", ".png", ".ico", "dist", "dist-newstyle"}, prompt_prefix = "\239\145\171 ", selection_caret = "\239\129\164  ", mappings = {i = {["<C-j>"] = actions.move_selection_next, ["<C-k>"] = actions.move_selection_previous, ["<C-n>"] = actions.cycle_history_next, ["<C-p>"] = actions.cycle_history_prev}}}})
for _, i in ipairs({"media_files", "file_browser", "dap"}) do
  local function _1_(...)
    return print("Failed to load Telescope Extension:", ...)
  end
  Func.alternative(telescope.load_extension, _1_, i)
end
return _2amodule_2a