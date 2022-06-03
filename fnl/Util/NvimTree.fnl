(module Util.NvimTree 
  {autoload {nvim-tree nvim-tree}})

(nvim-tree.setup
  {:update_focused_file 
    {:enable true}
   :diagnostics
    {:enable true
     :show_on_dirs true}
   :renderer
    {:add_trailing true
     :group_empty true
     :highlight_opened_files "all"}})
