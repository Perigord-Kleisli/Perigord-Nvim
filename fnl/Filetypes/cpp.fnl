(local clangd (require :clangd_extensions))
(local {: capabilities} (require :Lang.LSP))

(clangd.setup)
(clangd.setup {:server {: capabilities} :inlay_hints {} :autoSetHints true})

