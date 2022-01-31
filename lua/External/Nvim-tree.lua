local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
   return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
   return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
vim.g.nvim_tree_respect_buf_cwd = 1

nvim_tree.setup({
   ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
   },
   update_focused_file = {
      enable = true,
      update_cwd = true,
   },
   auto_close = true,
   update_cwd = true,
   update_to_buf_dir = {
      enable = true,
      auto_open = true,
   },
   diagnostics = { enable = true },
   view = {
      auto_resize = true,
      mappings = {
         custom_only = false,
         list = {
            { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
            { key = "h", cb = tree_cb "close_node" },
            { key = "v", cb = tree_cb "vsplit" },
         },
      },
   },
   show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
      tree_width = 30,
   },
})
