--[[
    # Editing.Utils
        -   Controls various options that controls the effects of inputs behind the scenes
--]]

--[ Indentation ]
vim.o.tabstop = 6 -- Number of spaces a tab is
vim.o.expandtab = true -- Make tabs spaces
vim.o.softtabstop = 3 -- Allows for tab size lower
--^ than 'tabstop' via mixing
--^ spaces and tabs
vim.o.smartindent = true -- A bit complex for a tl;dr
vim.o.shiftwidth = 3 -- Number of spaces used by indents

vim.o.autoindent = true -- Indent new lines
vim.o.smarttab = true -- Insert blanks based on 'shiftwidth'

--[ Searching ]
vim.o.incsearch = true -- Update highlighting while typing
vim.o.ignorecase = true -- Ignore case
vim.o.smartcase = true -- Overrides ignore case if search pattern
--^ contains Uppercase characters
vim.o.wrapscan = false -- Disable wrapping in searches
--^ mostly to allow recursive macros
vim.o.hlsearch = true -- Highlight search after confirming

--[ Windowing ]
vim.o.splitbelow = true -- split downwards
vim.o.splitright = true -- split rightwards

--[ Misc ]

vim.o.undofile = true -- Enable undo file on exit
vim.o.undodir = "/tmp/nvim-undos/undo" -- location of undo file

vim.o.mouse = "a" -- Enable mouse usage in nvim
vim.o.iskeyword = vim.o.iskeyword .. ",-" -- add characters that would divide a word
