--[[
# External.Plugin
-   Controls the usage of external plugins
--]]

-- For automatically installing Packer when not located

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   PACKER_BOOTSTRAP = vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
   })
   print "Installing packer close and reopen Neovim..."
   vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
   vim.notify "Error importing packer"
   return
end

-- Having packer open as a floating window
packer.init({
   display = {
      open_fn = function()
         return require("packer.util").float({ border = "rounded" })
      end,
   },
})

-- require "External.Alpha"
require "External.Godbolt"
require "External.Lspconfig"
require "External.Lualine"
require "External.Null-ls"
require "External.Nvim-cmp"
require "External.Nvim-tree"
require "External.Packer_compiled"
require "External.Indent_Blankline"
require "External.Plugsetup"
require "External.Telescope"
require "External.Toggleterm"
require "External.TreeSitter"
require "External.Which_key"

return require("packer").startup({
   config = {
      compile_path = vim.fn.stdpath "config" .. "lua/External/Packer_compiled.lua",
   },
   function(use)
      -- [ Editing ]

      -- Delimeter operations
      use "tpope/vim-surround"

      -- Comment
      use "scrooloose/nerdcommenter"

      -- Better % Functionalilty
      use "andymass/vim-matchup"

      -- Save last position in file
      use "farmergreg/vim-lastplace"

      -- Automatic delimiter closing
      use "windwp/nvim-autopairs"

      -- Spellchecker
      use "lewis6991/spellsitter.nvim"

      -- [ File ]

      -- Browser
      use "kyazdani42/nvim-tree.lua"

      use "kyazdani42/nvim-web-devicons"

      --tabs
      use "akinsho/bufferline.nvim"

      -- Fuzzy finder
      use({
         "nvim-telescope/telescope.nvim",
         requires = { { "nvim-lua/plenary.nvim" } },
      })

      use({
         "nvim-telescope/telescope-media-files.nvim",
         requires = { "nvim-telescope/telescope.nvim" },
      })

      -- Project Manager
      use "ahmedkhalf/project.nvim"
      -- [ Look ]

      -- Airline
      use "nvim-lualine/lualine.nvim"

      -- Theme
      use "Mofiqul/dracula.nvim"
      --use({ "dracula/vim", as = "dracula" })

      -- Transparency
      use "xiyaowong/nvim-transparent"

      -- Indent lines
      use "lukas-reineke/indent-blankline.nvim"

      -- [ Config dependencies ]

      -- Required by some plugins
      use "nvim-lua/popup.nvim"
      use "nvim-lua/plenary.nvim"

      -- [ Misc ]

      -- Animated Windows
      use "camspiers/animate.vim"
      -- Calculator
      use "hrsh7th/cmp-calc"

      -- Comment frame
      use({
         "s1n7ax/nvim-comment-frame",
         requires = {
            { "nvim-treesitter" },
         },
      })

      -- decrease startup times
      use "lewis6991/impatient.nvim"

      -- Cursor hold fix
      use "antoinemadec/FixCursorHold.nvim"
      -- Dictionary
      use "uga-rosa/cmp-dictionary"

      -- Debugging
      use "mfussenegger/nvim-dap"

      -- Discord
      use "andweeb/presence.nvim"

      -- Highlight word under cursor
      use "yamatsum/nvim-cursorline"

      -- Emojis
      use "hrsh7th/cmp-emoji"

      -- Highlight cursor on large jumps
      use "DanilaMihailov/beacon.nvim"
      -- Start menu
      use "goolord/alpha-nvim"

      -- Show available keys
      use "folke/which-key.nvim"

      -- Toglleable terminal
      use "akinsho/toggleterm.nvim"

      -- Git integration
      use "tpope/vim-fugitive"

      -- Browser integration
      use({
         "glacambre/firenvim",
         run = function()
            vim.fn["firenvim#install"](0)
         end,
      })
      
      -- Grammer Checker
      use "vigoux/LanguageTool.nvim"
      use 'rhysd/vim-grammarous'
      -- Godbolt
      use "P00f/Godbolt.Nvim"

      -- Git Decorations
      use({
         "lewis6991/gitsigns.nvim",
         requires = {
            "nvim-lua/plenary.nvim",
         },
      })
      -- Packer
      use "wbthomason/packer.nvim"

      -- Programming Dahsboard
      use "wakatime/vim-wakatime"

      --[ LANG ]

      -- Completion
      use "hrsh7th/nvim-cmp"
      use "hrsh7th/cmp-buffer"
      use "hrsh7th/cmp-path"
      use "hrsh7th/cmp-cmdline"
      use "saadparwaiz1/cmp_luasnip"
      use "hrsh7th/cmp-nvim-lsp"
      use "L3MON4D3/LuaSnip"
      use "rafamadriz/friendly-snippets"

      -- LSP
      use "neovim/nvim-lspconfig"
      use "williamboman/nvim-lsp-installer"
      use "jose-elias-alvarez/null-ls.nvim"

      -- Smarter Highlighting
      use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
      use({ "p00f/nvim-ts-rainbow", requires = {
         "nvim-treesitter/nvim-treesitter",
      } })

      -- APL
      use "justin2004/vim-apl"

      -- Latex
      use "kdheepak/cmp-latex-symbols"

      -- Lisp
      use {"vlime/vlime", rtp = "vim/"}

      -- Markdown
      use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

      -- Nvim_Lua
      use "hrsh7th/cmp-nvim-lua"

      -- Org
      use "nvim-orgmode/orgmode"
      use "akinsho/org-bullets.nvim"

      if PACKER_BOOTSTRAP then
         require("packer").sync()
      end
   end,
})
