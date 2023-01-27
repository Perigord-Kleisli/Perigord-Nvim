local hydra = require("Mapping.Lang")
local ht = require("haskell-tools")
local capabilities = (require("Lang.LSP")).capabilities
local function on_attach(client, bufnr)
  local _opts = vim.tbl_extend("keep", {noremap = true, silent = true}, {buffer = bufnr})
  ht.tags.generate_project_tags(nil, {refresh = true})
  vim.lsp.codelens.display(nil, bufnr, client)
  return hydra({["extra-heads"] = {{"R", ht.repl.toggle, {desc = "Toggle REPL", exit = true}}, {"<C-r>", ht.repl.reload, {desc = "Reload REPL", exit = true}}, {"e", vim.lsp.codelens.run, {desc = "Evaluate Codelens", exit = true}}}})
end
ht.setup({hls = {capabilities = capabilities, settings = {haskell = {formattingProvider = "ormolu", plugin = {rename = {config = {diff = true}}}}}, cmd = {"haskell-language-server", "--lsp"}, on_attach = on_attach}, repl = "toggleterm"})
return vim.cmd(":LspStart hls")
