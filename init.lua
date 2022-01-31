require "Options"

local project_nvim = require("project_nvim")
local recent_projects = project_nvim.get_recent_projects()

print(vim.inspect(recent_projects))
