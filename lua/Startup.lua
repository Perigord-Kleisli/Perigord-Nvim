local _2afile_2a = "/home/truff/.config/nvim/fnl/Startup.fnl"
local _2amodule_name_2a = "nvim-config"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local alpha, Mapping, Options = autoload("alpha"), require("Mapping"), require("Options")
do end (_2amodule_locals_2a)["alpha"] = alpha
_2amodule_locals_2a["Mapping"] = Mapping
_2amodule_locals_2a["Options"] = Options
local function button(bind, icon, extra_text)
  local _1_ = Mapping["get-action"](bind)
  if (_1_ == nil) then
    return print(("Bind: '" .. table.concat(bind) .. "' Not Found"))
  elseif ((_G.type(_1_) == "table") and (nil ~= (_1_)[1]) and (nil ~= (_1_)[2])) then
    local cmd = (_1_)[1]
    local text = (_1_)[2]
    local function _2_()
      return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes((cmd .. "<Ignore>"), true, false, true), "t", false)
    end
    return {type = "button", val = (icon .. "  " .. ((extra_text and extra_text[1]) or "") .. text .. ((extra_text and extra_text[2]) or "")), on_press = _2_, opts = {position = "center", shortcut = table.concat(bind, " "), align_shortcut = "right", hl = "Conditional", hl_shortcut = "Keyword", cursor = 2, width = 50}}
  else
    return nil
  end
end
_2amodule_locals_2a["button"] = button
local function _4_(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen(("ls -a \"" .. directory .. "\""))
  for filename in pfile:lines() do
    i = (i + 1)
    do end (t)[i] = filename
  end
  pfile:close()
  return t
end
scandir = _4_
do
  local header = {"       -\\         '-                                                                         ", "     -' :\\        | '-                                                                       ", "   -'   : \\       |   '-                          |MMM|                                      ", " -'\194\183    :  \\      |     '-                        |WWW|                                      ", "'.-.\194\183   :   \\     |       |                                                                  ", "|. .-\194\183  :    \\    |       |    MMM=         =MMM  |MMM|  |M|  +===+   +====+                  ", "| . .-\194\183 :     \\   |       |    \\HHB`       'BHH/  |HHH|  |H|\\/sMMMs\\_/sMMMMs\\             ", "|. . .-\194\183;      \\  |       |     \\HHH\\     /HHH/   |HHH|  |HBBWWWWWHMMMHWWWW:B\\             ", "| . . .-|       \\ |       |      \\HHH\\   /HHH/    |HHH|  |HK/     \\KYK/    \\KH|           ", "|. . . .|\\       \\|       |       \\HHH\\ /HHH/     |HHH|  |H|       |H|      |H|            ", "| . . . | \\       ;-      |        \\HHHVHHH/      |HHH|  |H|       |H|      |H|              ", "|. . . .|  \\      :\194\183-     |         \\HHHHH/       |HHH|  |H|       |H|      |H|              ", "| . . . |   \\     : .-    |          \\HHH/        |HHH|  |H|       |H|      |H|              ", "|. . . .|    \\    :. .-   |           \\W/         |WWW|  |W|       |W|      |W|              ", "`- . . .|     \\   : . .- -'                                                                  ", "  `- . .|      \\  :. ..-'                                                                    ", "    `-. |       \\ :..-'                                                                      ", "       `|        \\;-'                                                                        "}
  local in_session_dir
  do
    local cwd = (vim.fn.getcwd():gsub("/", "%%") .. ".vim")
    local out = false
    for _, file in ipairs(scandir((vim.fn.stdpath("data") .. "/sessions"))) do
      if out then
        break
      else
      end
      out = (cwd == file)
    end
    in_session_dir = out
  end
  local buttons
  local _6_
  if in_session_dir then
    _6_ = button({"<space>", "o", "S"}, "\239\149\174")
  else
    _6_ = button({"<space>", "o", "l"}, "\239\149\174")
  end
  local function _8_()
    return vim.cmd(":!xdg-open \"https://github.com/Trouble-Truffle/Perigord-Nvim\"")
  end
  buttons = {_6_, button({"<space>", "f", "r"}, "\239\153\143"), button({"<space>", "p", "p"}, "\239\130\177"), button({"<space>", "o", "P"}, "\239\129\188"), button({"<space>", "<space>"}, "\239\161\136"), button({"<space>", "f", "t"}, "\238\136\162", {"Find "}), {type = "padding", val = 1}, {type = "text", val = ("CWD: " .. vim.fn.getcwd()), opts = {position = "center", hl = "Comment"}}, {type = "padding", val = 2}, {type = "button", val = "  \239\144\136  ", on_press = _8_, opts = {hl = "CursorLineNr", position = "center", cursor = 2, width = 50}}}
  alpha.setup({layout = {{type = "padding", val = 2}, {type = "text", val = header, opts = {position = "center", hl = "diffnewfile"}}, {type = "group", val = buttons, opts = {spacing = 1}}, {type = "text", val = "", opts = {position = "center", hl = "Number"}}, __fnl_global__github_2drepo}, opts = {margin = 5}})
end
return _2amodule_2a