(module UI.Colorscheme)


;(set vim.g.dracula_transparent_bg true)

(set vim.g.italic_comment true)
(set vim.g.dracula_colors 
  {:bg  "#09090A"
   :menu  "#080a0c"
   :visual  "#272568"
   :selection "#232057"})
(vim.cmd 
  "
  try 
      colorscheme dracula
  catch 
      echo \"Error Configuring: dracula.nvim\"
  endtry")

(vim.cmd "highlight debugPC guibg=#10504A")
(vim.cmd "highlight TreeSitterContext guibg=#081220")
(vim.cmd "highlight TreesitterContextLineNumber guifg=#8A888A gui=underline")
(vim.cmd "highlight CopilotSuggestion guifg=#8292B4 guibg=#202A21")

(set vim.g.gitblame_highlight_group :NonText)
(set vim.g.gitblame_ignored_filetypes [:NvimTree :TelescopePrompt])
