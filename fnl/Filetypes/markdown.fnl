(local cmd (. (require :hydra.keymap-util) :cmd))
(local {:lang-map wk} (require :Mapping.Lang))
(wk {:name "  Markdown"
     :pattern :*.md
     :heads [[:m (cmd :MarkdownPreview) {:desc "Preview Markdown"}]]})

(let [lspconfig (require :lspconfig)]
  (lspconfig.marksman.setup {:capabilities (. (require :Lang.LSP) :capabilities)}))

(vim.api.nvim_set_keymap :n :j :gj {:noremap true :silent true})
(vim.api.nvim_set_keymap :n :k :gk {:noremap true :silent true})
(vim.cmd "set wrap linebreak")
(set vim.opt.list false)
(set vim.g.indentLine_enabled 0)
(vim.cmd "LspStart marksman")
