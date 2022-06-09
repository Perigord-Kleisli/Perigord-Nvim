(module UI.Dracula)


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
(vim.cmd "highlight CopilotSuggestion guifg=#8292B4 guibg=#202A21")

