(local rt (require :rust-tools))
(local {: capabilities} (require :Lang.LSP))

(var inlay-hints-open true)

(fn toggle-inlay-hints []
  (if inlay-hints-open
      (do
        (rt.inlay_hints.disable)
        (set inlay-hints-open false))
      (do
        (rt.inlay_hints.enable)
        (set inlay-hints-open true))))

(fn on_attach [_client buffer]
  (local _opts (vim.tbl_extend :keep {:noremap true :silent true} {: buffer}))
  (vim.api.nvim_create_autocmd [:CursorHold
                                :InsertLeave
                                :BufWritePost
                                :TextChanged]
                               {:group (vim.api.nvim_create_augroup :rust-tools-code-lens
                                                                    {})
                                :callback #(vim.schedule vim.lsp.codelens.refresh)
                                : buffer})
  (vim.schedule vim.lsp.codelens.refresh)
  (local {:lang-map lang} (require :Mapping.Lang))
  (lang {:name " Rust"
         : buffer
         :config {:exit true}
         :heads [[:h toggle-inlay-hints {:desc "Toggle inlay hints"}]
                 [:P
                  rt.open_cargo_toml.open_cargo_toml
                  {:desc "Open Cargo File"}]
                 [:a
                  #(rt.code_action_group.code_action_group)
                  {:desc "Rust Code Action"}]
                 [:m
                  rt.expand_macro.expand_macro
                  {:desc "View Macro Expansion"}]]})
  (local {:debug-map dbg-map} (require :Mapping.Debug))
  (local dapui (require :dapui))
  (dbg-map {:name " Debug"
            : buffer
            :remove [:n]
            :config {:on_enter #(do
                                  (dapui.open)
                                  (vim.cmd :mkview)
                                  (vim.cmd "silent! %foldopen!")
                                  (set vim.bo.modifiable false)
                                  (vim.defer_fn #(rt.inlay_hints.disable) 100))
                     :on_exit #(do
                                 (dapui.close)
                                 (rt.inlay_hints.enable))}
            :heads [[:<CR>
                     rt.debuggables.debuggables
                     {:desc "Start Debugging"}]]})
  (vim.keymap.set :n :<A-k> #(rt.move_item.move_item true)
                  {:noremap true :silent true :desc "Move Up" : buffer})
  (vim.keymap.set :n :<A-j> #(rt.move_item.move_item false)
                  {:noremap true :silent true :desc "Move Down" : buffer})
  (vim.keymap.set :n :K rt.hover_actions.hover_actions
                  {:noremap true :silent true :desc :hover : buffer}))

(rt.setup {:server {: capabilities
                    :tools {:autoSetHint true
                            :runnables {:use_telescope true}
                            :inlay_hints {:show_parameter_hints true}
                            :hover_actions {:auto_focus true}}
                    :settings {:rust-analyzer {:checkOnSave {:command :clippy}}}
                    : on_attach}
           :dap {:adapter {:type :executable
                           :command :lldb-vscode
                           :name :rt_lldb}}})

(vim.cmd ":LspStart rust_analyzer")
