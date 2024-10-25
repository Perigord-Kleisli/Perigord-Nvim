return {
  { "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      vim.o.laststatus = 3
    end,
    opts = function()
      local function cur_macro()
        local recording = vim.fn.reg_recording()
        if recording ~= '' then
          return "Recording Macro: '" .. recording .. "'"
        else
          return ""
        end
      end

      return {
        options = {
          theme = "catppuccin",
          disabled_filetypes = { "dashboard", "TelescopePrompt" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filetype", "filename", "diagnostics" },
          lualine_c = { "branch", "diff", function() return ToggletermStatus() end },
          -- Lambda that returns ToggletermStatus() since it's defined later in the program

          lualine_x = { cur_macro },
          lualine_y = { "encoding", "location", "progress" },
          lualine_z = { "os.date('%I:%M %p')" }
        }
      }
    end
  }
}
