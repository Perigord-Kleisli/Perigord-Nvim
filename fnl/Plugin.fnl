(local packer (require :packer))
(local packer (require :packer))

(fn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require name)]
    (when (not ok?)
      (print (.. "dotfiles error: " name ":" val-or-err)))))

(fn assoc [t k v]
  (tset t k v)
  t)

(fn use [plugins]
  (packer.startup (fn [use]
                    (each [name opts (pairs plugins)]
                      (when (not= opts.setup nil)
                        (tset opts :config
                              (do
                                ((. (require opts.setup) :setup)))))
                      (-?> opts.mod safe-require-plugin-config)
                      (use (assoc opts 1 name))))))

(use {:wbthomason/packer.nvim {}
      :lewis6991/impatient.nvim {}
      :rktjmp/hotpot.nvim {}
      :nvim-telescope/telescope.nvim {:mod :Editing.Telescope
                                      :requires [:luc-tielen/telescope_hoogle
                                                 :nvim-lua/plenary.nvim]}
      :nvim-tree/nvim-tree.lua {:mod :UI.Sidebar-Explorer
                                :requires :nvim-tree/nvim-web-devicons}
      :anuvyklack/hydra.nvim {}
      :Mofiqul/dracula.nvim {}
      :neovim/nvim-lspconfig {:mod :Lang.LSP}
      :numToStr/Comment.nvim {:mod :Mapping.Comment}
      :echasnovski/mini.indentscope {:mod :UI.IndentLine}
      :nvim-treesitter/nvim-treesitter {:mod :Lang.Treesitter
                                        :requires [:windwp/nvim-ts-autotag]}
      :HiPhish/nvim-ts-rainbow2 {:requires :nvim-treesitter}
      :winston0410/range-highlight.nvim {:mod :UI.Highlight
                                         :requires [:nvim-treesitter/nvim-treesitter
                                                    :winston0410/cmd-parser.nvim]}
      :nvim-treesitter/playground {}
      :sudormrfbin/cheatsheet.nvim {:requires [:nvim-telescope/telescope.nvim
                                               :nvim-lua/popup.nvim
                                               :nvim-lua/plenary.nvim]}
      :akinsho/bufferline.nvim {:mod :UI.Tabline
                                :tag :v3.*
                                :requires :nvim-tree/nvim-web-devicons}
      :lewis6991/gitsigns.nvim {}
      :bhurlow/vim-parinfer {}
      :hrsh7th/nvim-cmp {:mod :Editing.Completion
                         :requires [:neovim/nvim-lspconfig
                                    :hrsh7th/cmp-buffer
                                    :hrsh7th/cmp-calc
                                    :ray-x/cmp-treesitter
                                    :hrsh7th/cmp-nvim-lua
                                    :kdheepak/cmp-latex-symbols
                                    :amarakon/nvim-cmp-fonts
                                    :chrisgrieser/cmp-nerdfont
                                    :hrsh7th/cmp-emoji
                                    :hrsh7th/cmp-nvim-lsp
                                    :hrsh7th/cmp-path
                                    :hrsh7th/cmp-nvim-lsp-signature-help
                                    :hrsh7th/cmp-cmdline
                                    :vappolinario/cmp-clippy
                                    :L3MON4D3/LuaSnip]}
      :Saecki/crates.nvim {}
      :jose-elias-alvarez/null-ls.nvim {:mod :Lang.Null-ls}
      :j-hui/fidget.nvim {:mod :UI.Statusline}
      :akinsho/toggleterm.nvim {:mod :UI.Terminal}
      :hkupty/iron.nvim {:mod :Lang.Repl}
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {}
      :MrcJkb/haskell-tools.nvim {:requires [:neovim/nvim-lspconfig
                                             :nvim-lua/plenary.nvim
                                             :nvim-telescope/telescope.nvim]}
      :iamcco/markdown-preview.nvim {:run "cd app && npm install"}
      :mfussenegger/nvim-dap {:mod :Lang.Debug}
      :nvim-neotest/neotest {:mod :Lang.Debug
                             :requires [:MrcJkb/neotest-haskell
                                        :rouge8/neotest-rust
                                        :folke/neodev.nvim
                                        :nvim-neotest/neotest-python
                                        :antoinemadec/FixCursorHold.nvim]}
      :kevinhwang91/nvim-bqf {:mod :UI}
      :simrat39/rust-tools.nvim {}
      :rcarriga/nvim-notify {}
      :stevearc/dressing.nvim {:mod :UI}
      :mbbill/undotree {:mod :Editing}
      :andweeb/presence.nvim {:mod :UI}
      :ggandor/lightspeed.nvim {}
      :wakatime/vim-wakatime {}
      :windwp/nvim-autopairs {}
      :arp242/undofile_warn.vim {}
      :junegunn/limelight.vim {}
      :junegunn/goyo.vim {}
      "https://git.sr.ht/~detegr/nvim-bqn" {}
      :mlochbaum/BQN {:run "cp -r editors/vim/* ."}
      :NvChad/nvim-colorizer.lua {:mod :UI}
      :nvim-colortils/colortils.nvim {:mod :UI}
      :farmergreg/vim-lastplace {}})

