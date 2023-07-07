(local lean (require :lean))

(fn on_attach [_ _]
  (local {:lang-map wk} (require :Mapping.Lang))
  (local {: cmd} (require :hydra.keymap-util))
  (local lsp-lines (require :lsp_lines))
  (wk {:name :Lean
       :with-default-heads false
       :pattern :*.lean
       :heads [[:i (cmd :LeanInfoviewToggle) {:desc "toggle infoview"}]
               [:r vim.lsp.buf.rename {:desc :Rename}]
               [:t (cmd :TroubleToggle) {:desc "Toggle Diagnostic List"}]
               [:I (cmd :LspInfo) {:desc "LSP Info"}]
               [:a vim.lsp.buf.code_action {:desc "Code Action"}]
               [:e vim.lsp.codelens.run {:desc "Code lens"}]
               [:l lsp-lines.toggle {:desc "Toggle line diagnostics"}]
               [:p (cmd :LeanInfoviewPinTogglePause) {:desc "pause infoview"}]
               [:s (cmd :Navbuddy) {:desc "Toggle Navbuddy"}]
               [:x (cmd :LeanInfoviewAddPin) {:desc "pin to infoview"}]
               [:s (cmd :LeanSorryFill) {:desc "insert `sorry`"}]
               [:t (cmd :LeanTryThis) {:desc "Activate suggestion"}]
               [:<Tab> (cmd :LeanGotoInfoview) {:desc "jump to infoview"}]
               ["|"
                (cmd :LeanAbbreviationsReverseLookup)
                {:desc "Show symbol abbreviation"}]]}))

(lean.setup {:abbreviations {:builtin true} :lsp {: on_attach} :mappings false})
(vim.cmd.LspStart :leanls)
