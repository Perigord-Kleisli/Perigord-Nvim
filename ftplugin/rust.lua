local rt = require("rust-tools")
local capabilities = (require("Lang.LSP")).capabilities
local hydra = require("Mapping.Lang")
local function _1_(_client, bufnr)
  local _opts = vim.tbl_extend("keep", {noremap = true, silent = true}, {buffer = bufnr})
  local function _2_()
    return vim.schedule(vim.lsp.codelens.refresh)
  end
  vim.api.nvim_create_autocmd({"CursorHold", "InsertLeave", "BufWritePost", "TextChanged"}, {group = vim.api.nvim_create_augroup("rust-tools-code-lens", {}), callback = _2_, buffer = bufnr})
  hydra({["extra-heads"] = {{"e", vim.lsp.codelens.run, {desc = "Evaluate Codelens", exit = true}}}})
  return nil
end
rt.setup({server = {capabilities = capabilities, tools = {autoSetHint = true, runnables = {use_telescope = true}, inlay_hints = {show_parameter_hints = true}, hover_actions = {auto_focus = true}}, settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}, on_attach = _1_}})
return vim.cmd(":LspStart rust_analyzer")
