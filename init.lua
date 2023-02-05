local bootstrap = false

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify "Cloning lazy.nvim and hotpot.nvim, you may see 'can't check mtime' errors later"
  bootstrap = true
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
require "hotpot"

vim.opt.termguicolors = true
vim.g.mapleader = " "

if bootstrap then
  vim.ui.input({ prompt = "Bootstrap complete, close and open Neovim to ensure proper running" }, function(_)
    vim.cmd "q"
  end)
end

require "Plugin"
require "Mapping"
