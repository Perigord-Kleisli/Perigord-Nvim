(local null-ls (require :null-ls))
(import-macros {: run} :Macros)
(fn colortils-actions [_]
  ;; (local word ((vim.fn.expand :<cWORD>):match ".*#%x%x+"))
  (local word (-> :<cWORD>
                  vim.fn.expand
                  (string.find ".*#%x%x%x")))
  (if (not= word nil)
      [{:title "Color Picker"
        :action (run (vim.cmd "Colortils picker"))}
       {:title "Darken Color"
        :action (run (vim.cmd "Colortils darken"))}
       {:title "Lighten Color"
        :action (run (vim.cmd "Colortils darken"))}
       {:title "Desaturate Color"
        :action (run (vim.cmd "Colortils greyscale"))}]))

(local colortils {:name :colortils
                  :meta {:url "https://github.com/nvim-colortils/colortils.nvim"
                         :description "Invoke colortils on valid color tags"
                         :usage "local sources = [ null_ls.builtins.diagnostics.colortils ]"}
                  :generator {:fn colortils-actions}
                  :filetypes []
                  :method null-ls.methods.CODE_ACTION})

(null-ls.register [colortils])
