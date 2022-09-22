(module Lang.Dap
  {autoload {dap dap}
   autoload {dap-python dap-python}
   autoload {dapui dapui}
   autoload {virtual-text nvim-dap-virtual-text}})

(vim.fn.sign_define "DapBreakpoint" {:text "⬣" :texthl "ErrorMsg"})
(vim.fn.sign_define "DapBreakpointCondition" {:text "" :texthl "ErrorMsg"})
(vim.fn.sign_define "DapLogPoint" {:text "" :texthl "String"})
(virtual-text.setup
  {:commented true})
(dapui.setup)

(set dap.adapters.haskell
  {:type :executable
   :command "haskell-debug-adapter"
   :args []})

(set dap.configurations.haskell
  [{:type "haskell"
    :request "launch"
    :name "Debug"
    :internalConsoleOptions "openOnSessionStart"
    :workspace "${workspaceFolder}"
    :startup "${workspaceFolder}/app/Main.hs"
    :startupFunc ""
    :startupArgs ""
    :stopOnEntry true
    :mainArgs ""
    :ghciInitialPrompt "Prelude>"
    :ghciPrompt "λ: "
    ;:ghciCmd "cabal exec -- ghci-dap -fexternal-interpreter --interactive -i -i${workspaceFolder}"
    :ghciCmd "cabal exec -- ghci-dap -fexternal-interpreter --interactive -i -i${workspaceFolder}"
    :ghciEnv (vim.empty_dict)
    :logFile (.. (vim.fn.stdpath :cache) "/haskell-dap.log")
    :logLevel "WARNING"
    :forceInspect false}])

(tset dap.listeners.after.event_initialized :dapui_config 
     (fn [] (dapui.open)))
(tset dap.listeners.after.event_terminated :dapui_config 
     (fn [] (dapui.close)))
(tset dap.listeners.after.event_exited :dapui_config 
     (fn [] (dapui.close)))

(dap-python.setup "/home/truff/.nix-profile/bin/python")

(set dap.adapters.lldb
  {:type :executable
   :attach 
    {:pidProperty "pid"
     :pidSelect "ask"}
   :command "lldb-vscode"
   :env 
    {:LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY "YES"}
   :name "lldb"})

(set dap.configurations.rust
    [{:type :lldb
      :name :Debug
      :request :launch
      :program (fn [] (vim.fn.input "Program: " (.. (vim.fn.getcwd) "/target/debug/") :file))}])

(set dap.configurations.cpp
    [{:type :lldb
      :name :Debug
      :request :launch
      :program (fn [] (vim.fn.input "Program: " (.. (vim.fn.getcwd) "/") :file))}])      

(set dap.configurations.c
    [{:type :lldb
      :name :Debug
      :request :launch
      :program (fn [] (vim.fn.input "Program: " (.. (vim.fn.getcwd) "/") :file))}])

(set dap.configurations.cpp
    [{:type :lldb
      :name :Debug
      :request :launch
      :program (fn [] (vim.fn.input "Program: " (.. (vim.fn.getcwd) "/") :file))}])
