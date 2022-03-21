-- For plugin setups too small for their own file

local function plug_setup(plugin_name)
   local status_ok, plugin = pcall(require, plugin_name)

   if status_ok then
      return plugin
   else
      local empty_plugin = {}
      empty_plugin.setup = function(_)
         vim.notify("Error importing: " .. plugin_name)
      end
      return empty_plugin
   end
end

plug_setup("nvim-autopairs").setup({
   check_ts = true,
   fast_wrap = {
      map = "<M-e>",
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
   },
})

plug_setup("spellsitter").setup()

plug_setup("bufferline").setup({
   options = {
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      diagnostics = "nvim_lsp",
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      separator_style = "slant",
   },
})

plug_setup("project_nvim").setup({
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
      "aplcore"
   },
   exclude_dirs = { "~/.cargo/*", "~/.cabal/*", "~"},
})

plug_setup("alpha").setup(require "External.Alpha")

plug_setup("nvim-comment-frame").setup()

plug_setup("presence"):setup({ neovim_image_text = "Neo Visual Editor Imporoved" })

plug_setup("gitsigns").setup({
   current_line_blame = true,
   current_line_blame_opts = {
      delay = 200,
   },
})

