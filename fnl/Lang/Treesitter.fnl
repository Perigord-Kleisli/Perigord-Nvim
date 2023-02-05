(let [{: setup} (require :nvim-treesitter.configs)]
  (setup {:ensure_installed [:fennel
                             :haskell
                             :nix
                             :lua
                             :rust
                             :python
                             :markdown
                             :markdown_inline
                             :html]
          :highlight {:enable true :disable [:markdown]}
          :autotag {:enable true}
          :rainbow {:enable true}
          :textobjects {:swap {:enable true
                               :swap_next {:<A-l> "@parameter.inner"}
                               :swap_previous {:<A-h> "@parameter.inner"}}
                        :select {:enable true
                                 :lookahead true
                                 :keymaps {:af {:query "@function.outer"
                                                :desc "Around function"}
                                           :if "@function.inner"
                                           :ac "@class.outer"
                                           :ic "@class.inner"}}}}))
