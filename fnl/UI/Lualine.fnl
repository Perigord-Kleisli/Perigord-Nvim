(module UI.Lualine 
  {autoload {lualine lualine}
   autoload {nvim-gps nvim-gps}
   autoload {lsp-signature lsp_signature}})

(def lsp-func 
  [(fn [] 
     (let [msg "No LSP"] buf-ft (vim.api.nvim_buf_get_options -1 :filetype) clients (vim.lsp.get_active_clients) (when (= (next clients) nil) msg)
       (each [ft non_language_ft]
         (when (ft:match buf-ft) ""))
       (each [_ client (ipairs clients)]
         (local filetypes client.config.filetypes)
         (when (and fileypes 
                    (not= (vim.fn.index filetypes buf_ft) (- 0)))
           "")
         msg)))])

(nvim-gps.setup)

(lualine.setup 
  {:options
    {:disable_fileypes [:NvimTree]} 
   :sections 
    {:lualine_b [:filetype 
                 lsp-func 
                 {1 :diagnostics 
                  :sources ["nvim_diagnostic"]
                  :sections ["error" "warn" "info"]}
                 :filename]

      :lualine_c [:diff]
                  
     :lualine_x [{1 nvim-gps.get_location :cond nvim-gps.is_available}]
     :lualine_y ["os.date('%I:%M %p')"]
     :lualine_z [[:] ["location"] "progress"]}}) 
