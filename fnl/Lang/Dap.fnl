(module Lang.Dap
  {autoload {dap dap}
   autoload {dapui dapui}
   autoload {virtual-text nvim-dap-virtual-text}})

(vim.fn.sign_define "DapBreakpoint" {:text "⬣" :texthl "ErrorMsg"})
(vim.fn.sign_define "DapBreakpointCondition" {:text "" :texthl "ErrorMsg"})
(vim.fn.sign_define "DapLogPoint" {:text "" :texthl "String"})

(set dap.adapters.haskell
  {:type :executable
   :command "haskell-debug-adapter"})
(set dap.configurations.haskell
  [{:type "haskell"
    :request "launch"
    :name "Debug"
    :workspace "${workspaceFolder}"
    :startup "${file}"
    :stopOnEntry true
    :logFile (.. (vim.fn.stdpath :data) "/logs/dap-haskell.log")
    :logLevel "WARNING"
    :ghciEnv (vim.empty_dict)
    :ghciPrompt "λ: "
    :ghciInitialPrompt "λ: "
    :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show+"}])


(virtual-text.setup)
(dapui.setup)
