(local idris2 (require :idris2))
(local {: Terminal} (require :toggleterm.terminal))
(var loaded-files {})
(local repl (Terminal:new {:cmd "rlwrap idris2 --repl"}))

(fn on_attach [client bufnr]
  (local {:lang-map wk} (require :Mapping.Lang))
  (wk {:name :Idris2
       :with-default-heads true
       :pattern :*.idr
       :heads [[:R #(repl:toggle) {:desc "Toggle REPL"}]
               ;TODO: not adding to `loaded-files` when `:l <file>` fails
               [:<CR>
                #(when (repl:is_open)
                   (local file (vim.api.nvim_buf_get_name 0))
                   (when (= nil (?. loaded-files file))
                     (tset loaded-files file true)
                     (repl:send (.. ":l " "\"" file "\"")))
                   (repl:send ":r" true))
                {:desc "Reload REPL"}]]}))

(idris2.setup {:server {: on_attach}})
(vim.cmd.LspStart :idris2_lsp)
