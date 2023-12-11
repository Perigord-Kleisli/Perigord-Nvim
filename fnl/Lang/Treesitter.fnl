(let [{: setup} (require :nvim-treesitter.configs)]
  (setup {:ensure_installed [:fennel
                             :haskell
                             :cpp
                             :bash
                             :cmake
                             :nix
                             :lua
                             :rust
                             :python
                             :markdown
                             :markdown_inline
                             :elixir
                             :heex
                             :javascript
                             :typescript
                             :sql
                             :html]
          :highlight {:enable true :disable [:markdown]}
          :autotag {:enable true}
          :rainbow {:enable true :disable [:cpp]}
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

(let [treesitter-parsers (require :nvim-treesitter.parsers)
      parser-config (treesitter-parsers.get_parser_configs)]
  (tset parser-config :pyf {:install_info {:url "https://github.com/Perigord-Kleisli/tree-sitter-pyf.git"
                                           :branch :main
                                           :files [:src/parser.c :src/scanner.c]}
                            :filetype :pyf}))
