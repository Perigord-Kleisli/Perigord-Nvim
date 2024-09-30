(local lspconfig (require :lspconfig))
(local {: capabilities} (require :Lang.LSP))

(fn on_attach [_client buffer]
  (local {:lang-map lang} (require :Mapping.Lang))
  (lang {:name " Html" 
         : buffer
         :with-default-heads true
         :heads [[:! "<Plug>(emmet-expand-abbr)" {:desc "Expand Abbreviation"}]]}))

(lspconfig.html.setup {:cmd [:vscode-html-language-server :--stdio] : on_attach : capabilities})
(vim.cmd ":LspStart html")
