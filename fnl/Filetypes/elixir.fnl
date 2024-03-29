(local elixir (require :elixir))

(fn on_attach [_client _bufnr]
  (vim.keymap.set :n :<space>fp ":ElixirFromPipe<cr>"
                  {:buffer true :noremap true})
  (vim.keymap.set :n :<space>tp ":ElixirToPipe<cr>"
                  {:buffer true :noremap true})
  (vim.keymap.set :v :<space>em ":ElixirExpandMacro<cr>"
                  {:buffer true :noremap true}))

(elixir.setup 
  {:elixirls {:enable true : on_attach :cmd [:elixir-ls]}})
