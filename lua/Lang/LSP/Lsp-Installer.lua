local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
   vim.notify("Error importing: Nvim-Lsp-Installer")
   return
end

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("Lang.LSP.Handlers").on_attach,
		capabilities = require("Lang.LSP.Handlers").capabilities,
	}

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("Lang.Lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	server:setup(opts)
end)

