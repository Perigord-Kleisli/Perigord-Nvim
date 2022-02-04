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

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}
