(local elixir (require :elixir))
(local lspconfig (require :lspconfig))

(fn on_attach [_client _bufnr]
  (vim.keymap.set :n :<space>fp ":ElixirFromPipe<cr>"
                  {:buffer true :noremap true})
  (vim.keymap.set :n :<space>tp ":ElixirToPipe<cr>"
                  {:buffer true :noremap true})
  (vim.keymap.set :v :<space>em ":ElixirExpandMacro<cr>"
                  {:buffer true :noremap true}))

(elixir.setup)

(local {: capabilities} (require :Lang.LSP))
(lspconfig.elixirls.setup {: capabilities
                           :cmd [:elixir-ls]
                           : on_attach
                           :settings {:elixirLS {:fetchDeps false}}})
