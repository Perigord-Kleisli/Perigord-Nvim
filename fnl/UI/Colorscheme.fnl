(module UI.Colorscheme
  {autoload {dracula dracula}})

(dracula.setup
  {:colors {:bg  "#09090A"
            :menu  "#080a0c"
            :visual  "#272568"
            :selection "#232057"}
   :italic_comment true})
  
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

(set vim.g.gitblame_highlight_group :NonText)
(set vim.g.gitblame_ignored_filetypes [:NvimTree :TelescopePrompt])
