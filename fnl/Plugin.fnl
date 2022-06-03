(module Plugin
  {autoload {packer packer}
   autoload {Func Functions}
   autoload {Startup Startup}})

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
            (print "Error Configuring" ,modname))))})

(macro setup [x extra?]
  `(a.merge 
     { :config 
        ((. (Func.alternative 
              require 
              (fn [x#] 
                {:setup (fn [] (print "Error Configuring:" x#))})
              ,x)
            :setup))} 
     ,extra?))
(use
  {
    ;;Bootstrap
    :Olical/aniseed {}                            ;Fennel in Neovim
    :wbthomason/packer.nvim {}                    ;Package Manager
    :lewis6991/impatient.nvim {}                  ;Speeds up Startup Time

    ;;Common Dependencies
    :nvim-lua/plenary.nvim {}                     ;Some Lua Functions
    :nvim-lua/popup.nvim {}                       ;Vim Popup API Implementation

    ;;Utility
    :tpope/vim-surround {}                        ;Delimeter Operations
    :windwp/nvim-autopairs                         ;Delimeter Autopairing
      (config :nvim-autopairs
              {:disable_filetype [:lisp :fennel :TelescopePrompt]
               :check_ts true
               :fast_wrap {:map :<M-e>}})
    :andymass/vim-matchup {}                      ;Enchanced % Key Functionality

    :preservim/nerdcommenter {}                   ;Commenting
    :s1n7ax/nvim-comment-frame                    ;Creating Comment Boxes
      (setup :nvim-comment-frame)
  
    :ggandor/lightspeed.nvim {}                   ;Hopper
    :mizlan/iswap.nvim {}                         ;Swap List Items, Function Arguments, etc..
    :tpope/vim-fugitive {}                        ;Git Integration

    ;;Project Navigation
    :nvim-telescope/telescope.nvim                ;General Fuzzy Finder
      {:conf-module :Util.Telescope 
       :requires 
        [[:nvim-telescope/telescope-file-browser.nvim] 
         [:nvim-telescope/telescope-media-files.nvim] 
         [:nvim-telescope/telescope-dap.nvim]
         [:nvim-telescope/telescope-ui-select.nvim]]}

    :kyazdani42/nvim-tree.lua                     ;Sidebar File Browser
       {:conf-module :Util.NvimTree
        :requires :kyazdani42/nvim-web-devicons}

    :akinsho/toggleterm.nvim (setup :toggleterm)  ;Terminal
    :ahmedkhalf/project.nvim (setup :project_nvim);Vim Project Manager

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

    :nacro90/numb.nvim (setup :numb)              ;Non Intrusive Line Peeking

    :yamatsum/nvim-cursorline                     ;Cursor Line
      (config :nvim-cursorline
              {:cursorline {:timeout 3000}})

    :lukas-reineke/indent-blankline.nvim          ;Indent Lines
      {:conf-module :UI.Indent-Blankline}

    :akinsho/bufferline.nvim                      ;Tabs
      (config :bufferline
              {:diagnostics :nvim_lsp})

    :RRethy/vim-hexokinase 
      {:run "make hexokinase"}

    :folke/zen-mode.nvim (setup :zen-mode)        ;Zen Coding

    :goolord/alpha-nvim                           ;Startup Dashboard
      {:conf-module :Startup}                        

    :Mofiqul/dracula.nvim                         ;Dracula Theme
       {:conf-module :UI.Dracula}

    :stevearc/dressing.nvim (setup :dressing)

    :nvim-lualine/lualine.nvim                    ;Vim Status-Line
      {:conf-module :UI.Lualine
       :requires
        [[:SmiteshP/nvim-gps]]}                 

    :camspiers/animate.vim {}                     ;Window Animation Library
    :rainbowhxch/beacon.nvim {}                   ;Highlight On Large Cursor Jumps


    ;LANG
    :mfussenegger/nvim-dap                        ;Debugger
      {:conf-module :Lang.Dap
       :requires 
        [[:rcarriga/nvim-dap-ui]
         [:theHamsta/nvim-dap-virtual-text]]}                     

    :jose-elias-alvarez/null-ls.nvim              ;Null Language Server
      {:conf-module :Lang.Null-ls}           
    :hrsh7th/nvim-cmp 
      {:conf-module :Lang.Cmp-Nvim
       :requires
        [[:hrsh7th/cmp-nvim-lsp]
         [:L3MON4D3/LuaSnip
          :hrsh7th/cmp-calc
          :uga-rosa/cmp-dictionary
          :hrsh7th/cmp-cmdline
          :hrsh7th/cmp-nvim-lua
          :kdheepak/cmp-latex-symbols
          :ray-x/cmp-treesitter
          :hrsh7th/cmp-nvim-lsp-signature-help
          :hrsh7th/cmp-path
          :hrsh7th/cmp-buffer]]}

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

    :neovim/nvim-lspconfig                        ;LSP 
      {:conf-module :Lang.LSP
       :requires 
        [[:hrsh7th/nvim-cmp]
         [:pierreglaser/folding-nvim]]}

    :vlime/vlime {}                               ;Common Lisp Dev Environment
    :bhurlow/vim-parinfer {}                      ;Parenthesis Inferring for Writting Lisps
    :justin2004/vim-apl {}                        ;APL Syntax Highlighting
  
    ;;Misc
    :andweeb/presence.nvim                        ;Discord Presence
      {:config (let [(status-ok presence) (pcall require :presence)]
                 (if status_ok 
                   (presence:setup
                    {:neovim_image_text "Neovim"})
                   (print "Error Configuring: Presence")))}
                 
    :wakatime/vim-wakatime {}                     ;Code Time Tracking
    :github/copilot.vim {}})                      ;Copilot
  
