(local indent-scope (require :mini.indentscope))

(indent-scope.setup)

(set vim.opt.list true)
(vim.opt.listchars:append "space:⋅")
(vim.opt.listchars:append "eol:↴")
(set vim.g.indentLine_char_list [ "┆" "┊" "|" "¦" "¦" "¦"])

(set vim.g.indentLine_enabled 1)
