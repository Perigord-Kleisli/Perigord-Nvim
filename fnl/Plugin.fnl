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
       :ggandor/leap.nvim {:config true}
       :ggandor/flit.nvim {:config true :dependencies [:ggandor/leap.nvim]}
       :numToStr/Comment.nvim {:file :Mapping.Comment}
       :akinsho/toggleterm.nvim {:config true}
       :hkupty/iron.nvim {:file :Lang.Repl}
       :farmergreg/vim-lastplace {}
       :folke/which-key.nvim {:opts {:ignore_missing false
                                     :layout {:align :center
                                              :height {:min 2}
                                              :spacing 2}}}
       :anuvyklack/hydra.nvim {}
       :nvim-colortils/colortils.nvim {:opts {:mappings {:replace_default_format :<cr>}}
                                       :cmd :Colortils}
       :hrsh7th/nvim-cmp {:file :Editing.Completion
                          :dependencies [:neovim/nvim-lspconfig]}
       :hrsh7th/cmp-buffer {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-calc {:dependencies [:hrsh7th/nvim-cmp]}
       :ray-x/cmp-treesitter {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-nvim-lua {:dependencies [:hrsh7th/nvim-cmp]}
       :lukas-reineke/cmp-rg {:dependencies [:hrsh7th/nvim-cmp]}
       :saadparwaiz1/cmp_luasnip {:dependencies [:hrsh7th/nvim-cmp]}
       :L3MON4D3/LuaSnip {:dependencies [:hrsh7th/nvim-cmp]}
       :rafamadriz/friendly-snippets {:dependencies [:L3MON4D3/LuaSnip :hrsh7th/nvim-cmp]}
       :kdheepak/cmp-latex-symbols {:dependencies [:hrsh7th/nvim-cmp]}
       :amarakon/nvim-cmp-fonts {:dependencies [:hrsh7th/nvim-cmp]}
       :chrisgrieser/cmp-nerdfont {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-emoji {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-nvim-lsp {:dependencies [:neovim/nvim-lspconfig :hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-path {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-cmdline {:dependencies [:hrsh7th/nvim-cmp]}

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
       :Saecki/crates.nvim {:opts {:null_ls {:enabled true :name :Crates}}}
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
       ;; Testing
       :nvim-neotest/neotest {:file :Lang.Debug
                              :keys [:<leader>d]
                              :dependencies [:MrcJkb/neotest-haskell
                                             :rouge8/neotest-rust
                                             :folke/neodev.nvim
                                             :nvim-neotest/neotest-python]}
       ;; UI
       :rcarriga/nvim-notify {:lazy false
                              :priority 1000
                              :name :notify
                              :opts {:background_colour "#000000"
                                     :max_width 100}
                              :init #(set vim.notify (require :notify))}
       :folke/noice.nvim {:opts {:notify {:enabled false}
                                 :views {:cmdline_popup {:position {:row "95%"
                                                                    :col "50%"}}}}
                          :dependencies [:MunifTanjim/nui.nvim]}
       :nvim-lualine/lualine.nvim {:opts {:sections {:lualine_b [:filetype
                                                                 :filename
                                                                 :diagnostics]
                                                     :lualine_c [:branch :diff]
                                                     :lualine_x [:encoding]
                                                     :lualine_y [[""]
                                                                 :location
                                                                 :progress]
                                                     :lualine_z ["os.date('%I:%M %p')"]}}
                                   :init #(set vim.o.laststatus 3)
                                   :dependencies [:nvim-tree/nvim-web-devicons]}
       :utilyre/barbecue.nvim {:config true
                               :dependencies [:neovim/nvim-lspconfig
                                              :SmiteshP/nvim-navic
                                              :nvim-tree/nvim-web-devicons]}
       :folke/trouble.nvim {:config true
                            :dependencies [:nvim-tree/nvim-web-devicons]}
       ;; :j-hui/fidget.nvim {:config true}
       :HiPhish/nvim-ts-rainbow2 {:requires :nvim-treesitter}
       :NvChad/nvim-colorizer.lua {:opts {:user_default_options {:mode :virtualtext}}
                                   :name :colorizer}
       :stefanwatt/lsp-lines.nvim {:config true
                                   :dependencies [:neovim/nvim-lspconfig]}
       :lukas-reineke/indent-blankline.nvim {:file :UI.IndentLine}
       :Mofiqul/dracula.nvim {:lazy false :file :UI.Colors}
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
       :junegunn/goyo.vim {}})

;;       :sudormrfbin/cheatsheet.nvim {:requires [:nvim-telescope/telescope.nvim
;;                                                :nvim-lua/popup.nvim
;;                                                :nvim-lua/plenary.nvim]}

(require :Editing)

(let [{: nvim_create_autocmd : nvim_create_augroup} vim.api
      au-group (nvim_create_augroup :hotpot-ft {})
      cb #(pcall require (.. :Filetypes. (vim.fn.expand :<amatch>)))]
  (nvim_create_autocmd :FileType {:callback cb :group au-group}))

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern :Cargo.toml
                              :callback #(require :Filetypes.cargo)})
