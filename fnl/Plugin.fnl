(local lazym (require :lazy))
(fn import [path]
  (fn []
    (if path
        (let [(ok val) (pcall require path)]
          (when (not ok)
            (error (vim.inspect val)))))))

;; (fn ftplugins [x] (.. (vim.fn.stdpath :config) :/fnl/Filetypes/ x :.fnl))

(fn lazy [x]
  (lazym.setup (icollect [k v (pairs x)]
                 (do
                   (var v- v)
                   (when (not= nil (?. v- :rtp))
                     (tset v- :config
                           (fn [plugin]
                             (vim.opt.rtp:append (.. plugin.dir (. v- :rtp))))))
                   (when (and (not= nil (?. v- :file)) (= nil (?. v- :config)))
                     (tset v- :config (import v.file)))
                   (tset v- 1 k)
                   v-))))

(fn telescope-extension [name]
  #((. (require :telescope) :load_extension) name))

(lazy {:rktjmp/hotpot.nvim {:lazy false}
       :folke/neodev.nvim {:ft [:lua :fennel]}
       ;; Treesitter and LSP
       :nvim-treesitter/nvim-treesitter {:file :Lang.Treesitter}
       :neovim/nvim-lspconfig {:file :Lang.LSP
                               :dependencies [:hrsh7th/cmp-nvim-lsp]}
       :nvim-treesitter/playground {}
       :jose-elias-alvarez/null-ls.nvim {:file :Lang.Null-ls}
       ;; Editing
       :lewis6991/gitsigns.nvim {:file :Editing.Git}
       :ggandor/lightspeed.nvim {:config true}
       :numToStr/Comment.nvim {:file :Mapping.Comment}
       :akinsho/toggleterm.nvim {:config true}
       :hkupty/iron.nvim {:file :Lang.Repl}
       :farmergreg/vim-lastplace {}
       :folke/which-key.nvim {:opts {:ignore_missing true
                                     :layout {:align :center
                                              :height {:min 2}
                                              :spacing 2}}}
       :anuvyklack/hydra.nvim {}
       :nvim-colortils/colortils.nvim {:opts {:mappings {:replace_default_format :<cr>}}
                                       :cmd :Colortils}
       :hrsh7th/nvim-cmp {:file :Editing.Completion
                          :dependencies [:neovim/nvim-lspconfig
                                         :hrsh7th/cmp-buffer
                                         :hrsh7th/cmp-calc
                                         :ray-x/cmp-treesitter
                                         :hrsh7th/cmp-nvim-lua
                                         :lukas-reineke/cmp-rg
                                         :saadparwaiz1/cmp_luasnip
                                         :L3MON4D3/LuaSnip
                                         :rafamadriz/friendly-snippets
                                         :kdheepak/cmp-latex-symbols
                                         :amarakon/nvim-cmp-fonts
                                         :chrisgrieser/cmp-nerdfont
                                         :hrsh7th/cmp-emoji
                                         {1 :hrsh7th/cmp-nvim-lsp
                                          :dependencies [:neovim/nvim-lspconfig]}
                                         :hrsh7th/cmp-path
                                         :hrsh7th/cmp-nvim-lsp-signature-help
                                         :hrsh7th/cmp-cmdline
                                         {1 :vappolinario/cmp-clippy
                                          :dependencies [:nvim-lua/plenary.nvim]}]}
       :mbbill/undotree {}
       :windwp/nvim-autopairs {:opts {:check_ts true :fast_wrap {}}
                               :dependencies [:nvim-treesitter/nvim-treesitter
                                              :windwp/nvim-ts-autotag]}
       :arp242/undofile_warn.vim {}
       ;; Searching
       :nvim-tree/nvim-tree.lua {:config true
                                 :dependencies [:nvim-tree/nvim-web-devicons]}
       :nvim-telescope/telescope.nvim {:file :Editing.Telescope
                                       :dependencies [:nvim-lua/plenary.nvim
                                                      :rcarriga/nvim-notify]}
       ;; Markdown
       :iamcco/markdown-preview.nvim {:build "cd app && npm install"
                                      :ft [:markdown]}
       ;; Haskell
       :MrcJkb/haskell-tools.nvim {:dependencies [:nvim-lua/plenary.nvim
                                                  :nvim-telescope/telescope.nvim]
                                   :ft [:haskell]}
       :luc-tielen/telescope_hoogle {:config (telescope-extension :hoogle)
                                     :ft [:haskell]
                                     :dependencies [:nvim-telescope/telescope.nvim]}
       ;; Rust
       :Saecki/crates.nvim {:ft [:toml]}
       :simrat39/rust-tools.nvim {:ft [:rust]}
       ;; BQN
       "https://git.sr.ht/~detegr/nvim-bqn" {:ft [:bqn]}
       :mlochbaum/BQN {:rtp :editors/vim}
       ;; Lisp
       :bhurlow/vim-parinfer {:ft [:clojure
                                   :racket
                                   :lisp
                                   :scheme
                                   :lfe
                                   :fennel
                                   :dune]}
       ;; UI
       :j-hui/fidget.nvim {:config true}
       :HiPhish/nvim-ts-rainbow2 {:requires :nvim-treesitter}
       :NvChad/nvim-colorizer.lua {:opts {:user_default_options {:mode :virtualtext}}
                                   :name :colorizer}
       :stefanwatt/lsp-lines.nvim {:config true
                                   :dependencies [:neovim/nvim-lspconfig]}
       :rcarriga/nvim-notify {:lazy false
                              :priority 1000
                              :name :notify
                              :opts {:background_colour "#000000"
                                     :max_width 100}
                              :init #(set vim.notify (require :notify))}
       :lukas-reineke/indent-blankline.nvim {:file :UI.IndentLine}
       :Mofiqul/dracula.nvim {:lazy false :file :UI.Colors}
       :dstein64/vim-startuptime {:cmd :StartupTime}
       :stevearc/dressing.nvim {:event :VeryLazy}
       :winston0410/range-highlight.nvim {:name :range-highlight
                                          :config true
                                          :dependencies [:nvim-treesitter/nvim-treesitter
                                                         :winston0410/cmd-parser.nvim]}
       :kevinhwang91/nvim-bqf {:name :bqf :config true}
       :akinsho/bufferline.nvim {:file :UI.Tabline
                                 :dependencies :nvim-tree/nvim-web-devicons}
       :wakatime/vim-wakatime {}
       :andweeb/presence.nvim {:config #(: (require :presence) :setup)}
       :junegunn/limelight.vim {}
       :nvim-neotest/neotest {:file :Lang.Debug
                              :keys [:<leader>d]
                              :dependencies [:MrcJkb/neotest-haskell
                                             :rouge8/neotest-rust
                                             :folke/neodev.nvim
                                             :nvim-neotest/neotest-python]}
       :junegunn/goyo.vim {}})

;;       :sudormrfbin/cheatsheet.nvim {:requires [:nvim-telescope/telescope.nvim
;;                                                :nvim-lua/popup.nvim
;;                                                :nvim-lua/plenary.nvim]}

(require :Editing)

(let [{: nvim_create_autocmd : nvim_create_augroup} vim.api
      au-group (nvim_create_augroup :hotpot-ft {})
      cb #(pcall require (.. :Filetypes. (vim.fn.expand :<amatch>)))]
  (nvim_create_autocmd :FileType {:callback cb :group au-group}))
