(local Utils (require :Utils))
(local neotest (require :neotest))
(import-macros {: run} :Macros)
(local heads
       [[:j vim.diagnostic.goto_next {:desc "Next Diagnostic"}]
        [:k vim.diagnostic.goto_prev {:desc "Previous Diagnostic"}]
        [:l vim.diagnostic.open_float {:desc "Expand Diagnostic"}]
        [:r neotest.run.run {:desc "Run test" :exit true}]
        [:R (run (neotest.run.run (vim.fn.expand "%"))) {:desc "Run file" :exit true}]
        [:o neotest.output.open {:desc "View output" :exit true}]
        [:s neotest.summary.toggle {:desc "View summary" :exit true}]])

(local debug-hydra (Utils.hydra-with-defaults {:mode :n
                                               :body :<leader>d
                                               : heads}))

(debug-hydra)
debug-hydra
