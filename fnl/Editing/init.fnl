(set vim.o.iskeyword (.. vim.o.iskeyword ",-"))
(set vim.o.tabstop 8)
(set vim.o.timeoutlen 300)
(set vim.o.expandtab true)
(set vim.o.softtabstop 4)
(set vim.o.smartindent true)
(set vim.o.shiftwidth 4)
(set vim.o.autoindent true)
(set vim.o.smarttab true)

(set vim.o.undofile true)
(set vim.o.undodir :/tmp/nvim-undos)

(set vim.opt.scrolloff 8)
(set vim.o.wrap false)
(set vim.o.splitbelow true)
(set vim.o.mouse :a)
(set vim.o.cmdheight 0)

(vim.api.nvim_create_autocmd :RecordingEnter
                             {:pattern "*"
                              :callback #(vim.notify (.. "Recording Macro: ("
                                                         (vim.fn.reg_recording)
                                                         ")"))})

(vim.api.nvim_create_autocmd :RecordingLeave
                             {:pattern "*"
                              :callback #(vim.notify "Finished recording Macro")})
