local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
   vim.notify("Error importing: Nvim-Treesitter")
   return
end

treesitter.setup {
   highlight = {
	enable = true,
	disable = {},
	},
   indent = {
	enable = true,
   disable = {},
   },
   autopairs = {
      enable = true
   },
  matchup = {
    enable = true
  },
   rainbow = {
	enable = true,
	extended_mode = true,
	max_file_lines = nil
   },
   ensure_installed = {
   "toml",
   "bash",
   "c",
   "json",
   "cpp",
   "haskell",
   "python",
   "rust",
   "javascript",
   "lua",
   "html",
   "scss"
   },
}
