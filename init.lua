local fn = vim.fn
local bootstrap = false

local function ensure(user, repo)
  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/" .. repo
  if fn.empty(fn.glob(install_path)) > 0 then
    print(string.format("Installing: %s/%s", user, repo))
    bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      string.format("https://github.com/%s/%s", user, repo),
      install_path,
    })
    vim.api.nvim_command("packadd " .. repo)
  end
end

local f = io.open(vim.fn.stdpath('config') .. "/secrets.json", 'r')
if f == nil then
  local fw = io.open(vim.fn.stdpath('config') .. "/secrets.json", 'w+')
  fw:write([[
  {
    "huggingface-token": ""
  }
  ]])
else
  f:close()
end


ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")
ensure("rktjmp", "hotpot.nvim")
local hotpot_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/hotpot.nvim"

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
  print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
  vim.fn.system({ "git", "clone", "https://github.com/rktjmp/hotpot.nvim", hotpot_path })
  vim.cmd("helptags " .. hotpot_path .. "/doc")
end
require("hotpot").setup()
require "config"
require "impatient"

local plenary_ok, _ = pcall(require, "plenary")
if plenary_ok then
  local scandir = require "plenary.scandir"
  local files = scandir.scan_dir(vim.fn.stdpath "config" .. "/ftplugin")
  for _,v in pairs(files) do
    if string.match(v,"fnl$") then
      local luacode = vim.fn.system({"fennel","-c",v})
      local file = io.open(string.gsub(v,"fnl$","lua"),"w")
      file:write(luacode)
      file:close()
    end
  end
end
-- end

if bootstrap then
  vim.ui.input({ prompt = "All Installs Succesfull! Please run ':PackerInstall' to install the rest" }, function() end)
end
-- require 'nvim-startup'.setup()
