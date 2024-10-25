return { {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")
    catppuccin.setup({
      flavor = 'mocha',
      transparent_background = true,
      custom_highlights = {
        Whitespace = { fg = '#32343E' },
        RainbowRed = { fg = "#E06C75" },
        RainbowYellow = { fg = "#E5C07B" },
        RainbowBlue = { fg = "#61AFEF" },
        RainbowOrange = { fg = "#D19A66" },
        RainbowGreen = { fg = "#98C379" },
        RainbowViolet = { fg = "#C678DD" },
        RainbowCyan = { fg = "#56B6C2" },
        DashboardHeader = { fg = "#8AFF80" },
        DashboardKey = { fg = "#FF9580" },
        DashboardDesc = { fg = "#87FEF8" },
        DashboardIcon = { fg = "#FCFC7F", bold = true },
        DashboardFooter = { fg = "#5D5D65" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        dashboard = true,
        ts_rainbow = true,
        which_key = true,
        lsp_trouble = true,
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true
        },
        semantic_tokens = true,
        indent_blankline = {
          enabled = true
        },
        notify = true,
        beacon = true,
        telescope = {
          enabled = true
        },
      }
    })

    local colors = require("catppuccin.palettes").get_palette()
    local TelescopeColor = {
      TelescopeMatching = { fg = colors.flamingo },
      TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

      TelescopePromptPrefix = { bg = colors.surface0 },
      TelescopePromptNormal = { bg = colors.surface0 },
      TelescopeResultsNormal = { bg = colors.mantle },
      TelescopePreviewNormal = { bg = colors.mantle },
      TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
      TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
      TelescopeResultsTitle = { fg = colors.mantle },
      TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    }

    for hl, col in pairs(TelescopeColor) do
      vim.api.nvim_set_hl(0, hl, col)
    end
    vim.cmd([[colorscheme catppuccin]])
  end
} }
