(local lean (require :lean))

(fn on_attach [client bufnr]
  nil)

(lean.setup {:abbreviations {:builtin true} :lsp {: on_attach} :mappings false})
(vim.cmd.LspStart :leanls)
