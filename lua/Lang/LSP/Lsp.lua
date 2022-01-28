local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
   vim.notify("Error importing: Lspconfig")
  return
end

require("Lang.LSP.Lsp-Installer")
require("Lang.LSP.Handlers").setup()
