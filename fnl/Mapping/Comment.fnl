(local Comment (require :Comment))

(set vim.g.mapleader " ")
(Comment.setup 
  {
   :toggler  {:line "<leader>c<leader>"
              :block "<leader>cbb"}

   :opleader {:line "<leader>c"
              :block "<leader>cb"}

   :extra    {:above "<leader>cO"
              :below "<leader>co"
              :eol "<leader>cA"}})
