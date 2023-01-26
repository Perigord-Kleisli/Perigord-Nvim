(local lspconfig (require :lspconfig))
(local cmp-lsp (require :cmp_nvim_lsp))

(local capabilities (-> (vim.lsp.protocol.make_client_capabilities)
                        cmp-lsp.default_capabilities))

(local neodev (require :neodev))
(neodev.setup {:override (fn [root lib]
                           (local neodev-util (require :neodev-util))
                           (if (neodev-util.has_file root :/etc/nixos)
                               (set lib.enabled true)
                               (set lib.plugins true)))})

(var runtime-path (vim.split package.path ";"))
(table.insert runtime-path :lua/?.lua)
(table.insert runtime-path :lua/?/init.lua)

(lspconfig.sumneko_lua.setup {: capabilities
                              :settings {:Lua {:runtime {:version :LuaJIT
                                                         :path runtime-path}
                                               :diagnostics {:globals [:vim]}
                                               :workspace {:library (vim.api.nvim_get_runtime_file ""
                                                                                                   true)}
                                               :telemetry {:enable false}}}})

(tset (require :lspconfig.configs) :fennel_language_server
      {:default_config {:cmd [:fennel-language-server]
                        :filetypes [:fennel]
                        :single_file_support true
                        :root_dir (lspconfig.util.root_pattern :fnl)
                        :settings {:fennel {:workspace {:library (vim.api.nvim_get_runtime_file "" true)}
                                            :diagnostics {:globals [:vim]}}}}})

(lspconfig.nil_ls.setup {: capabilities})
(lspconfig.ccls.setup {: capabilities})
(lspconfig.marksman.setup {: capabilities})
(lspconfig.pyright.setup {: capabilities})
(lspconfig.fennel_language_server.setup {: capabilities})

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

(require :Mapping.Lang)

{: capabilities}
