local Terminal = require("toggleterm.terminal").Terminal
local terminal_i = 1

local terminals = {}

local function getTerminal(n)
  if n > #terminals or n < 1 then
    return
  end

  terminals[terminal_i]:close()

  terminals[n]:open()
  terminals[n]:focus()
  terminal_i = n
end

local function closeTerminal(n)
  if terminal_i == n then
    if terminal_i == 1 and #terminals >= 2 then
      getTerminal(2)
    elseif terminal_i == #terminals and #terminals >= 2 then
      getTerminal(terminal_i - 1)
    end
  elseif terminal_i > n then
    terminal_i = terminal_i - 1
  end
  table.remove(terminals, n)
end

table.insert(terminals, Terminal:new({
  on_exit = function() closeTerminal(1) end
}))

local function nextTerminal()
  getTerminal(terminal_i + 1)
end

local function prevTerminal()
  getTerminal(terminal_i - 1)
end

local function createNextTerminal()
  local terminal_i_copy = terminal_i
  table.insert(terminals, Terminal:new({
    on_exit = function() closeTerminal(terminal_i_copy + 1) end
  }))
  getTerminal(#terminals)

  -- creating a new terminal takes some time, so we need to wait
  vim.defer_fn(function()
    vim.cmd('startinsert')
  end, 200)
end

local function createPrevTerminal()
  if terminal_i == 1 then
    return
  end

  local terminal_i_copy = terminal_i
  table.insert(terminals, terminal_i_copy, Terminal:new({
    on_exit = function() closeTerminal(terminal_i_copy) end
  }))
  terminal_i = terminal_i + 1
  prevTerminal()

  -- creating a new terminal takes some time, so we need to wait
  vim.defer_fn(function()
    vim.cmd('startinsert')
  end, 200)
end

local function swapNext()
  if terminal_i == #terminals or #terminals <= 1 then
    return
  end

  local temp = terminals[terminal_i + 1]
  terminals[terminal_i + 1] = terminals[terminal_i]
  terminals[terminal_i] = temp
  terminal_i = terminal_i + 1
  require('lualine').refresh()
end

local function swapPrev()
  if terminal_i == 1 or #terminals <= 1 then
    return
  end
  local temp = terminals[terminal_i - 1]
  terminals[terminal_i - 1] = terminals[terminal_i]
  terminals[terminal_i] = temp
  terminal_i = terminal_i - 1
  require('lualine').refresh()
end

_G.ToggletermStatus = function()
  if vim.fn.mode() ~= 't' then
    return ''
  end
  local status = ""

  for i = 1, #terminals - 1 do
    if i == terminal_i then
      status = status .. "[" .. i .. "]|"
    else
      status = status .. i .. "|"
    end
  end

  if #terminals == terminal_i then
    status = status .. "[" .. terminal_i .. "]"
  else
    status = status .. #terminals
  end

  return status
end

local function toggleTerminal()
  if #terminals == 0 then
    table.insert(terminals, Terminal:new({
      on_exit = function() closeTerminal(1) end
    }))
  end


  if terminals[terminal_i]:is_focused() then
    terminals[terminal_i]:close()
  elseif terminals[terminal_i]:is_open() then
    terminals[terminal_i]:focus()
    vim.defer_fn(function()
      vim.cmd('startinsert')
    end, 150)
  else
    terminals[terminal_i]:open()
  end
end

return {
  closeTerminal = closeTerminal,
  nextTerminal = nextTerminal,
  prevTerminal = prevTerminal,
  createNextTerminal = createNextTerminal,
  createPrevTerminal = createPrevTerminal,
  swapNext = swapNext,
  swapPrev = swapPrev,
  toggleTerminal = toggleTerminal,
}
