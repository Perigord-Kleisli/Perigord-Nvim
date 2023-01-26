(local bufferline (require :bufferline))

(bufferline.setup 
  {:options 
    {:hover {:enabled true}
     ;; :indicator {:style :underline}
     :diagnostics :nvim_lsp
     :offsets [{:filetype :NvimTree}]}})
