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
     ((. lspconfig lsp :setup) (vim.tbl_extend :force {: capabilities}
                                               (or ?options [])))
     (vim.cmd.LspStart lsp)))

(lambda basic-module [lang ?file]
  #(do
     (set vim.bo.filetype lang)
     (require (or ?file (.. :Filetypes. lang)))))

(let [lspconfig (require :lspconfig)
      {: capabilities} (require :Lang.LSP)
      schemastore (require :schemastore)]
  (lspconfig.jsonls.setup {:settings {:json {:schemas (schemastore.json.schemas)}
                                      :validate {:enable true}}
                           : capabilities
                           :cmd [:vscode-json-languageserver :--stdio]}))

(local function_extensions
       {:cpp (basic-module :cpp)
        :c (basic-module :c)
        :cc (basic-module :cpp)
        :sh (basic-lsp :bash :bashls)
        :bash (basic-lsp :bash :bashls)
        :h (basic-module :cpp)
        :html (basic-module :html)
        :cs (basic-module :cs)
        :css (basic-lsp :css :cssls {:cmd [:vscode-css-language-server :--stdio]})
        :fs #(set vim.bo.filetype :fsharp)
        :vert (basic-lsp :glsl :glsl_analyzer)
        :ex (basic-lsp :elixir :elixirls {:cmd [:elixir-ls]})
        :exs (basic-lsp :elixir :elixirls {:cmd [:elixir-ls]})
        :heex (basic-module :heex :Filetypes.elixir)
        :exs (basic-lsp :elixir :elixirls {:cmd [:elixir-ls]})
        :frag (basic-lsp :glsl :glsl_analyzer)
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
        :kt (basic-lsp :kotlin :kotlin_language_server)
        :sql #(set vim.bo.filetype :sql)
        :ua (basic-module :uiua)
        :bqn (basic-module :bqn)})

(local function_literal {:CMakeLists.txt (basic-lsp :cmake :cmake)
                         :Cargo.toml (basic-module :cargo)
                         :notify #(vim.notify :asdasd)})

(let [ft (require :filetype)]
  (ft.setup {:overrides {:extensions {:lalrpop :lalrpop}
                         : function_extensions
                         :shebang {:bash :bash}
                         : function_literal}}))
