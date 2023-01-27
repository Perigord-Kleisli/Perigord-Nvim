(local hydra (require :Mapping.Lang))
(local ht (require :haskell-tools))
(local capabilities (. (require :Lang.LSP) :capabilities))

(fn on_attach [client bufnr]
  (local _opts (vim.tbl_extend :keep {:noremap true :silent true}
                               {:buffer bufnr}))
  ;; (local extensions (. (require :telescope) :extensions))
  (ht.tags.generate_project_tags nil {:refresh true})
  (vim.lsp.codelens.display nil bufnr client)
  (hydra {:extra-heads [[:R ht.repl.toggle {:desc "Toggle REPL" :exit true}]
                        [:<C-r>
                         ht.repl.reload
                         {:desc "Reload REPL" :exit true}]
                        [:e
                         vim.lsp.codelens.run
                         {:desc "Evaluate Codelens" :exit true}]]}))

(ht.setup {:hls {: capabilities
                 :settings {:haskell {:formattingProvider :ormolu
                                      :plugin {:rename {:config {:diff true}}}}}
                 :cmd [:haskell-language-server :--lsp]
                 : on_attach}
           :repl :toggleterm})

(vim.cmd ":LspStart hls")
