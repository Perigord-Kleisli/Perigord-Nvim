(let [{: nvim_create_autocmd : nvim_create_augroup} vim.api
      au-group (nvim_create_augroup :hotpot-ft {})
      cb #(pcall require (.. :Filetypes. (vim.fn.expand :<amatch>)))]
  (nvim_create_autocmd :FileType {:callback cb :group au-group}))

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern :Cargo.toml
                              :callback #(require :Filetypes.cargo)})

(fn ft-cmds []
  (match vim.bo.filetype
    :notify (do
              (vim.defer_fn #(do
                               (set vim.o.number false)
                               (set vim.o.relativenumber false))
                            15)
              (vim.keymap.set :n :q ":q<cr>" {:silent true :buffer true})
              (vim.keymap.set :n :<esc> ":q<cr>" {:silent true :buffer true}))))

(vim.api.nvim_create_autocmd [:BufWinEnter]
                             {:pattern "*" :callback #(vim.schedule ft-cmds)})
