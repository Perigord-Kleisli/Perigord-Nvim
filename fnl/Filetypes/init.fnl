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

(lambda basic-lsp [lang lsp]
  #(let [lspconfig (require :lspconfig)
         {: capabilities} (require :Lang.LSP)]
     (set vim.bo.filetype lang)
     ((. lspconfig lsp :setup) {: capabilities})
     (vim.cmd.LspStart lsp)))

(lambda basic-module [lang]
  #(do
     (set vim.bo.filetype lang)
     (require (.. :Filetypes. lang))))

(local function_extensions
       {:cpp #(let [clangd-ext (require :clangd_extensions)
                    {: capabilities} (require :Lang.LSP)]
                (set vim.bo.filetype :cpp)
                (clangd-ext.setup {:server {: capabilities}})
                (vim.cmd.LspStart :clangd))
        :rs (basic-module :rust)
        :fnl (basic-module :fennel)
        :md (basic-module :markdown)
        :hs (basic-module :haskell)
        :lua (basic-module :lua)
        :nix (basic-module :nix)
        :bqn (basic-module :bqn)})

(local function_literal {:CMakeLists.txt (basic-lsp :cmake :cmake)
                         :notify #(vim.notify :asdasd)})

(let [ft (require :filetype)]
  (ft.setup {:overrides {:extensions {:lalrpop :lalrpop}
                         :literal {:Cargo.toml :cargo}
                         : function_extensions
                         : function_literal}}))
