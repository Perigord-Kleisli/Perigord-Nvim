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

(var focuses 0)
(vim.api.nvim_create_autocmd [:FocusGained :VimEnter]
                             {:callback #(vim.defer_fn #(when (<= focuses 5)
                                                          (os.execute (.. "xmodmap "
                                                                          (.. (vim.fn.stdpath :config)
                                                                              :/scripts/swap_esc.xmodmap
                                                                              "> /dev/null 2>&1")))
                                                          (set focuses (+ focuses 1)))
                                                       200)})

(vim.api.nvim_create_autocmd [:FocusLost :QuitPre]
                             {:callback #(when (<= focuses 5)
                                           (vim.defer_fn #(os.execute (.. "xmodmap "
                                                                          (.. (vim.fn.stdpath :config)
                                                                              :/scripts/unswap_esc.xmodmap
                                                                              "> /dev/null 2>&1")))
                                                         200))})

(vim.api.nvim_create_autocmd :QuitPre
                             {:callback #(os.execute (.. "xmodmap "
                                                         (.. (vim.fn.stdpath :config)
                                                             :/scripts/unswap_esc.xmodmap
                                                             "> /dev/null 2>&1")))})
