local bootstrap = false

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("Cloning lazy.nvim and hotpot.nvim...")
  bootstrap = true;
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/rktjmp/hotpot.nvim",
    vim.fn.stdpath "data" .. "/lazy/hotpot.nvim",
  })
end
vim.opt.rtp:prepend(vim.fn.stdpath "data" .. "/lazy/hotpot.nvim")
vim.opt.rtp:prepend(lazypath)

vim.cmd("helptags " .. vim.fn.stdpath "data" .. "/lazy/hotpot.nvim/doc")
require("hotpot")

vim.opt.termguicolors = true
vim.g.mapleader = " "

require "Plugin"

if bootstrap then
  local secrets = io.open(vim.fn.stdpath "config" .. "/secrets.json", "w+")
  if secrets ~= nil then
    secrets:write [[
    {
      "huggingface-token": ""
    }
    ]]
  else
    error("Unable to create a secrets.json file")
  end
  vim.notify("Bootstrap complete, close and open Neovim to ensure proper running")
end

-- local plenary_ok, _ = pcall(require, "plenary")
-- if plenary_ok then
--   local scandir = require "plenary.scandir"
--   local files = scandir.scan_dir(vim.fn.stdpath "config" .. "/ftplugin")
--   for _, v in pairs(files) do
--     if string.match(v, "fnl$") then
--       local luacode = vim.fn.system({ "fennel", "-c", v })
--       local file = io.open(string.gsub(v, "fnl$", "lua"), "w")
--       if file ~= nil then
--         file:write(luacode)
--         file:close()
--       end
--     end
--   end
-- end
--
-- require 'nvim-startup'.setup()
