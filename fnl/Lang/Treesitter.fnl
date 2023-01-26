(local treesitter (require :nvim-treesitter.configs))

;(local autopairs (require :nvim-autopairs))
;(local treesitter-config (require :nvim-treesitter.configs))
;(autopairs.setup {:fast_wrap {:map :<M-e>}
;                  :check_ts true
;                  :disable_filetype [:fennel]})
; (treesitter-config.setup {:autotag {:enable true}})

(treesitter.setup {:ensure_installed [:fennel
                                      :haskell
                                      :nix
                                      :lua
                                      :rust
                                      :python
                                      :markdown
                                      :markdown_inline
                                      :html]
                   :highlight {:enable true :disable [:markdown]}
                   :rainbow {:enable true}})


