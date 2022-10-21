(module UI.Colorscheme
  {autoload {catppuccin catppuccin}})

(set vim.g.catpuccin_flavour :mocha)

(catppuccin.setup
  {:dim_inactive {:enabled true}})
   
(vim.api.nvim_command "colorscheme catppuccin")

(vim.cmd "highlight debugPC guibg=#10504A")
(vim.cmd "highlight TreeSitterContext guibg=#081220")
(vim.cmd "highlight TreesitterContextLineNumber guifg=#8A888A gui=underline")

(set vim.g.gitblame_highlight_group :NonText)
(set vim.g.gitblame_ignored_filetypes [:NvimTree :TelescopePrompt])
