(set vim.g.termguicolors true)
(local dracula (require :dracula))
(dracula.setup {:colors {:bg "#09090a"
                         :menu "#080a0c"
                         :visual "#272568"
                         :selection "#232057"}
                :italic_comment true
                :transparent_bg true
                :overrides {
                            :LspCodeLens {:fg :#6272A4}
                            :LspCodeLensSeparator {:fg :#7F8CB5}
                            :TSRainbowRed {:fg "#cc241d"}
                            :TSRainbowOrange {:fg "#d65d0e"}
                            :TSRainbowYellow {:fg "#d79921"}
                            :TSRainbowGreen {:fg "#689d6a"}
                            :TSRainbowCyan {:fg "#a89984"}
                            :TSRainbowBlue {:fg "#458588"}
                            :TSRainbowViolet {:fg "#b16286"}}})
(vim.api.nvim_command "colorscheme dracula")


(vim.api.nvim_create_autocmd [:InsertEnter]
                             {:pattern "*" :command "set norelativenumber"})

(vim.api.nvim_create_autocmd [:InsertLeave]
                             {:pattern "*" :command "set relativenumber"})

(vim.api.nvim_create_autocmd [:TextYankPost]
                             {:pattern "*"
                              :callback (fn []
                                          (vim.highlight.on_yank {:higroup :visual
                                                                  :timeout 180}))})

