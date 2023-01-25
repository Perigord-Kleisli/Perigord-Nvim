(local rt (require :rust-tools))
(local capabilities (. (require :Lang.LSP) :capabilities))
(local hydra (require :Mapping.Lang))

;; fnlfmt: skip
(rt.setup
  {:server
    {: capabilities
     :tools {:autoSetHint true
             :runnables {:use_telescope true}
             :inlay_hints {:show_parameter_hints true}
             :hover_actions {:auto_focus true}}
     :settings {:rust-analyzer {:checkOnSave {:command :clippy}}}
     :on_attach
      (fn [_client bufnr]
        (local _opts (vim.tbl_extend :keep {:noremap true :silent true} {:buffer bufnr}))

        (vim.api.nvim_create_autocmd [:CursorHold
                                      :InsertLeave
                                      :BufWritePost
                                      :TextChanged]
                             {:group (vim.api.nvim_create_augroup :rust-tools-code-lens
                                                                  {})
                              :callback (fn [] (vim.schedule vim.lsp.codelens.refresh))
                              :buffer bufnr})


        (hydra {:extra-heads [[:e vim.lsp.codelens.run {:desc "Evaluate Codelens" :exit true}]]})
        nil)}})

(vim.cmd ":LspStart rust_analyzer")
