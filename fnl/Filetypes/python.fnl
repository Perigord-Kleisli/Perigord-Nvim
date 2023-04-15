(let [{: capabilities} (require :Lang.LSP)
      {: pylsp} (require :lspconfig)]
  (pylsp.setup {: capabilities 
                :pylsp {:plugins {:flake8 {:enable true}
                                  :pylint {:enable true}
                                  :black {:enable true}}}}))

(vim.cmd.LspStart :pylsp)
