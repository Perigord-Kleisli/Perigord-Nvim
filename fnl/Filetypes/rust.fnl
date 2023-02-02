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
  (local {:lang-map wk} (require :Mapping.Lang))
  (wk {:name :Rust
       : buffer
       :config {:exit true}
       :heads [[:h
                toggle-inlay-hints
                {:desc "Toggle inlay hints"}
                [:P
                 rt.open_cargo_toml.open_cargo_toml
                 {:desc "Open Cargo File"}]
                [:m
                 rt.expand_macro.expand_macro
                 {:desc "View Macro Expansion"}]
                [:<C-r> rt.runnables.runnables {:desc :Runnables}]]]})
  (vim.keymap.set :n :K rt.hover_actions.hover_actions
                  {:noremap true :silent true :desc :hover}))

(rt.setup {:server {: capabilities
                    :tools {:autoSetHint true
                            :runnables {:use_telescope true}
                            :inlay_hints {:show_parameter_hints true}
                            :hover_actions {:auto_focus true}}
                    :settings {:rust-analyzer {:checkOnSave {:command :clippy}}}
                    : on_attach}})

(vim.cmd ":LspStart rust_analyzer")
