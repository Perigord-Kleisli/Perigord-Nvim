(local default-maps
       (let [dap (require :dap)
             telescope (require :telescope)
             conditional-breakpoint #(vim.ui.input {:prompt "Condition: "}
                                                   #(match $1
                                                      x (dap.set_breakpoint x)))
             logpoint #(vim.ui.input {:prompt "Message: "}
                                     #(match $1
                                        x (dap.set_breakpoint nil nil x)))]
         [[:J dap.step_over {:desc "Step Over"}]
          [:K dap.step_back {:desc "Step Back"}]
          [:H dap.step_out {:desc "Step Out"}]
          [:L dap.step_into {:desc "Step Into"}]
          [:n dap.continue {:desc :Continue}]
          [:<CR> dap.continue {:desc "Start Debugging"}]
          [:<S-Esc> #(dap.terminate) {:desc "Terminate Debug" :exit true}]
          [:<Esc> nil {:exit true}]
          [:q nil {:exit true}]
          [:B conditional-breakpoint {:desc "Create conditional breakpoint"}]
          [:<A-b> logpoint {:desc "Create Logpoint"}]
          [:<leader>v telescope.extensions.dap.variables {:desc :Variables}]
          [:<leader>b
           telescope.extensions.dap.list_breakpoints
           {:desc :Breakpoints}]
          [:<leader>f telescope.extensions.dap.frames {:desc :Frames}]
          [:<C-p> telescope.extensions.dap.commands {:desc :Commands}]
          [:b dap.toggle_breakpoint {:desc "Toggle Breakpoint"}]]))

(fn with-default-maps [maps opts]
  (each [_ v (ipairs default-maps)]
    (when (not (vim.tbl_contains (or (?. opts :without) []) (. v 1)))
      (table.insert maps v)))
  maps)

(fn debug-map [hydra-opts]
  (var hydra-opts hydra-opts)
  (let [dap (require :dap)
        dapui (require :dapui)
        hydra (require :hydra)
        {:register wk} (require :which-key)
        hint (table.concat ["Debug: \n"
                            ""
                            "_<C-p>_: Commands\n"
                            "\n"
                            " _K_: Step Back    _H_: Step Out\n"
                            " _J_: Step Over    _L_: Step Into\n"
                            "\n"
                            " _b_:     Toggle Breakpoint\n"
                            " _B_:     Create Conditional Breakpoint\n"
                            " _<A-b>_: Create Logpoint\n"
                            "\n"
                            " _<leader>v_: Variables\n"
                            " _<leader>b_: Breakpoints\n"
                            " _<leader>f_: Frames\n"
                            "\n"
                            (if (vim.tbl_contains (or (?. hydra-opts :remove)
                                                      [])
                                                  :n)
                                "" " _n_:     Continue\n")
                            " _<CR>_: Start Debugging\n"
                            "\n"
                            " [_<Esc>_ | _q_]:   Close UI\n"
                            " _<S-Esc>_: Terminate Session\n"
                            "\n"])]
    (match (?. hydra-opts :with-default-heads)
      true (tset hydra-opts :heads (with-default-maps hydra-opts.heads {:without (?. hydra-opts :remove)})))
    (set hydra-opts
         (vim.tbl_deep_extend :keep hydra-opts
                              {:name :Lang
                               : hint
                               :config {:color :pink
                                        :hint {:type :window
                                               :border :single
                                               :position :middle-right}
                                        :invoke_on_body true
                                        :hint {:type :window
                                               :border :single
                                               :position :middle-right}
                                        :on_enter #(dapui.open)
                                        :on_exit #(dapui.close)}}))
    (local binds #(wk {:d [#(: (hydra hydra-opts) :activate)
                           (.. "+" hydra-opts.name)]}
                      {:prefix :<leader>}))
    (set dap.listeners.after.event_initialized.dapui_config
         #(: (hydra hydra-opts) :activate))
    (match hydra-opts.pattern
      pattern (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                           {: pattern :callback binds}))
    (match hydra-opts.buffer
      buffer (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                          {: buffer :callback binds}))
    (binds)))

;; (debug-map {:name :Debug :heads default-maps})

{: debug-map}
