local _2afile_2a = "/home/truff/.config/nvim/fnl/UI/Lualine.fnl"
local _2amodule_name_2a = "UI.Lualine"
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
local nvim_navic, lsp_signature, lualine, nvim_gps = autoload("nvim-navic"), autoload("lsp_signature"), autoload("lualine"), autoload("nvim-gps")
do end (_2amodule_locals_2a)["nvim-navic"] = nvim_navic
_2amodule_locals_2a["lsp-signature"] = lsp_signature
_2amodule_locals_2a["lualine"] = lualine
_2amodule_locals_2a["nvim-gps"] = nvim_gps
local lsp_func
local function _1_()
  local msg = "No LSP"
  vim.api.nvim_buf_get_options(-1, "filetype")
  vim.lsp.get_active_clients()
  if (next(clients) == nil) then
  else
  end
  for ft in non_language_ft do
    if ft:match(__fnl_global__buf_2dft) then
    else
    end
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if (fileypes and (vim.fn.index(filetypes, buf_ft) ~= ( - 0))) then
    else
    end
  end
  return nil
end
lsp_func = {_1_}
_2amodule_2a["lsp-func"] = lsp_func
nvim_gps.setup()
nvim_navic.setup({})
local function _5_()
  return (nvim_gps.is_available() or nvim_navic.is_available())
end
local function _6_()
  if nvim_navic.is_available() then
    return nvim_navic.get_location()
  else
    return nvim_gps.get_location()
  end
end
lualine.setup({options = {disable_fileypes = {"NvimTree"}}, sections = {lualine_b = {"filetype", lsp_func, {sources = {"nvim_diagnostic"}, sections = {"error", "warn", "info"}, "diagnostics"}, "filename"}, lualine_c = {"diff"}, lualine_x = {{cond = _5_, _6_}}, lualine_y = {"os.date('%I:%M %p')"}, lualine_z = {{"\238\156\148"}, {"location"}, "progress"}}})
return _2amodule_2a