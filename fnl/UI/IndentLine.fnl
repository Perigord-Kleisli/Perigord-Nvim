(set vim.opt.list true)
(vim.opt.listchars:append "eol:↴")
(set vim.g.indentLine_enabled 1)

(let [{: setup} (require :indent_blankline)]
  (setup {:show_end_of_line true
          :show_current_context true
          :show_current_context_start true}))

(vim.api.nvim_set_hl 0 :IndentBlanklineChar {:fg :#0D0E19})
