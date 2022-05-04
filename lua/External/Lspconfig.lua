local status_ok, nvim_lsp = pcall(require, 'lspconfig')
if not status_ok then
   vim.notify("Error importing: lspconfig")
   return
end

local servers = {"bashls", "clangd", "cmake", "hls", "html", "pyright", "rls", "sumneko_lua", "tsserver", "rnix"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup{}
end

