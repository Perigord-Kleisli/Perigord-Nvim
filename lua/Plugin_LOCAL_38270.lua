local _2afile_2a = "fnl/Plugin_LOCAL_38270.fnl"
local _2amodule_name_2a = "Plugin"
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
local Func, Startup, packer = autoload("Functions"), autoload("Startup"), autoload("packer")
do end (_2amodule_locals_2a)["Func"] = Func
_2amodule_locals_2a["Startup"] = Startup
_2amodule_locals_2a["packer"] = packer
local function safe_require(mod)
  local status_ok, plugin = pcall(require, mod)
  if not status_ok then
    return print("Error Importing:", mod, "\n", "Log: \n\n", plugin)
  else
    return nil
  end
end
_2amodule_2a["safe-require"] = safe_require
local function _2_()
  return (require("packer.util")).float({border = "rounded"})
end
packer.init({display = {open_fn = _2_}})
local function use(plugtable)
  local function _3_(use0)
    for name, opts in pairs(plugtable) do
      do
        local _4_ = opts["conf-module"]
        if (nil ~= _4_) then
          safe_require(_4_)
        else
        end
      end
      table.insert(opts, 1, name)
      use0(opts)
    end
    return nil
  end
  packer.startup({config = {compile_path = (vim.fn.stdpath("config") .. "/lua/External/Packer_compiled.lua")}, _3_})
  return nil
end
_2amodule_locals_2a["use"] = use
local a = require("aniseed.core")
do end (_2amodule_locals_2a)["a"] = a
local _6_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "nvim-autopairs")
  if status_ok_2_auto then
    _6_ = module_name_3_auto.setup({disable_filetype = {"lisp", "fennel", "TelescopePrompt"}, check_ts = true, fast_wrap = {map = "<M-e>"}})
  else
    _6_ = print("Error Configuring", "nvim-autopairs", "\n")
  end
end
local function _9_(x_2_auto)
  local function _10_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _10_}
end
local function _11_(x_2_auto)
  local function _12_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _12_}
end
local function _13_(x_2_auto)
  local function _14_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _14_}
end
local function _15_(x_2_auto)
  local function _16_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _16_}
end
local function _17_(x_2_auto)
  local function _18_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _18_}
end
local _19_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "auto-session")
  if status_ok_2_auto then
    _19_ = module_name_3_auto.setup({auto_session_enabled = false, auto_session_suppress_dirs = {"~"}, auto_save_enabled = true, auto_session_create_enabled = false})
  else
    _19_ = print("Error Configuring", "auto-session", "\n")
  end
end
local function _22_()
  do end (require("goto-preview")).setup()
  return {}
end
local function _23_(x_2_auto)
  local function _24_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _24_}
end
local _25_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "nvim-cursorline")
  if status_ok_2_auto then
    _25_ = module_name_3_auto.setup({cursorline = {timeout = 3000}})
  else
    _25_ = print("Error Configuring", "nvim-cursorline", "\n")
  end
end
local _28_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "bufferline")
  if status_ok_2_auto then
    _28_ = module_name_3_auto.setup({diagnostics = "nvim_lsp"})
  else
    _28_ = print("Error Configuring", "bufferline", "\n")
  end
end
local function _31_(x_2_auto)
  local function _32_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _32_}
end
local function _33_(x_2_auto)
  local function _34_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _34_}
end
local _35_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "sniprun")
  if status_ok_2_auto then
    _35_ = module_name_3_auto.setup({display = {"TempFloatingWindow"}})
  else
    _35_ = print("Error Configuring", "sniprun", "\n")
  end
end
local function _38_(x_2_auto)
  local function _39_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _39_}
end
vim.g.nvim_markdown_preview_theme = "solarized-dark"
local function _40_(x_2_auto)
  local function _41_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _41_}
end
local function _42_()
  return vim.fn["firenvim#install"](0)
end
local _43_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "godbolt")
  if status_ok_2_auto then
    _43_ = module_name_3_auto.setup({languages = {haskell = {compiler = "ghc901"}}})
  else
    _43_ = print("Error Configuring", "godbolt", "\n")
  end
end
local _46_
do
  local status_ok, presence = pcall(require, "presence")
  if status_ok then
    _46_ = presence:setup({neovim_image_text = "Neovim"})
  else
    _46_ = print("Error Configuring: Presence")
  end
