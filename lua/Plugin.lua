local _2afile_2a = "/home/truff/.config/nvim/fnl/Plugin.fnl"
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
local Func, packer, Startup = autoload("Functions"), autoload("packer"), autoload("Startup")
do end (_2amodule_locals_2a)["Func"] = Func
_2amodule_locals_2a["packer"] = packer
_2amodule_locals_2a["Startup"] = Startup
require("UI.Neovide")
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
local function _19_(x_2_auto)
  local function _20_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _20_}
end
local _21_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "auto-session")
  if status_ok_2_auto then
    _21_ = module_name_3_auto.setup({auto_session_enabled = false, auto_session_suppress_dirs = {"~"}, auto_save_enabled = true, auto_session_create_enabled = false})
  else
    _21_ = print("Error Configuring", "auto-session", "\n")
  end
end
local function _24_(x_2_auto)
  local function _25_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _25_}
end
local function _26_(x_2_auto)
  local function _27_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _27_}
end
local _28_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "nvim-cursorline")
  if status_ok_2_auto then
    _28_ = module_name_3_auto.setup({cursorline = {timeout = 3000}})
  else
    _28_ = print("Error Configuring", "nvim-cursorline", "\n")
  end
end
local _31_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "bufferline")
  if status_ok_2_auto then
    _31_ = module_name_3_auto.setup({options = {diagnostics = "nvim_lsp"}})
  else
    _31_ = print("Error Configuring", "bufferline", "\n")
  end
end
local function _34_(x_2_auto)
  local function _35_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _35_}
end
local function _36_(x_2_auto)
  local function _37_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _37_}
end
local _38_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "sniprun")
  if status_ok_2_auto then
    _38_ = module_name_3_auto.setup({display = {"TempFloatingWindow"}})
  else
    _38_ = print("Error Configuring", "sniprun", "\n")
  end
end
local function _41_(x_2_auto)
  local function _42_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _42_}
end
vim.g.nvim_markdown_preview_theme = "solarized-dark"
local function _43_(x_2_auto)
  local function _44_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _44_}
end
local _45_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "idris2")
  if status_ok_2_auto then
    _45_ = module_name_3_auto.setup({})
  else
    _45_ = print("Error Configuring", "idris2", "\n")
  end
end
local function _48_()
  return vim.fn["firenvim#install"](0)
end
local _49_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "godbolt")
  if status_ok_2_auto then
    _49_ = module_name_3_auto.setup({languages = {haskell = {compiler = "ghc901"}}})
  else
    _49_ = print("Error Configuring", "godbolt", "\n")
  end
end
local _52_
do
  local status_ok, presence = pcall(require, "presence")
  if status_ok then
    _52_ = presence:setup({neovim_image_text = "Neovim"})
  else
    _52_ = print("Error Configuring: Presence")
  end
