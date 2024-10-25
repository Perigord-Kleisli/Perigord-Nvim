local text_header =
{ "                                                                                   ",
  "                                                                                   ",
  "                                                                                   ",
  "                                                                                   ",
  "                                                                                   ",
  "         -╲         '-                                                             ",
  "       -' :╲        │ '-                                                           ",
  "     -'   : ╲       │   '-                           ████                          ",
  "   -'·    :  ╲      │     '-                         ████                          ",
  "  '.-.·   :   ╲     │       │                                                      ",
  "  │. .-·  :    ╲    │       │    ▄▄▄          ▗▄▄▄   ▅▅▅▅   ▄▄▄  ▗▄▄▖   ▗▄▄▄▄▄▖    ",
  "  │ . .-· :     ╲   │       │    ▜███▙       ▟███▛   ████   ███▙▟████▙▄▟███████▙   ",
  "  │. . .-·;      ╲  │       │     ▜███▙     ▟███▛    ████   ████████████████████▙  ",
  "  │ . . .-│       ╲ │       │      ▜███▙   ▟███▛     ████   ███▛    ▜████▛    ▜██▌ ",
  "  │. . . .│╲       ╲│       │       ▜███▙ ▟███▛      ████   ███      ▐███     ▐██▌ ",
  "  │ . . . │ ╲       ;-      │        ▜███▇███▛       ████   ███       ██▌      ██▌ ",
  "  │. . . .│  ╲      :·-     │         ▜█████▛        ████   ███       ██▌      ██▌ ",
  "  │ . . . │   ╲     : .-    │          ▜███▛         ████   ███       ██▌      ██▌ ",
  "  │. . . .│    ╲    :. .-   │           ▜█▛          ████   ███       ██▌      ██▌ ",
  "  `- . . .│     ╲   : . .- -'                                                      ",
  "    `- . .│      ╲  :. ..-'                                                        ",
  "      `-. │       ╲ :..-'                                                          ",
  "         `│        ╲;-'                                                            ",
  "                                                                                   ",
  "                                                                                   " }



return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    event = 'User',
    lazy = true,
    config = function()

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()


          local stats = require('lazy').stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          require('dashboard').setup {
            theme = 'doom',
            config = {
              header = text_header,
              center = {
                { icon = '', desc = '' }
              },
              footer = {
                "Current Directory: " .. vim.fn.getcwd(),
                "",
                "Loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
              }
            }
          }
        end
      })
    end,
  }
}
