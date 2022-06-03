(module UI.Indent-Blankline 
  {autoload {indent-blankline indent_blankline}})

(set vim.opt.termguicolors true)
(set vim.opt.list true)
(vim.opt.listchars:append "space:⋅")
(vim.opt.listchars:append "eol:↴")
(set vim.g.indentLine_char_list [ "⋅" "┆" "┊" "|" "¦" "¦" "¦"])

(set vim.g.indentLine_enabled 1)

(indent-blankline.setup 
  {:show_end_of_line true
   :show_current_context true
   :show_current_context_start true})
