local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
   vim.notify("Error importing: toggleterm")
   return
end

toggleterm.setup({
   shading_factor = 2,
   size = 20,
   direction = "float",
   float_ops = {
      border = "curved",
   },
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function TT_LAZYGIT_TOGGLE()
   lazygit:toggle()
end

local ghci = Terminal:new({ cmd = "ghci", hidden = true })
function TT_GHCI_TOGGLE()
   ghci:toggle()
end

local btop = Terminal:new({ cmd = "btop", hidden = true })
function TT_BTOP_TOGGLE()
   btop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function TT_PYTHON_TOGGLE()
   python:toggle()
end

local lynx = Terminal:new({ cmd = "lynx duckduckgo.com", hidden = true })

function TT_LYNX_TOGGLE()
   lynx:toggle()
end


