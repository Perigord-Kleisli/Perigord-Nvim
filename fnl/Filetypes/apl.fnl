(local cmd (. (require :hydra.keymap-util) :cmd))
(vim.cmd :StartDyalog)
(vim.api.nvim_set_keymap :n :<CR> (cmd :EvalDyalog)
                         {:desc "Explain expression"})

(let [{:lang-map wk} (require :Mapping.Lang)]
  (wk {:name :APL
       :with-default-heads true
       :pattern :*.apl
       :heads [[:<CR>
                (cmd "!dyalog -script DYALOG_LINEEDITOR_MODE=1 %")
                {:desc :Run}]]}))
