(local null-ls (require :null-ls))
(local assoc (. (require :Utils) :assoc)) 

(let [formatting null-ls.builtins.formatting
      diagnostics null-ls.builtins.diagnostics
      code_actions null-ls.builtins.code_actions]
  (null-ls.setup {:debug false
                  :sources [formatting.stylua
                            formatting.alejandra
                            formatting.beautysh
                            formatting.black
                            formatting.brittany
                            formatting.cabal_fmt
                            formatting.clang_format
                            formatting.cmake_format
                            formatting.fnlfmt
                            formatting.prettier
                            formatting.trim_newlines
                            formatting.trim_whitespace
                            formatting.jq 
                            code_actions.statix
                            diagnostics.deadnix
                            diagnostics.flake8
                            diagnostics.mypy
                            diagnostics.cppcheck
                            diagnostics.pylint
                            diagnostics.shellcheck
                            code_actions.shellcheck
                            (assoc diagnostics.cspell :filetypes [:markdown])
                            code_actions.cspell
                            null-ls.builtins.hover.dictionary
                            null-ls.builtins.hover.printenv
                            code_actions.gitsigns]}))
