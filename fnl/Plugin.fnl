(module Plugin
  {autoload {packer packer}
   autoload {Func Functions}
   autoload {Startup Startup}})

(require :UI.Neovide)

(defn safe-require [mod]
  (let [(status_ok plugin) (pcall require mod)]
    (when (not status_ok)
      (print "Error Importing:" mod "\n" "Log: \n\n" plugin))))

(packer.init
  {:display
   {:open_fn
    (fn []
      ((. (require :packer.util) :float) {:border :rounded}))}})

(defn- use [plugtable]
  (packer.startup
    {:config
       {:compile_path (.. (vim.fn.stdpath "config") "/lua/External/Packer_compiled.lua")}
     1 (fn [use]
         (each [name opts (pairs plugtable)]
           (-?> (. opts :conf-module) (safe-require))
           (table.insert opts 1 name)
           (use opts)))})
  nil)

(def- a (require :aniseed.core))
(macro config [modname config]
  '{:config
    (do (let [(status_ok# module-name#) (pcall require ,modname)]
          (if status_ok#
            (module-name#.setup ,config)
            (print "Error Configuring" ,modname "\n"))))})

(macro setup [x extra?]
  `(a.merge
     { :config
        ((. (Func.alternative
              require
              (fn [x#]
                {:setup (fn [] (print "Error Configuring:" x# "\n"))})
              ,x)
            :setup))}
     ,extra?))
(use
  {
    ;;Bootstrap
    :Olical/aniseed {}                            ;Fennel in Neovim
    :wbthomason/packer.nvim {}                    ;Package Manager
    :lewis6991/impatient.nvim {}                  ;Speeds up Startup Time
   :MunifTanjim/nui.nvim {}                      ;Nvim UI Library

    ;;Common Dependencies
    :nvim-lua/plenary.nvim {}                     ;Some Lua Functions
    :nvim-lua/popup.nvim {}                       ;Vim Popup API Implementation

    ;;Utility
    :arp242/undofile_warn.vim {}                  ;Warns when doing an Undo not part of current session

    :tpope/vim-surround {}                        ;Delimeter Operations
    :windwp/nvim-autopairs                         ;Delimeter Autopairing
      (config :nvim-autopairs
              {:disable_filetype [:lisp :fennel :TelescopePrompt]
               :check_ts true
               :fast_wrap {:map :<M-e>}})
    :andymass/vim-matchup {}                      ;Enchanced % Key Functionality
    ;:abecodes/tabout.nvim (setup :tabout)        ;Tabing out of delimeters
    :Trouble-Truffle/Prog-Nvim                    ;Project Manager
      (setup :prog {:requires [[:Trouble-Truffle/PeriLib-Nvim]]})      

    :preservim/nerdcommenter {}                   ;Commenting
    :s1n7ax/nvim-comment-frame                    ;Creating Comment Boxes
      (setup :nvim-comment-frame)

    :folke/todo-comments.nvim                     ;Todo Comments
      (setup :todo-comments) 

    :ggandor/lightspeed.nvim {}                   ;Hopper
    :tpope/vim-fugitive {}                        ;Git Integration
    :TimUntersberger/neogit (setup :neogit)       ;Git Integration
    :lewis6991/gitsigns.nvim (setup :gitsigns)    ;Git Integration
    :f-person/git-blame.nvim {}                   ;Git Blame Integration
    :editorconfig/editorconfig-vim {}             ;EditorConfig

    ;;Project Navigation
    :nvim-telescope/telescope.nvim                ;General Fuzzy Finder
      {:conf-module :Util.Telescope
       :requires
        [[:nvim-telescope/telescope-file-browser.nvim]
         [:nvim-telescope/telescope-media-files.nvim]
         [:nvim-telescope/telescope-dap.nvim]
         { 1 :mrcjkb/telescope-manix :branch "0.1.x"}
         [:nvim-telescope/telescope-ui-select.nvim]]}

    :kyazdani42/nvim-tree.lua                     ;Sidebar File Browser
       {:conf-module :Util.NvimTree
        :requires :kyazdani42/nvim-web-devicons}

    :akinsho/toggleterm.nvim (setup :toggleterm)  ;Terminal

    :folke/which-key.nvim                         ;Key Binding
      {:conf-module :Mapping
       :requires :mrjones2014/legendary.nvim}

    :farmergreg/vim-lastplace {}                  ;Save Last Position
    :rmagatti/auto-session                        ;Session Manager
      (config :auto-session
              {:auto_session_enabled false
               :auto_session_suppress_dirs ["~"]
               :auto_save_enabled true
               :auto_session_create_enabled false})

    :ekickx/clipboard-image.nvim {}               ;Allow Image Pasting


    ;;UI

   :luukvbaal/stabilize.nvim                     ;Stabilize Window on resize events
      (setup :stabilize)

   ;:VonHeikemen/fine-cmdline.nvim                ;Command Line UI
      ;(config :fine-cmdline
             ;{:popup {:position {:row "95%"}}
              ;:cmdline {:prompt ":" :enable_keymaps false}})

    :rcarriga/nvim-notify {}                      ;Notification UI

    :nacro90/numb.nvim (setup :numb)              ;Non Intrusive Line Peeking

    :yamatsum/nvim-cursorline                     ;Cursor Line
      (config :nvim-cursorline
              {:cursorline {:timeout 3000}})

    :lukas-reineke/indent-blankline.nvim          ;Indent Lines
      {:conf-module :UI.Indent-Blankline}

    :akinsho/bufferline.nvim                      ;Tabs
      (config :bufferline
              {:options {:diagnostics :nvim_lsp}})

    :RRethy/vim-hexokinase
      {:run "make hexokinase"}

    :folke/zen-mode.nvim (setup :zen-mode)        ;Zen Coding

    :goolord/alpha-nvim                           ;Startup Dashboard
      {:conf-module :Startup}

    :Mofiqul/dracula.nvim                         ;Dracula Theme
       {:conf-module :UI.Colorscheme
        :commit :0b4f6e009867027caddc1f28a81d8a7da6a2b277}

    :stevearc/dressing.nvim (setup :dressing)

    :nvim-lualine/lualine.nvim                    ;Vim Status-Line
      {:conf-module :UI.Lualine
       :requires
        [[:SmiteshP/nvim-gps]
         [:SmiteshP/nvim-navic]]}
         
    :rainbowhxch/beacon.nvim {}                   ;Highlight On Large Cursor Jumps


    ;LANG
    :CRAG666/code_runner.nvim {:conf-module :Lang.CodeRunner}
    :simrat39/symbols-outline.nvim {}             ;LSP Symbol Outline
    :michaelb/sniprun                             ;Code Snippet Runner
      (config :sniprun
              {:display
                [:TempFloatingWindow]})
    :amrbashir/nvim-docs-view {}                  ;Documentation Viewer
    :j-hui/fidget.nvim                            ;LSP Progress Indicator
      (setup :fidget)

    :mfussenegger/nvim-dap                        ;Debugger
      {:conf-module :Lang.Dap
       :requires
        [[:rcarriga/nvim-dap-ui]
         [:mfussenegger/nvim-dap-python]
         [:theHamsta/nvim-dap-virtual-text]]}

    :jose-elias-alvarez/null-ls.nvim              ;Null Language Server
      {:conf-module :Lang.Null-ls}

    :hrsh7th/nvim-cmp                             ;Completion
      {:conf-module :Lang.Cmp-Nvim
       :requires
       [
        [:hrsh7th/cmp-nvim-lsp]
        [:L3MON4D3/LuaSnip]
        [:hrsh7th/cmp-calc]
        [:uga-rosa/cmp-dictionary]
        [:lukas-reineke/cmp-under-comparator]
        [:hrsh7th/cmp-cmdline]
        [:hrsh7th/cmp-nvim-lua]
        [:kdheepak/cmp-latex-symbols]
        [:ray-x/cmp-treesitter]
        [:hrsh7th/cmp-nvim-lsp-signature-help]
        [:hrsh7th/cmp-path]
        [:hrsh7th/cmp-buffer]]}

    :p00f/nvim-ts-rainbow {}                      ;Color Coded Parentheses

    :nvim-treesitter/nvim-treesitter              ;Incremental Parsing
      {:conf-module :Lang.Treesitter
       :requires
       [[:nvim-treesitter/nvim-treesitter-context]
        [:nvim-treesitter/nvim-treesitter-textobjects]
        [:nvim-treesitter/nvim-treesitter-refactor]]}


    :nvim-treesitter/playground {}                ;Tree-Sitter info view

    :davidgranstrom/nvim-markdown-preview         ;Markdown Compiler and Previewer
      {:config (set vim.g.nvim_markdown_preview_theme :solarized-dark)}

    :neovim/nvim-lspconfig                        ;LSP Config
      {:conf-module :Lang.LSP
       :requires
        [[:hrsh7th/nvim-cmp]]}

    :simrat39/rust-tools.nvim                     ;Rust Tools
      (setup :rust-tools)

    :LnL7/vim-nix {}                              ;Nix

    :Nymphium/vim-koka {}                         ;Koka Language

    :vlime/vlime {}                               ;Common Lisp Dev Environment
    :bhurlow/vim-parinfer {}                      ;Parenthesis Inferring for Writting Lisps

    :ShinKage/idris2-nvim {}

    :justin2004/vim-apl {}                        ;APL Syntax Highlighting

    ;;Misc

    :ShinKage/idris2-nvim                        ;Idris2 integration
      (config :idris2 {})

    :glacambre/firenvim                           ;Firefox Integration
      {:run (fn [] ((. vim.fn :firenvim#install) 0))}

    :p00f/godbolt.nvim                            ;Godbolt
      (config :godbolt
        {:languages 
          {:haskell {:compiler :ghc901}}})

    :andweeb/presence.nvim                        ;Discord Presence
      {:config (let [(status-ok presence) (pcall require :presence)]
                 (if status_ok
                   (presence:setup
                    {:neovim_image_text "Neovim"})
                   (print "Error Configuring: Presence")))}

    :wakatime/vim-wakatime {}})                     ;Code Time Tracking

