(local cmd (. (require :hydra.keymap-util) :cmd))
(local hydra (require :Mapping.Lang))
(hydra {:extra-heads [[:m
                       (cmd :MarkdownPreview)
                       {:desc "Preview Markdown" :exit true}]
                      [:z (cmd :Goyo) {:desc "Zen Mode" :exit true}]]})
(vim.api.nvim_set_keymap :n :j :gj {:noremap true :silent true})
(vim.api.nvim_set_keymap :n :k :gk {:noremap true :silent true})
(vim.cmd "set wrap linebreak")
(set vim.opt.list false)
(set vim.g.indentLine_enabled 0)
(set vim.g.goyo_width 100)
(vim.cmd :Goyo)