end
use({["Olical/aniseed"] = {}, ["wbthomason/packer.nvim"] = {}, ["lewis6991/impatient.nvim"] = {}, ["MunifTanjim/nui.nvim"] = {}, ["nvim-lua/plenary.nvim"] = {}, ["nvim-lua/popup.nvim"] = {}, ["arp242/undofile_warn.vim"] = {}, ["tpope/vim-surround"] = {}, ["windwp/nvim-autopairs"] = {config = _6_}, ["andymass/vim-matchup"] = {}, ["Trouble-Truffle/Prog-Nvim"] = a.merge({config = (Func.alternative(require, _9_, "prog")).setup()}, {requires = {{"Trouble-Truffle/PeriLib-Nvim"}}}), ["preservim/nerdcommenter"] = {}, ["s1n7ax/nvim-comment-frame"] = a.merge({config = (Func.alternative(require, _11_, "nvim-comment-frame")).setup()}), ["folke/todo-comments.nvim"] = a.merge({config = (Func.alternative(require, _13_, "todo-comments")).setup()}), ["ggandor/lightspeed.nvim"] = {}, ["tpope/vim-fugitive"] = {}, ["TimUntersberger/neogit"] = a.merge({config = (Func.alternative(require, _15_, "neogit")).setup()}), ["lewis6991/gitsigns.nvim"] = a.merge({config = (Func.alternative(require, _17_, "gitsigns")).setup()}), ["f-person/git-blame.nvim"] = {}, ["editorconfig/editorconfig-vim"] = {}, ["nvim-telescope/telescope.nvim"] = {["conf-module"] = "Util.Telescope", requires = {{"nvim-telescope/telescope-file-browser.nvim"}, {"nvim-telescope/telescope-media-files.nvim"}, {"nvim-telescope/telescope-dap.nvim"}, {branch = "0.1.x", "mrcjkb/telescope-manix"}, {"nvim-telescope/telescope-ui-select.nvim"}}}, ["kyazdani42/nvim-tree.lua"] = {["conf-module"] = "Util.NvimTree", requires = "kyazdani42/nvim-web-devicons"}, ["akinsho/toggleterm.nvim"] = a.merge({config = (Func.alternative(require, _19_, "toggleterm")).setup()}), ["folke/which-key.nvim"] = {["conf-module"] = "Mapping", requires = "mrjones2014/legendary.nvim"}, ["farmergreg/vim-lastplace"] = {}, ["rmagatti/auto-session"] = {config = _21_}, ["ekickx/clipboard-image.nvim"] = {}, ["luukvbaal/stabilize.nvim"] = a.merge({config = (Func.alternative(require, _24_, "stabilize")).setup()}), ["rcarriga/nvim-notify"] = {}, ["nacro90/numb.nvim"] = a.merge({config = (Func.alternative(require, _26_, "numb")).setup()}), ["yamatsum/nvim-cursorline"] = {config = _28_}, ["lukas-reineke/indent-blankline.nvim"] = {["conf-module"] = "UI.Indent-Blankline"}, ["akinsho/bufferline.nvim"] = {config = _31_}, ["RRethy/vim-hexokinase"] = {run = "make hexokinase"}, ["folke/zen-mode.nvim"] = a.merge({config = (Func.alternative(require, _34_, "zen-mode")).setup()}), ["goolord/alpha-nvim"] = {["conf-module"] = "Startup"}, ["Mofiqul/dracula.nvim"] = {["conf-module"] = "UI.Colorscheme"}, ["stevearc/dressing.nvim"] = a.merge({config = (Func.alternative(require, _36_, "dressing")).setup()}), ["nvim-lualine/lualine.nvim"] = {["conf-module"] = "UI.Lualine", requires = {{"SmiteshP/nvim-gps"}, {"SmiteshP/nvim-navic"}}}, ["rainbowhxch/beacon.nvim"] = {}, ["CRAG666/code_runner.nvim"] = {["conf-module"] = "Lang.CodeRunner"}, ["simrat39/symbols-outline.nvim"] = {}, ["michaelb/sniprun"] = {config = _38_}, ["amrbashir/nvim-docs-view"] = {}, ["j-hui/fidget.nvim"] = a.merge({config = (Func.alternative(require, _41_, "fidget")).setup()}), ["mfussenegger/nvim-dap"] = {["conf-module"] = "Lang.Dap", requires = {{"rcarriga/nvim-dap-ui"}, {"mfussenegger/nvim-dap-python"}, {"theHamsta/nvim-dap-virtual-text"}}}, ["jose-elias-alvarez/null-ls.nvim"] = {["conf-module"] = "Lang.Null-ls"}, ["hrsh7th/nvim-cmp"] = {["conf-module"] = "Lang.Cmp-Nvim", requires = {{"hrsh7th/cmp-nvim-lsp"}, {"L3MON4D3/LuaSnip"}, {"hrsh7th/cmp-calc"}, {"uga-rosa/cmp-dictionary"}, {"lukas-reineke/cmp-under-comparator"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-nvim-lua"}, {"kdheepak/cmp-latex-symbols"}, {"ray-x/cmp-treesitter"}, {"hrsh7th/cmp-nvim-lsp-signature-help"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-buffer"}}}, ["p00f/nvim-ts-rainbow"] = {}, ["nvim-treesitter/nvim-treesitter"] = {["conf-module"] = "Lang.Treesitter", requires = {{"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-treesitter/nvim-treesitter-refactor"}}}, ["nvim-treesitter/playground"] = {}, ["davidgranstrom/nvim-markdown-preview"] = {config = nil}, ["neovim/nvim-lspconfig"] = {["conf-module"] = "Lang.LSP", requires = {{"hrsh7th/nvim-cmp"}}}, ["simrat39/rust-tools.nvim"] = a.merge({config = (Func.alternative(require, _43_, "rust-tools")).setup()}), ["LnL7/vim-nix"] = {}, ["Nymphium/vim-koka"] = {}, ["vlime/vlime"] = {}, ["bhurlow/vim-parinfer"] = {}, ["justin2004/vim-apl"] = {}, ["ShinKage/idris2-nvim"] = {config = _45_}, ["glacambre/firenvim"] = {run = _48_}, ["p00f/godbolt.nvim"] = {config = _49_}, ["andweeb/presence.nvim"] = {config = _52_}, ["wakatime/vim-wakatime"] = {}})
return _2amodule_2a