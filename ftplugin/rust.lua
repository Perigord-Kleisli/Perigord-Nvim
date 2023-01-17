local rt = require("rust-tools")
local capabilities = (require("Lang.LSP")).capabilities
local hydra = require("Mapping.Lang")
local function _1_(_client, bufnr)
  local _opts = vim.tbl_extend("keep", {noremap = true, silent = true}, {buffer = bufnr})
  hydra()
  return nil
end
rt.setup({server = {capabilities = capabilities, settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}, on_attach = _1_}})
return vim.cmd(":LspStart rust_analyzer")
