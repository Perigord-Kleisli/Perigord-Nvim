local _2afile_2a = "/home/truff/.config/nvim/fnl/Lang/LSP.fnl"
local _2amodule_name_2a = "Lang.LSP"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local navic, lspconfig, a, cmp_lsp, idris = autoload("nvim-navic"), autoload("lspconfig"), autoload("aniseed.core"), autoload("cmp_nvim_lsp"), autoload("idris2")
do end (_2amodule_locals_2a)["navic"] = navic
_2amodule_locals_2a["lspconfig"] = lspconfig
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["cmp-lsp"] = cmp_lsp
_2amodule_locals_2a["idris"] = idris
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
do end (_2amodule_locals_2a)["capabilities"] = capabilities
local servers = {"bashls", "ccls", "cmake", "html", "idris2_lsp", "pyright", "rls", "sumneko_lua", "tsserver", "rnix"}
_2amodule_locals_2a["servers"] = servers
for _, server in ipairs(servers) do
  local function _1_(client, bufnr)
    return navic.attach(client, bufnr)
  end
  lspconfig[server].setup({capabilities = capabilities, on_attach = _1_})
end
local function _2_(client, bufnr)
  return navic.attach(client, bufnr)
end
lspconfig.html.setup({capabilities = capabilities, on_attach = _2_, cmd = {"html-languageserver", "--stdio"}})
local function _3_(client, bufnr)
  return navic.attach(client, bufnr)
end
lspconfig.hls.setup({capabilities = capabilities, on_attach = _3_, cmd = {"haskell-language-server", "--lsp"}, settings = {haskell = {formattingProvider = "brittany", hlintOn = true, renameOn = true, plugin = {hlint = {globalOn = true}}, [{eval = {globalOn = true, config = {exception = true}}}] = {tactics = {globalOn = true}}, [{gadt = {globalOn = true}}] = {splice = {globalOn = true}}, [{rename = {globalOn = true}}] = {haddockComments = {globalOn = true}}}}})
vim.diagnostic.config({virtual_text = false, signs = true, float = {focusable = false, style = "minimal", border = "rounded", source = "always"}})
local signs = {DiagnosticSignError = "\239\129\151", DiagnosticSignWarn = "\239\129\177", DiagnosticSignHint = "\239\129\154", DiagnosticSignInfo = "\239\129\153"}
_2amodule_locals_2a["signs"] = signs
for diag_type, icon in pairs(signs) do
  vim.fn.sign_define(diag_type, {text = icon, texthl = diag_type, numhl = diag_type})
end
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
return _2amodule_2a