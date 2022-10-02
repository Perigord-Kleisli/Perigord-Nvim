-- require "Startup"

local fn = vim.fn
local bootstrap = false

local function ensure (user, repo)
  local install_path = fn.stdpath('data') ..'/site/pack/packer/start/' .. repo
  if fn.empty(fn.glob(install_path)) > 0 then
    print(string.format("Installing: %s/%s", user, repo))
    bootstrap = fn.system({"git", "clone", "--depth", "1", string.format("https://github.com/%s/%s", user, repo), install_path })
    vim.api.nvim_command("packadd " .. repo)
  end
end

ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")
ensure("Olical", "aniseed")
ensure("folke", "which-key.nvim")

require("impatient")

vim.g["aniseed#env"] = {
  module =  "Plugin",
  enable = true,
  compile = true,
};


if bootstrap then
  vim.ui.input({prompt = "All Installs Succesfull! Please run ':PackerInstall' to install the rest"}, function() end)
end
