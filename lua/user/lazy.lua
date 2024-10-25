local imports = { { import = "user.plugins" } }
local utils = require("user.util")

local project_roots = {}

for _, lang in ipairs(utils.ls(vim.fn.stdpath("config") .. "/lua/user/plugins/lang")) do
  lang = lang:match("(.*)%.lua")
  local langplugins = require("user.plugins.lang." .. lang)
  local recommended = langplugins.recommended
  langplugins.recommended = nil

  if recommended.root ~= nil then
    project_roots[lang] = recommended.root

    recommended.event = recommended.event or {}
    table.insert(recommended.event, {
      event = "User",
      pattern = lang .. "Project"
    })
  end

  table.insert(imports,
    vim.tbl_map(function(plugin)
      return vim.tbl_extend("keep", plugin, recommended)
    end
      , langplugins))
end

require("lazy").setup(imports)

local pathlib = require('plenary.path')
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function(ev)
    local path
    if ev.event == 'VimEnter' then
      path = pathlib:new(vim.fn.getcwd())
    elseif ev.file ~= "" then
      path = pathlib:new(ev.file)
    else
      return
    end

    local parents = path:parents()
    table.insert(parents, 0, path.filename)

    for lang, patterns in pairs(project_roots) do
      for _, p in pairs(parents) do
        if type(patterns) == 'string' then
          patterns = { patterns }
        end
        for _, pattern in ipairs(patterns) do
          if not vim.tbl_isempty(vim.fn.glob(p .. "/" .. pattern, false, true)) then
            vim.api.nvim_exec_autocmds('User', { pattern = lang .. "Project" })
            goto lang_continue
          end
        end
      end
      ::lang_continue::
    end

  end
})
