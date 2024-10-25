return {
  recommended = { ft = "nix", root = "flake.nix" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "nix")
    end
  },
  { "MrcJkb/telescope-manix",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("manix")
    end
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        nil_ls = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', "<leader>lh", "<cmd>Telescope manix<cr>", { buffer = bufnr, desc = "Manix Search" })
          end
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
