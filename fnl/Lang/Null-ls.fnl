(module Lang.Null-ls {autoload {null-ls null-ls}})

(let [formatting null-ls.builtins.formatting
      diagnostics null-ls.builtins.diagnostics
      code_actions null-ls.builtins.code_actions
      hover null-ls.builtins.hover]
  (null-ls.setup {:debug false
                  :sources [formatting.stylua
                            formatting.asmfmt
                            formatting.brittany
                            formatting.cabal_fmt
                            formatting.clang_format
                            formatting.cmake_format
                            formatting.fnlfmt
                            formatting.markdownlint
                            formatting.nixfmt
                            diagnostics.cppcheck
                            diagnostics.pylint
                            diagnostics.luacheck
                            diagnostics.shellcheck
                            diagnostics.write_good
                            code_actions.shellcheck
                            hover.dictionary
                            null_ls.builtins.code_actions.gitsigns]}))
