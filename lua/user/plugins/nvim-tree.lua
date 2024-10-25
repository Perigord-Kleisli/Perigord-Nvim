return {
  { "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', '<C-h>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '<C-l>', api.tree.change_root_to_node, opts('Down'))
      end
    }
  }
}
