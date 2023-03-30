(local idris2 (require :idris2))

(fn on_attach [client bufnr]
  (local {: Terminal} (require :toggleterm.terminal))
  (local repl (Terminal:new {:cmd "idris2 --repl"}))
  (local {:lang-map wk} (require :Mapping.Lang))
  (wk {:name :Idris2
       :with-default-heads true
       :pattern :*.idr
       :heads [[:R #(repl:toggle) {:desc "Toggle REPL"}]
               [:<CR> #(repl:send ":r") {:desc "Reload REPL"}]]}))

(idris2.setup {:server {: on_attach}})
(vim.cmd.LspStart :idris2_lsp)
