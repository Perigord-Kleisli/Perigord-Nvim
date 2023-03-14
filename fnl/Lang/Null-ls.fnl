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
                            formatting.cabal_fmt
                            ; formatting.clang_format
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
                            ; diagnostics.cppcheck
                            diagnostics.pylint
                            diagnostics.shellcheck
                            code_actions.shellcheck
                            (assoc diagnostics.cspell :filetypes [:markdown])
                            code_actions.cspell
                            null-ls.builtins.hover.dictionary
                            null-ls.builtins.hover.printenv]}))

(let [colortils-actions #(let [word (-> :<cword> vim.fn.expand
                                        (string.find "%x%x%x"))]
                           (if (not= word nil)
                               [{:title "Color Picker"
                                 :action #(vim.cmd "Colortils picker")}
                                {:title "Darken Color"
                                 :action #(vim.cmd "Colortils darken")}
                                {:title "Lighten Color"
                                 :action #(vim.cmd "Colortils lighten")}
                                {:title "Desaturate Color"
                                 :action #(vim.cmd "Colortils greyscale")}]))
      colortils {:name :colortils
                 :meta {:url "https://github.com/nvim-colortils/colortils.nvim"
                        :description "Invoke colortils on valid color tags"
                        :usage "local sources = [ null_ls.builtins.diagnostics.colortils ]"}
                 :generator {:fn colortils-actions}
                 :filetypes []
                 :method null-ls.methods.CODE_ACTION}]
  (null-ls.register [colortils]))
