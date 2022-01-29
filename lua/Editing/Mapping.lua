--[[
    # Editing.Mapping
        -   Controls options regarding to keybindings
--]]

local function map(mode, shortcut, command)
   vim.api.nvim_set_keymap(mode, shortcut, command .. '<CR>', { noremap = true, silent = true })
end

   vim.api.nvim_set_keymap("", "<space>", "<Nop>", {noremap = true, silent = true})
   vim.g.mapleader = ' '
   vim.g.maplocalleader = ' '

--[ File browsing ]--

   map('n', '<space>op', ':NvimTreeToggle') -- Open file browser
   map('n', '<space><space>', "<cmd>lua require('telescope.builtin').find_files()" ) -- File finder
   map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()" ) -- File finder
   map('n', '<leader>ft', "<cmd>lua require('telescope.builtin').live_grep()" ) -- Grep find
   map('n', '<leader>fk', "<cmd>lua require('telescope.builtin').help_tags()" ) -- Help tags

--[ Terminal ]--

   map('n', '<space>ot', ':split<CR> :term<CR> :set nonumber norelativenumber<CR> i') -- Split screen and open terminal

   map('n', '<space>oT', ':Lspsaga open_floaterm')  -- Floating Terminal
   map('t', '<space>oT', ':Lspsaga close_floaterm')  -- Close floatterm
   map('t', '<Esc>', '<C-\\><C-n>')	     -- Extra terminal exit bind
   map('t', '<space>ot', '<C-\\><C-n> :q')  -- Extra terminal exit bind

--[ Debug and running ]--
   map('n', '<f2>', ':!./%') -- Running script files

--[ Windows ]
   map('n', '<C-Up>', ':resize -2') -- Resize current window
   map('n', '<C-Down>', ':resize +2') --^
   map('n', '<C-Left>', ':vertical resize +2') --^
   map('n', '<C-Right>', ':vertical resize -2') --^

   map("n", "<C-h>", "<C-w>h")	 -- Move between windows with less keys
   map("n", "<C-j>", "<C-w>j")	 --^
   map("n", "<C-k>", "<C-w>k")	 --^
   map("n", "<C-l>", "<C-w>l")	 --^

   map("n", 'H', ":bprevious")	 -- Switch buffer
   map("n", 'L', ":bnext")	 --^

--[ Text Editing ]--

   map('n', '<C-x>;', [[:call nerdcommenter#Comment('i','toggle')]]) -- Toggle comment
   map('v', '<C-x>;', [[:call nerdcommenter#Comment('i','toggle')]]) -- Toggle comment
   map('n', '<C-l>', ':nohl') -- Unhighlight text

   map("i", "jk", "<ESC>k") -- Go to normal by pressing j and k quickly

   map('n', '<leader>fy', "<cmd>lua require('telescope.builtin').registers()" ) -- Get registers
   map("v", "<", "<gvk") -- Stay in indent mode when indenting in visual mode
   map("v", ">", ">gvk") --^

   vim.cmd[[vnoremap <down> :m '>+1<CR>gv=gv]] -- Moving text in visual mode
   vim.cmd[[vnoremap <up> :m '<-2<CR>gv=gv  ]] --^

   -- Completion [[Defined in another file]]
   -- ["<c-k>"] previous item in completion
   -- ["<C-j>"] next item in completion
   -- ["<C-b>"] scroll the document upwards
   -- ["<C-f>"] scroll the document downwards
   -- ["<C-Space>"] manually open completion menu
   -- ["<C-e>"] Cancel completion

--[ Lang ]--

   map("n", "<leader>gd", "<cmd>lua require('telescope.builtin').lsp_references()")
   map('n', '<leader>cx', "<cmd>lua require('telescope.builtin').diagnostics()") -- show line diagnostics
    -- [ LSP defined in another file ../Lang/LSP/Handlers.lua]
   -- map("n", "K", "<cmd>lua vim.lsp.buf.hover()")	-- Gets info over word
   -- map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()") -- TODO
   -- map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()")
   -- map("n", "<leader>cg", "<cmd>lua vim.lsp.buf.references()")
   -- map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()") -- Rename LSP object
   -- map("n", "<leader>ce", "<cmd>lua vim.diagnostic.open_float()") -- Get line diagnostic
   -- map("n", "<leader>ch", "<cmd>lua vim.lsp.buf.code_action()") -- Apply code action
   -- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })') -- Prev diagnostic
   -- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })') -- Next diagnostic
   -- map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()') -- Show declarations
   -- map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()')  -- Go to definition

    -- APL
vim.g.apl_prefix_key = '.'
