(local range-highlight (require :range-highlight))

(range-highlight.setup)

(local colorizer (require :colorizer))
(colorizer.setup {:user_default_options {:mode :virtualtext}})

((. (require :colortils) :setup) {:mappings {:replace_default_format :<cr>}})

(vim.api.nvim_set_hl 0 :LspCodeLens {:fg :#6272A4})
(vim.api.nvim_set_hl 0 :LspCodeLensSeparator {:fg :#7F8CB5})
(vim.api.nvim_set_hl 0 :TSRainbowRed {:fg "#cc241d"})
(vim.api.nvim_set_hl 0 :TSRainbowOrange {:fg "#d65d0e"})
(vim.api.nvim_set_hl 0 :TSRainbowYellow {:fg "#d79921"})
(vim.api.nvim_set_hl 0 :TSRainbowGreen {:fg "#689d6a"})
(vim.api.nvim_set_hl 0 :TSRainbowCyan {:fg "#a89984"})
(vim.api.nvim_set_hl 0 :TSRainbowBlue {:fg "#458588"})
(vim.api.nvim_set_hl 0 :TSRainbowViolet {:fg "#b16286"})
