local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
      vim.notify("Error importing: Null-ls")
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua
	   ,  formatting.asmfmt
         ,  formatting.brittany
         ,  formatting.cabal_fmt
         ,  formatting.clang_format
         ,  formatting.cmake_format
         ,  formatting.markdownlint
         --,  formatting.nixfmt

         ,  diagnostics.cppcheck
         ,  diagnostics.markdownlint
         ,  diagnostics.pylint
         ,  diagnostics.shellcheck
         ,  diagnostics.write_good

         , code_actions.shellcheck

         , hover.dictionary
	},
})
