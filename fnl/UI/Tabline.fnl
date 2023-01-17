(local bufferline (require :bufferline))

(set vim.opt.termguicolors true)
(bufferline.setup 
  {:options 
    {:hover {:enabled true}
     ;; :indicator {:style :underline}
     :diagnostics :nvim_lsp
     :offsets [{:filetype :NvimTree}]}})
