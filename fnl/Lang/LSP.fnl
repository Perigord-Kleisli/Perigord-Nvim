(local cmp-lsp (require :cmp_nvim_lsp))

(local capabilities (-> (vim.lsp.protocol.make_client_capabilities)
                        cmp-lsp.default_capabilities))

;; (lspconfig.nil_ls.setup {: capabilities})
;; (lspconfig.ccls.setup {: capabilities})
;; (lspconfig.marksman.setup {: capabilities})
;; (lspconfig.pyright.setup {: capabilities})

(local signs {:DiagnosticSignError ""
              :DiagnosticSignWarn ""
              :DiagnosticSignHint ""
              :DiagnosticSignInfo ""})

(each [diag-type icon (pairs signs)]
  (vim.fn.sign_define diag-type {:text icon :texthl diag-type :numhl diag-type}))

(tset vim.lsp.handlers :textDocument/hover
      (vim.lsp.with vim.lsp.handlers.hover {:border :rounded}))

(tset vim.lsp.handlers :textDocument/signatureHelp
      (vim.lsp.with vim.lsp.handlers.signature_help {:border :rounded}))

(tset vim.lsp.handlers :window/showMessage
      (fn [_ result ctx]
        (let [client (vim.lsp.get_client_by_id ctx.client_id)
              lvl (. [:ERROR :WARN :INFO :DEBUG] result.type)]
          (vim.notify result.message lvl
                  {:title (.. "LSP | " client.name)
                   :timeout 10000
                   :keep (fn []
                           (or (= lvl :ERROR) (= lvl :WARN)))}))))

(vim.diagnostic.config {:virtual_text false})

{: capabilities}

