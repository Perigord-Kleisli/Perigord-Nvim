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
          :rainbow {:enable true}}))
