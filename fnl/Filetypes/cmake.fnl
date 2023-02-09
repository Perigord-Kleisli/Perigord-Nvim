(let [lspconfig (require :lspconfig)
      {: capabilities} (require :Lang.LSP)]
  (lspconfig.cmake.setup {: capabilities}))
(vim.cmd.LspStart :cmake)
