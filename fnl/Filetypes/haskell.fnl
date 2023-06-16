(local ht (require :haskell-tools))
(local {: capabilities} (require :Lang.LSP))
(local {: cmd} (require :hydra.keymap-util))

(var repl-open false)

(fn on_attach [client bufnr]
  (local {:lang-map wk} (require :Mapping.Lang))
  (wk {:name " Haskell"
       :with-default-heads true
       :pattern :*.hs
       :heads [[:<CR>
                #(do
                   (if repl-open
                       (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes :<C-w>j
                                                                              true
                                                                              false
                                                                              true)
                                              :n false)
                       (ht.repl.toggle))
                   (set repl-open true)
                   (vim.keymap.set :n " l<CR>"
                                   #(do
                                      (vim.cmd :q)
                                      (set repl-open false))
                                   {:desc "Hide REPL" :buffer true}))
                {:desc "Toggle REPL"}]
               [:p (cmd :HsPackageCabal) {:desc "Open Cabal File"}]
               [:P (cmd :HsProjectFile) {:desc "Open Project File"}]
               [:h (cmd "Telescope hoogle") {:desc "Hoogle search"}]]})
  (local dap (require :dap))
  (set dap.adapters.haskell
       {:type :executable
        :command :haskell-debug-adapter
        :args [:--hackage-version=0.0.33.0]})
  (set dap.configurations.haskell
       [{:type :haskell
         :request :launch
         :name :Debug
         :workspace "${workspaceFolder}"
         :startup "${file}"
         :stopOnEntry true
         :logFile (.. (vim.fn.stdpath :data) :/haskell-dap.log)
         :logLevel :WARNING
         :ghciEnv (vim.empty_dict)
         :ghciPrompt "λ: "
         :ghciInitialPrompt "λ: "
         :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"}])
  (ht.dap.discover_configurations bufnr))

(ht.start_or_attach {:hls {: capabilities
                           :settings {:haskell {:formattingProvider :fourmolu
                                                :plugin {:rename {:config {:diff true}}}}}
                           :cmd [:haskell-language-server :--lsp]
                           : on_attach}
                     :tools {:repl {:handler :toggleterm :auto_focus true}
                             :dap {:cmd [:haskell-debug-adapter]}}})
