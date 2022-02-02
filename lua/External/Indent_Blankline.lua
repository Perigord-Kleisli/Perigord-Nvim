local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
   vim.notify "Error importing: Indent_blankline"
   return
end

vim.opt.termguicolors = true

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.g.indentLine_char_list = { " ", "┆", "┊", "|", "¦", "¦", "¦" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = { "help", "dashboard", "packer", "NvimTree" }
vim.g.indentLine_enabled = 1

indent_blankline.setup({
   show_end_of_line = true,
   space_char_blankline = " ",
   show_current_context = true,
   show_current_context_start = true,
})
