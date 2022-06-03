(module Util.Telescope 
  {autoload {Func Functions}
   autoload {telescope telescope}
   autoload {themes telescope.themes}
   autoload {actions telescope.actions}})

(telescope.setup 
  { :defaults 
    { :winblend 1 
      :file_ignore_patterns [ "__pycache__" "node_modules" ".jpg" ".jpeg" ".png" ".ico" "dist" "dist-newstyle"]
      :prompt_prefix " " 
      :selection_caret "  "
      :mappings 
        {:i 
          {:<C-j> actions.move_selection_next
           :<C-k> actions.move_selection_previous
           :<C-n> actions.cycle_history_next
           :<C-p> actions.cycle_history_prev}}}})
                
(each [_ i (ipairs [:media_files :file_browser :projects :dap])]
    (Func.alternative telescope.load_extension 
                      (fn [...] (print "Failed to load Telescope Extension:" ...))
                      i))
