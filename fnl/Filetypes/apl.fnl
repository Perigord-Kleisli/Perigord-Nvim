(local cmd (. (require :hydra.keymap-util) :cmd))
(vim.cmd :StartDyalog)
(vim.api.nvim_set_keymap :n :<CR> (cmd :EvalDyalog) {:desc "Explain expression"})

