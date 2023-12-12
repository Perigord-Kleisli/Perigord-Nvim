(local dap (require :dap))
(local dapui (require :dapui))
(dapui.setup)

(vim.api.nvim_set_hl 0 :DapBreakpoint {:ctermbg 0 :fg "#993939" :bg "#31353f"})

(vim.api.nvim_set_hl 0 :DapBreakpointLine {:bg "#251215"})

(vim.api.nvim_set_hl 0 :DapLogPoint {:ctermbg 0 :fg "#61afef" :bg  "#31353f"})

(vim.api.nvim_set_hl 0 :DapLogPointLine {:bg "#252849"})

(vim.api.nvim_set_hl 0 :DapStopped {:ctermbg 0 :fg "#98c379" :bg "#31353f"})
(vim.api.nvim_set_hl 0 :DapStoppedLine {:bg "#15171B"})

(vim.fn.sign_define :DapBreakpoint
                    {:text ""
                     :texthl :DapBreakpoint
                     :linehl :DapBreakpointLine
                     :numhl :DapBreakpoint})

(vim.fn.sign_define :DapBreakpointCondition
                    {:text "ﳁ"
                     :texthl :DapBreakpoint
                     :linehl :DapBreakpointLine
                     :numhl :DapBreakpoint})

(vim.fn.sign_define :DapBreakpointRejected
                    {:text ""
                     :texthl :DapBreakpoint
                     :linehl :DapBreakpointLine
                     :numhl :DapBreakpoint})

(vim.fn.sign_define :DapLogPoint
                    {:text ""
                     :texthl :DapLogPoint
                     :linehl :DapLogPointLine
                     :numhl :DapLogPoint})

(vim.fn.sign_define :DapStopped
                    {:text ""
                     :texthl :DapStopped
                     :linehl :DapStoppedLine
                     :numhl :DapStopped})


(tset dap.listeners.after.event_initialized :dapui_config dapui.open)

(tset dap.listeners.before.event_terminated :dapui_config dapui.close)

(tset dap.listeners.before.event_exited :dapui_config dapui.close)

(set dap.adapters.lldb {:type :executable
                        :attach {:pidProperty :pid :pidSelect :ask}
                        :command :lldb-vscode
                        :env {:LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY :YES}
                        :name :lldb})
