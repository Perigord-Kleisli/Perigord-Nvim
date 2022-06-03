(module Options)

(set vim.o.iskeyword (.. vim.o.iskeyword  ",-")) 

(set vim.o.tabstop 4) 
(set vim.o.expandtab true) 
(set vim.o.softtabstop 2) 
(set vim.o.smartindent true) 
(set vim.o.shiftwidth 2)
(set vim.o.autoindent true) 
(set vim.o.smarttab true) 
(set vim.o.wrap false)
      
(set vim.o.incsearch true) 
(set vim.o.wrapscan true) 
(set vim.o.hlsearch true) 
      
(set vim.o.ignorecase true) 
(set vim.o.smartcase true) 

(set vim.o.splitbelow true) 
(set vim.o.splitright true) 

(set vim.wo.foldmethod :indent)
(set vim.o.foldlevel 99)
(set vim.o.foldexpr  "nvim_treesitter#foldexpr()")

(set vim.o.undofile true) 
(set vim.o.undodir "/tmp/nvim-undos") 

(set vim.g.mapleader " ")
(set vim.o.timeoutlen 300)  
(set vim.o.mouse :a) 

(set vim.g.termguicolors true)
(set vim.o.laststatus 3) 

(set vim.o.number true)
(set vim.o.relativenumber true)
(vim.api.nvim_create_autocmd [:InsertEnter] 
  {:pattern "*"
   :command "set norelativenumber"})
(vim.api.nvim_create_autocmd [:InsertLeave] 
  {:pattern "*"
   :command "set relativenumber"})

(vim.api.nvim_create_autocmd [:TextYankPost]
  {:pattern "*"
   :callback (fn [] (vim.highlight.on_yank
                      {:higroup :visual
                       :timeout 180}))})

(set vim.g.apl_prefix_key ".")
(set vim.g.Hexokinase_highlighters ["backgroundfull"])
