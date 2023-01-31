(let [{: capabilities} (require :Lang.LSP)
      lspconfig (require :lspconfig)]
  (tset (require :lspconfig.configs) :fennel_language_server
        {:default_config {:cmd [:fennel-language-server]
                          :filetypes [:fennel]
                          :single_file_support true
                          :root_dir (lspconfig.util.root_pattern :fnl)
                          :settings {:fennel {:workspace {:library (vim.api.nvim_get_runtime_file "" true)}
                                              :diagnostics {:globals [:vim]}}}}})
  (lspconfig.fennel_language_server.setup {: capabilities}))

(vim.cmd "LspStart fennel_language_server")
