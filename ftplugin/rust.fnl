(local rt (require :rust-tools))
(local capabilities (. (require :Lang.LSP) :capabilities))
(local hydra (require :Mapping.Lang))

;; fnlfmt: skip
(rt.setup
  {:server
    {: capabilities
     :settings {:rust-analyzer {:checkOnSave {:command :clippy}}}
     :on_attach
      (fn [_client bufnr]
        (local _opts (vim.tbl_extend :keep {:noremap true :silent true} {:buffer bufnr}))
        (hydra)
        nil)}})

(vim.cmd ":LspStart rust_analyzer")
