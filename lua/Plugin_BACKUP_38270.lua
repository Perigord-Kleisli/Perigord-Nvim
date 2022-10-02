local _2afile_2a = "fnl/Plugin_BACKUP_38270.fnl"
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
local Startup, packer, Func = autoload("Startup"), autoload("packer"), autoload("Functions")
do end (_2amodule_locals_2a)["Startup"] = Startup
_2amodule_locals_2a["packer"] = packer
_2amodule_locals_2a["Func"] = Func
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
local function _6_(x_2_auto)
  local function _7_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _7_}
end
local _8_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "nvim-autopairs")
  if status_ok_2_auto then
    _8_ = module_name_3_auto.setup({disable_filetype = {"lisp", "fennel", "TelescopePrompt"}, check_ts = true, fast_wrap = {map = "<M-e>"}})
  else
    _8_ = print("Error Configuring", "nvim-autopairs", "\n")
  end
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
local function _21_(x_2_auto)
  local function _22_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _22_}
end
local _23_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "auto-session")
  if status_ok_2_auto then
    _23_ = module_name_3_auto.setup({auto_session_enabled = false, auto_session_suppress_dirs = {"~"}, auto_save_enabled = true, auto_session_create_enabled = false})
  else
    _23_ = print("Error Configuring", "auto-session", "\n")
  end
end
local function _26_(x_2_auto)
  local function _27_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _27_}
end
local function _28_(x_2_auto)
  local function _29_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _29_}
end
local _30_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "nvim-cursorline")
  if status_ok_2_auto then
    _30_ = module_name_3_auto.setup({cursorline = {timeout = 3000}})
  else
    _30_ = print("Error Configuring", "nvim-cursorline", "\n")
  end
end
local _33_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "bufferline")
  if status_ok_2_auto then
    _33_ = module_name_3_auto.setup({diagnostics = "nvim_lsp"})
  else
    _33_ = print("Error Configuring", "bufferline", "\n")
  end
end
local function _36_(x_2_auto)
  local function _37_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _37_}
end
local function _38_(x_2_auto)
  local function _39_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _39_}
end
local _40_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "sniprun")
  if status_ok_2_auto then
    _40_ = module_name_3_auto.setup({display = {"TempFloatingWindow"}})
  else
    _40_ = print("Error Configuring", "sniprun", "\n")
  end
end
local function _43_(x_2_auto)
  local function _44_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _44_}
end
vim.g.nvim_markdown_preview_theme = "solarized-dark"
local function _45_(x_2_auto)
  local function _46_()
    return print("Error Configuring:", x_2_auto, "\n")
  end
  return {setup = _46_}
end
local function _47_()
  return vim.fn["firenvim#install"](0)
end
local _48_
do
  local status_ok_2_auto, module_name_3_auto = pcall(require, "godbolt")
  if status_ok_2_auto then
    _48_ = module_name_3_auto.setup({languages = {haskell = {compiler = "ghc901"}}})
  else
    _48_ = print("Error Configuring", "godbolt", "\n")
  end
end
local _51_
do
  local status_ok, presence = pcall(require, "presence")
  if status_ok then
    _51_ = presence:setup({neovim_image_text = "Neovim"})
  else
    _51_ = print("Error Configuring: Presence")
  end
