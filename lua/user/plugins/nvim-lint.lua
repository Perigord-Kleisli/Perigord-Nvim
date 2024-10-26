return { { "mfussenegger/nvim-lint",
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint', },
      typescript = { 'eslint', },
      bash = { 'shellcheck' },
      sh = { 'shellcheck' },
      nix = { 'statix', 'deadnix' }
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "BufWinEnter" }, {
      callback = function()
        require("lint").try_lint()
      end
    })
  end }
}
