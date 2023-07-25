(let [{: capabilities} (require :Lang.LSP)
      lspconfig (require :lspconfig)]
  (lspconfig.fennel_ls.setup {: capabilities}))

(vim.cmd "LspStart fennel_ls")
