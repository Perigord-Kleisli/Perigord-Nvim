local if_nil = vim.F.if_nil
local default_header = {
   type = "text",
   val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
   },
   opts = {
      position = "center",
      hl = "Type",
      -- wrap = "overflow";
   },
}

local footer = {
   type = "text",
   val = "",
   opts = {
      position = "center",
      hl = "Number",
   },
}

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
   local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
   local opts = {
      position = "center",
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = "right",
      hl_shortcut = "Keyword",
   }
   if keybind then
      keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
      opts.keymap = { "n", sc_, keybind .. "<CR>", keybind_opts }
   end

   local function on_press()
      local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
   end

   return {
      type = "button",
      val = txt,
      on_press = on_press,
      opts = opts,
   }
end

local buttons = {
   type = "group",
   val = {
      button("SPC s l", "  Open last session", "`0"),
      button("SPC f m", "  Projects", ":Telescope projects"),
      button("SPC f h", "  Recently opened files", ":Telescope oldfiles"),
      button("SPC f f", "  Find file", ":Telescope find_files"),
      button("SPC f g", "  Find word", ":Telescope live_grep"),
   },
   opts = {
      spacing = 1,
   },
}

local section = {
   header = default_header,
   buttons = buttons,
   footer = footer,
}

local config = {
   layout = {
      { type = "padding", val = 2 },
      section.header,
      { type = "padding", val = 2 },
      section.buttons,
      section.footer,
   },
   opts = {
      margin = 5,
   },
}

return config
--return {
--button = button,
--section = section,
--config = config,
---- deprecated
--opts = config,
--}
