return {
  recommended = {
    ft = "lua",
  },
  { "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      }
    } },
  { "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "lua")
    end
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        lua_ls = {}
      }
    }
  },
  { "Bilal2453/luvit-meta", lazy = true },
  { -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
