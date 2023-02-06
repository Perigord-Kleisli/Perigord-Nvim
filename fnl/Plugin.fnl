(local lazym (require :lazy))
(fn import [path]
  (fn []
    (if path
        (let [(ok val) (pcall require path)]
          (when (not ok)
            (error (vim.inspect val)))))))

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
                   (if (string.find k "^~/")
                       (tset v- :dir k)
                       (tset v- 1 k))
                   v-))))

(fn telescope-extension [name]
  #((. (require :telescope) :load_extension) name))

(fn cur-macro []
  (let [recording (vim.fn.reg_recording)]
    (if (= "" recording) "" (.. "recording macro: (" recording ")"))))

(lazy {:rktjmp/hotpot.nvim {:lazy false}
       ;; Treesitter and LSP
       :nvim-treesitter/nvim-treesitter {:file :Lang.Treesitter}
       :nvim-treesitter/nvim-treesitter-textobjects {:dependencies [:nvim-treesitter/nvim-treesitter]}
       :neovim/nvim-lspconfig {:file :Lang.LSP
                               :dependencies [:hrsh7th/cmp-nvim-lsp]}
       :nvim-treesitter/playground {}
       :jose-elias-alvarez/null-ls.nvim {:file :Lang.Null-ls}
       ;; Editing
       :booperlv/nvim-gomove {:opts {:map_default false}}
       :kylechui/nvim-surround {:config true}
       :Trouble-Truffle/sesh.nvim {:opts {:autosave {:enable true :autocmds []}
                                          :autoload {:enable true}
                                          :autoswitch {:enable true
                                                       :exclude_ft [:lazy]}}
                                   :init (telescope-extension :sesh)
                                   :dependencies [:nvim-telescope/telescope.nvim]}
       :lewis6991/gitsigns.nvim {}
       :anuvyklack/vim-smartword {}
       :TimUntersberger/neogit {:config true}
       :ggandor/leap.nvim {:config true}
       :ggandor/flit.nvim {:config true :dependencies [:ggandor/leap.nvim]}
       :numToStr/Comment.nvim {:opts {:toggler {:line :<leader>c<leader>
                                                :block :<leader>cbb}
                                      :opleader {:line :<leader>c
                                                 :block :<leader>cb}
                                      :extra {:above :<leader>cO
                                              :below :<leader>co
                                              :eol :<leader>cA}}}
       :akinsho/toggleterm.nvim {:config true}
       :farmergreg/vim-lastplace {}
       :folke/which-key.nvim {:opts {:ignore_missing false
                                     :layout {:align :center
                                              :height {:min 2}
                                              :spacing 3}}}
       :anuvyklack/hydra.nvim {}
       :nvim-colortils/colortils.nvim {:opts {:mappings {:replace_default_format :<cr>}}
                                       :cmd :Colortils}
       :luukvbaal/statuscol.nvim {:opts {:foldfunc :builtin :setopt true}}
       :kevinhwang91/nvim-ufo {:file :UI.Column
                               :dependencies [:kevinhwang91/promise-async]}
       ;; Completions
       :hrsh7th/nvim-cmp {:file :Editing.Completion
                          :dependencies [:neovim/nvim-lspconfig]}
       :hrsh7th/cmp-buffer {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-calc {:dependencies [:hrsh7th/nvim-cmp]}
       :ray-x/cmp-treesitter {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-nvim-lua {:dependencies [:hrsh7th/nvim-cmp]}
       :lukas-reineke/cmp-rg {:dependencies [:hrsh7th/nvim-cmp]}
       :saadparwaiz1/cmp_luasnip {:dependencies [:hrsh7th/nvim-cmp]}
       :L3MON4D3/LuaSnip {:dependencies [:hrsh7th/nvim-cmp]}
       :rafamadriz/friendly-snippets {:dependencies [:L3MON4D3/LuaSnip
                                                     :hrsh7th/nvim-cmp]}
       :kdheepak/cmp-latex-symbols {:dependencies [:hrsh7th/nvim-cmp]}
       :amarakon/nvim-cmp-fonts {:dependencies [:hrsh7th/nvim-cmp]}
       :chrisgrieser/cmp-nerdfont {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-emoji {:dependencies [:hrsh7th/nvim-cmp]}
       :hrsh7th/cmp-nvim-lsp {:dependencies [:neovim/nvim-lspconfig
                                             :hrsh7th/nvim-cmp]}
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
       ;; Neovim
       :folke/neodev.nvim {:ft [:lua :fennel]}
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
       :simrat39/symbols-outline.nvim {:opts {:width 15}}
       :glepnir/dashboard-nvim {:event :UIEnter :config #(require :UI.Startup)}
       :karb94/neoscroll.nvim {:config true}
       :nacro90/numb.nvim {:config true}
       :rcarriga/nvim-notify {:lazy false
                              :priority 1000
                              :name :notify
                              :opts {:background_colour "#000000"
                                     :max_width 100}
                              :init #(set vim.notify (require :notify))}
       :folke/noice.nvim {:opts {:notify {:enabled false}
                                 :views {:cmdline_popup {:position {:row "95%"
                                                                    :col "50%"}}}}
                          :lazy false
                          :priority 1000
                          :dependencies [:MunifTanjim/nui.nvim]}
       :nvim-lualine/lualine.nvim {:opts {:sections {:lualine_a [:mode]
                                                     :lualine_b [:filetype
                                                                 :filename
                                                                 :diagnostics]
                                                     :lualine_c [:branch :diff]
                                                     :lualine_x [cur-macro]
                                                     :lualine_y [:encoding
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
       :HiPhish/nvim-ts-rainbow2 {:requires :nvim-treesitter}
       :NvChad/nvim-colorizer.lua {:opts {:user_default_options {:mode :virtualtext}}
                                   :name :colorizer}
       :stefanwatt/lsp-lines.nvim {:config true
                                   :dependencies [:neovim/nvim-lspconfig]}
       :lukas-reineke/indent-blankline.nvim {:name :indent_blankline
                                             :opts {:show_end_of_line true
                                                    :show_current_context true
                                                    :show_current_context_start true}
                                             :init #(do
                                                      (set vim.opt.list true)
                                                      (vim.opt.listchars:append "eol:↴")
                                                      (set vim.g.indentLine_enabled
                                                           1))}
       :Mofiqul/dracula.nvim {:lazy false :file :UI.Colors}
       :stevearc/dressing.nvim {:event :VeryLazy}
       :kevinhwang91/nvim-bqf {:name :bqf :config true}
       :akinsho/bufferline.nvim {:opts {:options {:hover {:enabled true}
                                                  :diagnostics :nvim_lsp
                                                  :offsets [{:filetype :NvimTree}]}}
                                 :dependencies :nvim-tree/nvim-web-devicons}
       :wakatime/vim-wakatime {}
       :andweeb/presence.nvim {:config #(: (require :presence) :setup)}})

(require :Editing)
(require :Filetypes)
