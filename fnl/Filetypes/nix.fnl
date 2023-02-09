(let [lspconfig (require :lspconfig)
      {: capabilities} (require :Lang.LSP)]
  (lspconfig.nil_ls.setup {: capabilities}))
(vim.cmd.LspStart :nil_ls)
