(fn debug-map [maps]
  (let [ft maps.name
        dap (require :dap)
        dapui (require :dapui)
        telescope (require :telescope)
        conditional-breakpoint #(vim.ui.input {:prompt "Condition: "}
                                              #(match $1
                                                 x (dap.set_breakpoint x)))
        logpoint #(vim.ui.input {:prompt "Message: "}
                                #(match $1
                                   x (dap.set_breakpoint nil nil x)))
        hydra (require :hydra)
        {:register wk} (require :which-key)
        defaults [[:J dap.step_over {:desc "Step Over"}]
                  [:K dap.step_back {:desc "Step Back"}]
                  [:H dap.step_out {:desc "Step Out"}]
                  [:L dap.step_into {:desc "Step Into"}]
                  [:n dap.continue {:desc :Continue}]
                  [:<CR> dap.continue {:desc "Start Debugging"}]
                  [:<S-Esc>
                   #(dap.terminate)
                   {:desc "Terminate Debug" :exit true}]
                  [:<Esc> nil {:exit true}]
                  [:q nil {:exit true}]
                  [:B
                   conditional-breakpoint
                   {:desc "Create conditional breakpoint"}]
                  [:<A-b> logpoint {:desc "Create Logpoint"}]
                  [:<leader>v
                   telescope.extensions.dap.variables
                   {:desc :Variables}]
                  [:<leader>b
                   telescope.extensions.dap.list_breakpoints
                   {:desc :Breakpoints}]
                  [:<leader>f telescope.extensions.dap.frames {:desc :Frames}]
                  [:<C-p> telescope.extensions.dap.commands {:desc :Commands}]
                  [:b dap.toggle_breakpoint {:desc "Toggle Breakpoint"}]]]
    (each [_ v (ipairs defaults)]
      (local intersecting? (do
                             (var x false)
                             (each [_ head (ipairs maps.heads)]
                               (when (= (. head 1) (. v 1))
                                 (set x true)
                                 (lua :break)))
                             (match maps.remove
                               removed (when (not x)
                                         (each [_ ignore (ipairs removed)]
                                           (when (= (. v 1) ignore)
                                             (set x true)
                                             (lua :break)))))
                             x))
      (when (not intersecting?)
        (table.insert maps.heads v)))
    (set maps.hint (table.concat ["Debug: \n"
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
                                  (if (vim.tbl_contains (or (?. maps :remove)
                                                            [])
                                                        :n)
                                      "" " _n_:     Continue\n")
                                  " _<CR>_: Start Debugging\n"
                                  "\n"
                                  " [_<Esc>_ | _q_]:   Close UI\n"
                                  " _<S-Esc>_: Terminate Session\n"
                                  "\n"]))
    (set maps.config
         {:invoke_on_body true
          :foreign_keys :run
          :hint {:type :window :border :single :position :middle-right}
          :on_enter (or (?. maps.config :on_enter)
                        #(do
                           (vim.cmd :mkview)
                           (vim.cmd "silent! %foldopen!")
                           (set vim.bo.modifiable false)
                           (dapui.open)))
          :on_exit (or (?. maps.config :on_exit) #(dapui.close))})
    (local binds #(wk {:d [#(: (hydra maps) :activate)
                           (.. "+" (if (= 0 (string.len ft)) :Debug ft))]}
                      {:prefix :<leader>}))
    (set dap.listeners.after.event_initialized.dapui_config
         #(: (hydra maps) :activate))
    (match maps.pattern
      pattern (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                           {: pattern :callback binds}))
    (match maps.buffer
      buffer (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                          {: buffer :callback binds}))
    (binds)))

(debug-map {:name :Debug :heads []})

{: debug-map}
