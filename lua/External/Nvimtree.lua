local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
   vim.notify("Error importing: Nvim-Tree")
   return
end

vim.g.nvim_tree_indent_markers = 1

nvim_tree.setup({
  view = {
    side = 'left',
    auto_resize = true,
    mappings = {custom_only = false, list = {}}
  }
})
