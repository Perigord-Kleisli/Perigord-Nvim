(local ht (require :haskell-tools))
(local {: capabilities} (require :Lang.LSP))
(local {: cmd} (require :hydra.keymap-util))

(fn on_attach [client bufnr]
  (vim.lsp.codelens.display nil bufnr client)
  (local {:lang-map wk} (require :Mapping.Lang))
  (wk {:name "Haskell"
       :pattern :*.hs
       :heads [[:R ht.repl.toggle {:desc "Toggle REPL"}]
               [:<C-r> ht.repl.reload {:desc "Reload REPL"}]
               [:p (cmd :HsPackageCabal) {:desc "Open Cabal File"}]
               [:P (cmd :HsProjectFile) {:desc "Open Project File"}]
               [:h (cmd "Telescope hoogle") {:desc "Hoogle search"}]]}))

(ht.setup {:hls {: capabilities
                 :settings {:haskell {:formattingProvider :fourmolu
                                      :plugin {:rename {:config {:diff true}}}}}
                 :cmd [:haskell-language-server :--lsp]
                 : on_attach}
           :tools {:repl {:handler :toggleterm :auto_focus true}}})

(ht.lsp.start)
