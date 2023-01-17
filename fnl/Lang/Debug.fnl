(local neotest (require :neotest))
(neotest.setup {:adapters [(require :neotest-haskell)
                           (require :neotest-rust)
                           (require :neotest-python)]})
