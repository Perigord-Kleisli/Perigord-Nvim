(local hydra (require :Mapping.Lang))
(local cmd (. (require :hydra.keymap-util) :cmd))

(var const-eval? true)
(fn constant_eval []
  (when (and (= vim.bo.filetype :bqn) const-eval?)
    (let [bqn (require :bqn)]
      (bqn.evalBQN 0 (. (vim.api.nvim_win_get_cursor 0) 1)))))

(fn toggle-const-eval []
  (let [bqn (require :bqn)]
    (if (and (= vim.bo.filetype :bqn) const-eval?)
        (bqn.clearBQN 0 (. (vim.api.nvim_win_get_cursor 0) 1))
        (bqn.evalBQN 0 (. (vim.api.nvim_win_get_cursor 0) 1))))
  (set const-eval? (not const-eval?)))


(vim.api.nvim_create_autocmd [:TextChanged :TextChangedI] {:callback constant_eval})

(fn clear-bqn []
  (let [bqn (require :bqn)
        [line] (vim.api.nvim_win_get_cursor 0)]
    (bqn.clearBQN (math.max 0 (- line 1)) line)))

(vim.api.nvim_set_keymap :n :K (cmd :BQNExplain) {:desc "Explain expression"})
(vim.keymap.set :n "<C-CR>" clear-bqn {:desc "Close result"})

(hydra {:extra-heads [[:E
                       toggle-const-eval
                       {:desc "Toggle constant evaluation" :exit true}]
                      [:c
                       (cmd :BQNClearAfterLine)
                       {:desc "Clear all results past cursor" :exit true}]
                      [:C
                       (cmd :BQNClearFile)
                       {:desc "Clear all results in file" :exit true}]]})

(vim.diagnostic.hide)