end
use({["Olical/aniseed"] = {}, ["wbthomason/packer.nvim"] = {}, ["lewis6991/impatient.nvim"] = {}, ["MunifTanjim/nui.nvim"] = {}, ["nvim-lua/plenary.nvim"] = {}, ["nvim-lua/popup.nvim"] = {}, ["arp242/undofile_warn.vim"] = {}, ["tpope/vim-surround"] = {}, ["windwp/nvim-autopairs"] = {config = _8_}, ["andymass/vim-matchup"] = {}, ["Trouble-Truffle/Prog-Nvim"] = a.merge({config = (Func.alternative(require, _11_, "prog")).setup()}, {requires = {{"Trouble-Truffle/PeriLib-Nvim"}}}), ["preservim/nerdcommenter"] = {}, ["s1n7ax/nvim-comment-frame"] = a.merge({config = (Func.alternative(require, _13_, "nvim-comment-frame")).setup()}), ["folke/todo-comments.nvim"] = a.merge({config = (Func.alternative(require, _15_, "todo-comments")).setup()}), ["ggandor/lightspeed.nvim"] = {}, ["tpope/vim-fugitive"] = {}, ["TimUntersberger/neogit"] = a.merge({config = (Func.alternative(require, _17_, "neogit")).setup()}), [__fnl_global___3c_3c_3c_3c_3c_3c_3c] = HEAD, ["lewis6991/gitsigns.nvim"] = a.merge({config = (Func.alternative(require, _19_, "gitsigns")).setup()}), ["f-person/git-blame.nvim"] = {}, [__fnl_global___3d_3d_3d_3d_3d_3d_3d] = "f-person/git-blame.nvim", [{}] = "lewis6991/gitsigns.nvim", [a.merge({config = (Func.alternative(require, _6_, "gitsigns")).setup()})] = __fnl_global___3e_3e_3e_3e_3e_3e_3e, [c51c65a] = Added(some, UI, improvements), ["editorconfig/editorconfig-vim"] = {}, ["nvim-telescope/telescope.nvim"] = {["conf-module"] = "Util.Telescopeplug", requires = {{"nvim-telescope/telescope-file-browser.nvim"}, {"nvim-telescope/telescope-media-files.nvim"}, {"nvim-telescope/telescope-dap.nvim"}, {"nvim-telescope/telescope-ui-select.nvim"}}}, ["kyazdani42/nvim-tree.lua"] = {["conf-module"] = "Util.NvimTree", requires = "kyazdani42/nvim-web-devicons"}, ["akinsho/toggleterm.nvim"] = a.merge({config = (Func.alternative(require, _21_, "toggleterm")).setup()}), ["folke/which-key.nvim"] = {["conf-module"] = "Mapping", requires = "mrjones2014/legendary.nvim"}, ["farmergreg/vim-lastplace"] = {}, ["rmagatti/auto-session"] = {config = _23_}, ["ekickx/clipboard-image.nvim"] = {}, ["luukvbaal/stabilize.nvim"] = a.merge({config = (Func.alternative(require, _26_, "stabilize")).setup()}), ["rcarriga/nvim-notify"] = {}, ["nacro90/numb.nvim"] = a.merge({config = (Func.alternative(require, _28_, "numb")).setup()}), ["yamatsum/nvim-cursorline"] = {config = _30_}, ["lukas-reineke/indent-blankline.nvim"] = {["conf-module"] = "UI.Indent-Blankline"}, ["akinsho/bufferline.nvim"] = {config = _33_}, ["RRethy/vim-hexokinase"] = {run = "make hexokinase"}, ["folke/zen-mode.nvim"] = a.merge({config = (Func.alternative(require, _36_, "zen-mode")).setup()}), ["goolord/alpha-nvim"] = {["conf-module"] = "Startup"}, ["Mofiqul/dracula.nvim"] = {["conf-module"] = "UI.Colorscheme"}, ["stevearc/dressing.nvim"] = a.merge({config = (Func.alternative(require, _38_, "dressing")).setup()}), ["nvim-lualine/lualine.nvim"] = {["conf-module"] = "UI.Lualine", requires = {{"SmiteshP/nvim-gps"}, {"SmiteshP/nvim-navic"}}}, ["camspiers/animate.vim"] = {}, ["rainbowhxch/beacon.nvim"] = {}, ["CRAG666/code_runner.nvim"] = {["conf-module"] = "Lang.CodeRunner"}, ["simrat39/symbols-outline.nvim"] = {}, ["michaelb/sniprun"] = {config = _40_}, ["amrbashir/nvim-docs-view"] = {}, ["j-hui/fidget.nvim"] = a.merge({config = (Func.alternative(require, _43_, "fidget")).setup()}), ["mfussenegger/nvim-dap"] = {["conf-module"] = "Lang.Dap", requires = {{"rcarriga/nvim-dap-ui"}, {"mfussenegger/nvim-dap-python"}, {"theHamsta/nvim-dap-virtual-text"}}}, ["jose-elias-alvarez/null-ls.nvim"] = {["conf-module"] = "Lang.Null-ls"}, ["hrsh7th/nvim-cmp"] = {["conf-module"] = "Lang.Cmp-Nvim", requires = {{"hrsh7th/cmp-nvim-lsp"}, {"L3MON4D3/LuaSnip"}, {"hrsh7th/cmp-calc"}, {"uga-rosa/cmp-dictionary"}, {"lukas-reineke/cmp-under-comparator"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-nvim-lua"}, {"kdheepak/cmp-latex-symbols"}, {"ray-x/cmp-treesitter"}, {"hrsh7th/cmp-nvim-lsp-signature-help"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-buffer"}}}, ["p00f/nvim-ts-rainbow"] = {}, ["nvim-treesitter/nvim-treesitter"] = {["conf-module"] = "Lang.Treesitter", requires = {{"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-treesitter/nvim-treesitter-refactor"}}}, ["nvim-treesitter/playground"] = {}, ["davidgranstrom/nvim-markdown-preview"] = {config = nil}, ["neovim/nvim-lspconfig"] = {["conf-module"] = "Lang.LSP", requires = {{"hrsh7th/nvim-cmp"}}}, ["simrat39/rust-tools.nvim"] = a.merge({config = (Func.alternative(require, _45_, "rust-tools")).setup()}), ["LnL7/vim-nix"] = {}, ["vlime/vlime"] = {}, ["bhurlow/vim-parinfer"] = {}, ["justin2004/vim-apl"] = {}, ["glacambre/firenvim"] = {run = _47_}, ["p00f/godbolt.nvim"] = {config = _48_}, ["andweeb/presence.nvim"] = {config = _51_}, ["wakatime/vim-wakatime"] = {}, ["github/copilot.vim"] = {}})
return _2amodule_2a