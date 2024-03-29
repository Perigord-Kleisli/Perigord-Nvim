(set vim.g.termguicolors true)

(local catpuccin (require :catppuccin))
(catpuccin.setup {:flavor :mocha
                  :transparent_background true
                  :integrations {:cmp true
                                 :gitsigns true
                                 :telescope true
                                 :which_key true
                                 :ts_rainbow true
                                 :notify true
                                 :nvimtree true
                                 :lsp_trouble true}
                  :custom_highlights #{:LspCodeLens {:fg "#6272A4"}
                                       :LspCodeLensSeparator {:fg "#7F8CB5"}
                                       :IndentBlanklineChar {:fg "#0D0E19"}
                                       :DashboardHeader {:fg "#8AFF80"}
                                       :DashboardKey {:fg "#FF9580"}
                                       :DashboardDesc {:fg "#87FEF8"}
                                       :DashboardIcon {:fg "#FCFC7F"
                                                       :bold true}
                                       :DashboardFooter {:fg "#5D5D65"}
                                       :UfoFoldedBg {:link :Visual}
                                       :CursorColumn {:fg "#111111"}}})

(vim.cmd.colorscheme :catppuccin)
