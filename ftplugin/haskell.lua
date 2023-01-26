local hydra = require("Mapping.Lang")
local ht = require("haskell-tools")
local capabilities = (require("Lang.LSP")).capabilities
local function _1_(client, bufnr)
  local _opts = vim.tbl_extend("keep", {noremap = true, silent = true}, {buffer = bufnr})
  ht.tags.generate_project_tags(nil, {refresh = true})
  local cmd = (require("hydra.keymap-util")).cmd
  vim.lsp.codelens.display(nil, bufnr, client)
  hydra({name = "Browse/Open", mode = "n", config = {invoke_on_body = true, foreign_keys = "run", type = "statusline"}, body = "<leader>o", heads = {{"p", cmd("NvimTreeToggle"), {desc = "Sidebar", exit = true}}, {"t", ht.repl.toggle, {desc = "REPL", exit = true}}, {"T", cmd("ToggleTerm"), {desc = "Terminal", exit = true}}, {"r", "<CMD>Telescope oldfiles<CR>", {desc = "Recent Files", exit = true}}, {"h", cmd("BufferLineCyclePrev"), {desc = "Previous Buffer"}}, {"l", cmd("BufferLineCycleNext"), {desc = "Next Buffer"}}, {"<esc>", nil, {desc = "Exit", exit = true}}}})
  return hydra({["extra-heads"] = {{"R", ht.repl.toggle, {desc = "Toggle REPL", exit = true}}, {"<C-r>", ht.repl.reload, {desc = "Reload REPL", exit = true}}, {"e", vim.lsp.codelens.run, {desc = "Evaluate Codelens", exit = true}}}})
end
ht.setup({hls = {capabilities = capabilities, cmd = {"haskell-language-server", "--lsp"}, on_attach = _1_}, repl = "toggleterm"})
return vim.cmd(":LspStart hls")
