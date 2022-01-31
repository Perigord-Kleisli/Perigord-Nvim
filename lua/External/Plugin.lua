--[[
# External.Plugin
-   Controls the usage of external plugins
--]]

-- For automatically installing Packer when not located

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   PACKER_BOOTSTRAP = vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
   })
   print("Installing packer close and reopen Neovim...")
   vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
   vim.notify("Error importing packer")
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

require("External.Godbolt")
require("External.Lspconfig")
require("External.Lualine")
require("External.Null-ls")
require("External.Nvim-cmp")
require("External.Telescope")
require("External.Toggleterm")
require("External.TreeSitter")

return require("packer").startup(function(use)
   -- [ Editing ]

   -- Delimeter operations
   use("tpope/vim-surround")

   -- Comment
   use("scrooloose/nerdcommenter")

   -- Better % Functionalilty
   use("andymass/vim-matchup")

   -- Save last position in file
   use("farmergreg/vim-lastplace")

   -- Automatic delimiter closing
   use({
      "windwp/nvim-autopairs",
      config = function()
         require("nvim-autopairs").setup({
            check_ts = true,
            fast_wrap = {},
         })
      end,
   })

   -- Spellchecker
   use({
      "lewis6991/spellsitter.nvim",
      config = function()
         require("spellsitter").setup()
      end,
   })

   -- [ File ]

   -- Browser
   use("kyazdani42/nvim-tree.lua")

   use("kyazdani42/nvim-web-devicons")

   --tabs
   use({
      "akinsho/bufferline.nvim",
      requires = { "moll/vim-bbye", "hrsh7th/nvim-cmp" },
      config = function()
         require("bufferline").setup({
            options = {
               close_command = "Bdelete! %d",
               right_mouse_command = "Bdelete! %d",
               diagnostics = "nvim_lsp",
               offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
               separator_style = "slant",
            },
         })
      end,
   })

   -- Fuzzy finder
   use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
   })
   use({
      "nvim-telescope/telescope-media-files.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
   })

   -- [ Look ]

   -- Airline
   use("nvim-lualine/lualine.nvim")

   -- Theme
   use({ "dracula/vim", as = "dracula" })

   -- Transparency
   use("xiyaowong/nvim-transparent")

   -- Indent lines
   use("lukas-reineke/indent-blankline.nvim")

   -- [ Config dependencies ]

   -- Required by some plugins
   use("nvim-lua/popup.nvim")
   use("nvim-lua/plenary.nvim")

   -- Autocmd
   use("jakelinnzy/autocmd-lua")

   -- [ Misc ]

   -- Calculator
   use("hrsh7th/cmp-calc")

   -- Comment frame
   use({
      "s1n7ax/nvim-comment-frame",
      requires = {
         { "nvim-treesitter" },
      },
      config = function()
         require("nvim-comment-frame").setup()
      end,
   })
   -- Dictionary
   use("uga-rosa/cmp-dictionary")

   --Discord
   --use {'andweeb/presence.nvim',
   --config = function()
   --require('presence').setup({
   --neovim_image_text = "Neo Visual Editor Improved"
   --})
   --end
   --}

   -- Emojis
   use("hrsh7th/cmp-emoji")

   -- Start menu
   use("mhinz/vim-startify")

   -- Show available keys
   use("folke/which-key.nvim")

   -- Toglleable terminal
   use("akinsho/toggleterm.nvim")

   -- Browser integration
   use({
      "glacambre/firenvim",
      run = function()
         vim.fn["firenvim#install"](0)
      end,
   })
   -- Godbolt
   use("P00f/Godbolt.Nvim")

   -- Git Decorations
   use({
      "lewis6991/gitsigns.nvim",
      requires = {
         "nvim-lua/plenary.nvim",
      },
      config = function()
         require("gitsigns").setup()
      end,
   })
   -- Packer
   use("wbthomason/packer.nvim")

   -- Programming Dahsboard
   use("wakatime/vim-wakatime")

   --[ LANG ]

   -- Completion
   use("hrsh7th/nvim-cmp")
   use("hrsh7th/cmp-buffer")
   use("hrsh7th/cmp-path")
   use("hrsh7th/cmp-cmdline")
   use("saadparwaiz1/cmp_luasnip")
   use("hrsh7th/cmp-nvim-lsp")
   use("L3MON4D3/LuaSnip")
   use("rafamadriz/friendly-snippets")

   -- LSP
   use("neovim/nvim-lspconfig")
   use("williamboman/nvim-lsp-installer")
   use("jose-elias-alvarez/null-ls.nvim")

   -- Smarter Highlighting
   use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
   use({ "p00f/nvim-ts-rainbow", requires = {
      "nvim-treesitter/nvim-treesitter",
   } })

   -- Building
   use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

   -- APL
   use("justin2004/vim-apl")

   -- Latex
   use("kdheepak/cmp-latex-symbols")

   -- Markdown
   use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

   -- Nvim_Lua
   use("hrsh7th/cmp-nvim-lua")

   if PACKER_BOOTSTRAP then
      require("packer").sync()
   end
end)
