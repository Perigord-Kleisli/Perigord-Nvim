--[[
    # UI.UI
        - Controls the visuals of nvim
--]]


--[ Bars ]
   vim.o.showtabline	      = 1	 -- Show tabs only when its more than one

   vim.o.number		      = true   -- Show cursor location
   vim.o.relativenumber	      = true   -- show numbers relative to cursor
   vim.o.numberwidth	      = 2      -- Width of the number bar

--[ Theme ]--
   vim.cmd[[colorscheme dracula]]
   --vim.cmd[[ "highlight CursorLine gui=underline" ]]
   -- vim.cmd("highlight CursorLineNr term=bold cterm=none ctermbg=none ctermfg=yellow gui=bold")
   vim.g.transparent_enabled  = true -- remove background in theme
   vim.o.title		      = true   -- set windowname as title name
   vim.o.termguicolors	      = true   -- Enable terminal colors


--[ Body ]--
   vim.g.indentLine_char_list = {' ', '┆', '┊', '|', '¦', '¦','¦'}  -- Indent lines used on tabs
   vim.opt.scrolloff	      = 4      -- Lines before scrolling the screen
   vim.opt.sidescrolloff      = 12     -- Same as above but sideways
   --vim.o.cursorline	      = true   -- enable cursorline
   vim.opt.wrap		      = false  -- Dont wrap long text
