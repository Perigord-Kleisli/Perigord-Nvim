(local rt (require :rust-tools))
(local {: capabilities} (require :Lang.LSP))
(local iron (require :iron.core))
(local hydra (require :Mapping.Lang))

(fn on_attach []
  (fn [_client bufnr]
    (local _opts (vim.tbl_extend :keep {:noremap true :silent true}
                                 {:buffer bufnr}))
    (vim.api.nvim_create_autocmd [:CursorHold
                                  :InsertLeave
                                  :BufWritePost
                                  :TextChanged]
                                 {:group (vim.api.nvim_create_augroup :rust-tools-code-lens
                                                                      {})
                                  :callback (fn []
                                              (vim.schedule vim.lsp.codelens.refresh))
                                  :buffer bufnr})
    (hydra {:name :Browse/Open
            :mode :n
            :config {:invoke_on_body true :foreign_keys :run :type :statusline}
            :body :<leader>o
            :heads [[:p (cmd :NvimTreeToggle) {:desc :Sidebar :exit true}]
                    [:t (cmd :ToggleTerm) {:desc :Terminal :exit true}]
                    [:r (cmd-tele :oldfiles) {:desc "Recent Files" :exit true}]
                    [:h (cmd :BufferLineCyclePrev) {:desc "Previous Buffer"}]
                    [:l (cmd :BufferLineCycleNext) {:desc "Next Buffer"}]
                    [:<esc> nil {:desc :Exit :exit true}]]})
    (hydra {:extra-heads [[:e
                           vim.lsp.codelens.run
                           {:desc "Evaluate Codelens" :exit true}]]})))

(rt.setup {:server {: capabilities
                    :tools {:autoSetHint true
                            :runnables {:use_telescope true}
                            :inlay_hints {:show_parameter_hints true}
                            :hover_actions {:auto_focus true}}
                    :settings {:rust-analyzer {:checkOnSave {:command :clippy}}}
                    : on_attach}})

(vim.cmd ":LspStart rust_analyzer")
