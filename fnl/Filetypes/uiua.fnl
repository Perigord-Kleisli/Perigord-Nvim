(let [lspconfig (require :lspconfig)
      {: capabilities} (require :Lang.LSP)]
  (lspconfig.uiua.setup {: capabilities}))

(vim.cmd.LspStart :uiua)

(vim.cmd "set autoread")

(vim.api.nvim_create_autocmd [:InsertEnter :InsertLeave :FileWritePost]
                             {:pattern [:*.ua] :command ":checktime"})
