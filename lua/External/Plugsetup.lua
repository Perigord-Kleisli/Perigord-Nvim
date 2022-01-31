-- For plugin setups too small for their own file

local function is_ok(plugin_name)
   local status_ok, plugin = pcall(require, plugin_name)
   if status_ok then
      return true
   else
      vim.notify("Error importing:" .. plugin_name)
      return false
   end
end

if is_ok "nvim-autopairs" then
   require("nvim-autopairs").setup({
      check_ts = true,
      fast_wrap = {},
   })
end

if is_ok "spellsitter" then
   require("spellsitter").setup()
end

if is_ok "bufferline" then
   require("bufferline").setup({
      options = {
         close_command = "Bdelete! %d",
         right_mouse_command = "Bdelete! %d",
         diagnostics = "nvim_lsp",
         offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
         separator_style = "slant",
      },
   })
end

if is_ok "project.nvim" then
   require("project_nvim").setup({
      patterns = {
         ".git",
         "_darcs",
         ".hg",
         ".bzr",
         ".svn",
         "Makefile",
         "package.json",
         ".cabal",
         "stack.yaml",
         "CMakeLists.txt",
         ".cargo",
      },
      exclude_dirs = { "~/.cargo/*", "~/.cabal/*" },
   })
end

if is_ok "dracula" then
   vim.cmd [[colorscheme dracula]]
end

if is_ok "indent_blankline" then
   require("indent_blankline").setup()
end

if is_ok "Comment-frame" then
   require("nvim-comment-frame").setup()
end

if is_ok "presence" then
   require("presence").setup({
      neovim_image_text = "Neo Visual Editor Improved",
   })
end

if is_ok "gitsigns" then
   require("gitsigns").setup()
end
