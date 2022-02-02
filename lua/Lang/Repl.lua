M = {}
local status_ok, Term = pcall(require, "toggleterm.terminal")
if not status_ok then
   vim.notify "Error importing: toggleterm, required for 'Repl.lua'"
   return
end

local function has_file(pattern)
   for _, v in pairs(require("plenary.scandir").scan_dir(".", { hidden = true, depth = 2 })) do
      if string.match(v, pattern) then
         return true
      end
   end
   return false
end

local switch = function(param, case_table)
   local case = case_table[param]
   if case then
      return case()
   end
   local def = case_table["default"]
   return def and def() or nil
end

M.repl = function(lang, termopts)
   termopts = termopts or { hidden = true, direction = "horizontal" }
   switch(lang, {
      ["haskell"] = function()
         termopts.cmd = (has_file ".*cabal$" and "cabal repl" or ("ghci " .. vim.api.nvim_buf_get_name(0))) or termopts.cmd
         Term.Terminal:new(termopts):toggle()
      end,
      ["python"] = function ()
         termopts.cmd = "python" or termopts.cmd
         Term.Terminal:new(termopts):toggle()
      end,
      ["default"] = function()
         vim.notify("language '" .. vim.bo.filetype .. "' not recognized")
      end,
   })
end

return M
