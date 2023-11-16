(fn buf-cmds []
  (match vim.bo.filetype
    :notify (do
              (vim.defer_fn #(do
                               (set vim.o.number false)
                               (set vim.o.relativenumber false))
                            15)
              (vim.keymap.set :n :q ":q<cr>" {:silent true :buffer true})
              (vim.keymap.set :n :<esc> ":q<cr>" {:silent true :buffer true}))))

(vim.api.nvim_create_autocmd [:BufWinEnter]
                             {:pattern "*" :callback #(vim.schedule buf-cmds)})

(lambda basic-lsp [lang lsp ?options]
  #(let [lspconfig (require :lspconfig)
         {: capabilities} (require :Lang.LSP)]
     (set vim.bo.filetype lang)
     ((. lspconfig lsp :setup) (vim.tbl_extend :force {: capabilities} (or ?options [])))
     (vim.cmd.LspStart lsp)))

(lambda basic-module [lang]
  #(do
     (set vim.bo.filetype lang)
     (require (.. :Filetypes. lang))))

(local function_extensions
       {:cpp (basic-module :cpp)
        :c (basic-module :c)
        :h (basic-module :c)
        :ts (basic-lsp :typescript :tsserver)
        :js (basic-lsp :javascript :tsserver)
        :mjs (basic-lsp :javascript :tsserver)
        :html (basic-module :html)
        :css (basic-lsp :css :cssls {:cmd ["css-languageserver" "--stdio"]})
        :fs #(set vim.bo.filetype :fsharp)
        :cs (basic-module :cs)
        :py (basic-module :python)
        :idr (basic-module :idris2)
        :rs (basic-module :rust)
        :fnl (basic-module :fennel)
        :md (basic-module :markdown)
        :hs (basic-module :haskell)
        :apl (basic-module :apl)
        :dyalog (basic-module :apl)
        :lua (basic-module :lua)
        :lean (basic-module :lean)
        :nix (basic-module :nix)
        :bqn (basic-module :bqn)})

(local function_literal {:CMakeLists.txt (basic-lsp :cmake :cmake)
                         :Cargo.toml (basic-module :cargo)
                         :notify #(vim.notify :asdasd)})

(let [ft (require :filetype)]
  (ft.setup {:overrides {:extensions {:lalrpop :lalrpop}
                         : function_extensions
                         : function_literal}}))
