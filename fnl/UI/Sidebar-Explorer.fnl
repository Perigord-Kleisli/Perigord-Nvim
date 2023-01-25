(local nvim-tree (require :nvim-tree))
(nvim-tree.setup 
  {:update_focused_file
    {:enable true}
   :view 
    {:mappings {:list [ {:key :?  :action :toggle_help}]}}
   :diagnostics 
    {:enable true 
     :show_on_dirs true}})