end
use({["Olical/aniseed"] = {}, ["wbthomason/packer.nvim"] = {}, ["lewis6991/impatient.nvim"] = {}, ["nvim-lua/plenary.nvim"] = {}, ["nvim-lua/popup.nvim"] = {}, ["tpope/vim-surround"] = {}, ["windwp/nvim-autopairs"] = {config = _6_}, ["andymass/vim-matchup"] = {}, ["Trouble-Truffle/Prog-Nvim"] = a.merge({config = (Func.alternative(require, _9_, "prog")).setup()}, {requires = {{"Trouble-Truffle/PeriLib-Nvim"}}}), ["preservim/nerdcommenter"] = {}, ["s1n7ax/nvim-comment-frame"] = a.merge({config = (Func.alternative(require, _11_, "nvim-comment-frame")).setup()}), ["ggandor/lightspeed.nvim"] = {}, ["tpope/vim-fugitive"] = {}, ["TimUntersberger/neogit"] = a.merge({config = (Func.alternative(require, _13_, "neogit")).setup()}), ["lewis6991/gitsigns.nvim"] = a.merge({config = (Func.alternative(require, _15_, "gitsigns")).setup()}), ["f-person/git-blame.nvim"] = {}, ["editorconfig/editorconfig-vim"] = {}, ["nvim-telescope/telescope.nvim"] = {["conf-module"] = "Util.Telescopeplug", requires = {{"nvim-telescope/telescope-file-browser.nvim"}, {"nvim-telescope/telescope-media-files.nvim"}, {"nvim-telescope/telescope-dap.nvim"}, {"nvim-telescope/telescope-ui-select.nvim"}}}, ["kyazdani42/nvim-tree.lua"] = {["conf-module"] = "Util.NvimTree", requires = "kyazdani42/nvim-web-devicons"}, ["akinsho/toggleterm.nvim"] = a.merge({config = (Func.alternative(require, _17_, "toggleterm")).setup()}), ["folke/which-key.nvim"] = {["conf-module"] = "Mapping", requires = "mrjones2014/legendary.nvim"}, ["farmergreg/vim-lastplace"] = {}, ["rmagatti/auto-session"] = {config = _19_}, ["ekickx/clipboard-image.nvim"] = {}, ["rmagatti/goto-preview"] = {config = _22_}, ["rcarriga/nvim-notify"] = {}, ["nacro90/numb.nvim"] = a.merge({config = (Func.alternative(require, _23_, "numb")).setup()}), ["yamatsum/nvim-cursorline"] = {config = _25_}, ["lukas-reineke/indent-blankline.nvim"] = {["conf-module"] = "UI.Indent-Blankline"}, ["akinsho/bufferline.nvim"] = {config = _28_}, ["RRethy/vim-hexokinase"] = {run = "make hexokinase"}, ["folke/zen-mode.nvim"] = a.merge({config = (Func.alternative(require, _31_, "zen-mode")).setup()}), ["goolord/alpha-nvim"] = {["conf-module"] = "Startup"}, ["Mofiqul/dracula.nvim"] = {["conf-module"] = "UI.Dracula"}, ["stevearc/dressing.nvim"] = a.merge({config = (Func.alternative(require, _33_, "dressing")).setup()}), ["nvim-lualine/lualine.nvim"] = {["conf-module"] = "UI.Lualine", requires = {{"SmiteshP/nvim-gps"}, {"SmiteshP/nvim-navic"}}}, ["camspiers/animate.vim"] = {}, ["rainbowhxch/beacon.nvim"] = {}, ["CRAG666/code_runner.nvim"] = {["conf-module"] = "Lang.CodeRunner"}, ["simrat39/symbols-outline.nvim"] = {}, ["michaelb/sniprun"] = {config = _35_}, ["amrbashir/nvim-docs-view"] = {}, ["j-hui/fidget.nvim"] = a.merge({config = (Func.alternative(require, _38_, "fidget")).setup()}), ["mfussenegger/nvim-dap"] = {["conf-module"] = "Lang.Dap", requires = {{"rcarriga/nvim-dap-ui"}, {"mfussenegger/nvim-dap-python"}, {"theHamsta/nvim-dap-virtual-text"}}}, ["jose-elias-alvarez/null-ls.nvim"] = {["conf-module"] = "Lang.Null-ls"}, ["hrsh7th/nvim-cmp"] = {["conf-module"] = "Lang.Cmp-Nvim", requires = {{"hrsh7th/cmp-nvim-lsp"}, {"L3MON4D3/LuaSnip"}, {"hrsh7th/cmp-calc"}, {"uga-rosa/cmp-dictionary"}, {"lukas-reineke/cmp-under-comparator"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-nvim-lua"}, {"kdheepak/cmp-latex-symbols"}, {"ray-x/cmp-treesitter"}, {"hrsh7th/cmp-nvim-lsp-signature-help"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-buffer"}}}, ["p00f/nvim-ts-rainbow"] = {}, ["nvim-treesitter/nvim-treesitter"] = {["conf-module"] = "Lang.Treesitter", requires = {{"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-treesitter/nvim-treesitter-refactor"}}}, ["nvim-treesitter/playground"] = {}, ["davidgranstrom/nvim-markdown-preview"] = {config = nil}, ["neovim/nvim-lspconfig"] = {["conf-module"] = "Lang.LSP", requires = {{"hrsh7th/nvim-cmp"}}}, ["simrat39/rust-tools.nvim"] = a.merge({config = (Func.alternative(require, _40_, "rust-tools")).setup()}), ["LnL7/vim-nix"] = {}, ["ShinKage/idris2-nvim"] = {requires = {{"MunifTanjim/nui.nvim"}}}, ["vlime/vlime"] = {}, ["bhurlow/vim-parinfer"] = {}, ["justin2004/vim-apl"] = {}, ["glacambre/firenvim"] = {run = _42_}, ["p00f/godbolt.nvim"] = {config = _43_}, ["andweeb/presence.nvim"] = {config = _46_}, ["wakatime/vim-wakatime"] = {}, ["github/copilot.vim"] = {}})
return _2amodule_2a