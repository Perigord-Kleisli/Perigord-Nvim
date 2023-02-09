(let [clangd-ext (require :clangd_extensions)
      {: capabilities} (require :Lang.LSP)]
  (clangd-ext.setup {:server {: capabilities}}))
