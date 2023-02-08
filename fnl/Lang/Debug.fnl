(local dap (require :dap))
(local dapui (require :dapui))
(dapui.setup)

(vim.fn.sign_define :DapBreakpoint {:text "⬣" :texthl :ErrorMsg})
(vim.fn.sign_define :DapBreakpointCondition {:text "" :texthl :ErrorMsg})
(vim.fn.sign_define :DapLogPoint {:text "" :texthl :String})

(tset dap.listeners.after.event_initialized :dapui_config dapui.open)

(tset dap.listeners.before.event_terminated :dapui_config dapui.close)

(tset dap.listeners.before.event_exited :dapui_config dapui.close)

(set dap.adapters.lldb {:type :executable
                        :attach {:pidProperty :pid :pidSelect :ask}
                        :command :lldb-vscode
                        :env {:LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY :YES}
                        :name :lldb})
