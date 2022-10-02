local _2afile_2a = "fnl/Mapping.fnl"
local _2amodule_name_2a = "Mapping"
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
local a, telescope_builtin, tsref_rename, Func, telescope_themes, tsref_navigation, which_key, legendary = autoload("aniseed.core"), autoload("telescope.builtin"), autoload("nvim-treesitter-refactor.smart_rename"), autoload("Functions"), autoload("telescope.themes"), autoload("nvim-treesitter-refactor.navigation"), autoload("which-key"), autoload("legendary")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["telescope-builtin"] = telescope_builtin
_2amodule_locals_2a["tsref-rename"] = tsref_rename
_2amodule_locals_2a["Func"] = Func
_2amodule_locals_2a["telescope-themes"] = telescope_themes
_2amodule_locals_2a["tsref-navigation"] = tsref_navigation
_2amodule_locals_2a["which-key"] = which_key
_2amodule_locals_2a["legendary"] = legendary
vim.g.mapleader = " "
local function newFile()
  local _2_
  do
    local _1_ = vim.fn.expand("%:e")
    if (_1_ == "") then
      _2_ = ""
    elseif (nil ~= _1_) then
      local ext = _1_
      _2_ = ("." .. ext)
    else
      _2_ = nil
    end
  end
  local function _6_(input)
    return vim.api.nvim_command(("edit " .. input))
  end
  return vim.ui.input({prompt = "File Name: ", default = _2_}, _6_)
end
_2amodule_2a["newFile"] = newFile
local function has_lsp()
  for _, key in ipairs(vim.lsp.buf_get_clients()) do
    if not (key.name == "null-ls") then
      return true
    else
    end
  end
  return false
end
_2amodule_2a["has-lsp"] = has_lsp
local function definition()
  if has_lsp() then
    return vim.lsp.buf.definition()
  else
    return tsref_navigation.goto_definition()
  end
end
_2amodule_2a["definition"] = definition
local function symbol_search()
  if has_lsp() then
    return telescope_builtin.lsp_document_symbols()
  else
    return telescope_builtin.treesitter()
  end
end
_2amodule_2a["symbol-search"] = symbol_search
local function rename()
  if has_lsp() then
    return vim.lsp.buf.rename()
  else
    return tsref_rename.smart_rename()
  end
end
_2amodule_2a["rename"] = rename
legendary.setup()
which_key.register({["<C-Up>"] = {("<cmd>" .. "resize +3" .. "<cr>"), "Vertical Resize+"}, ["<C-Down>"] = {("<cmd>" .. "resize -3" .. "<cr>"), "Vertical Resize-"}, ["<C-Left>"] = {("<cmd>" .. "vertical resize +3" .. "<cr>"), "Horizontal Resize+"}, ["<C-Right>"] = {("<cmd>" .. "vertical resize -3" .. "<cr>"), "Horizontal Resize-"}, ["<C-s>"] = {("<cmd>" .. "w | :SaveSession" .. "<cr>"), "Save Session"}, ["<A-s>"] = {("<cmd>" .. "lua require'nvim-treesitter.textobjects.swap'.swap_next('@parameter.inner')" .. "<cr>"), "Swap With Next Parameter"}, ["<A-S>"] = {("<cmd>" .. "lua require'nvim-treesitter.textobjects.swap'.swap_previous('@parameter.inner')" .. "<cr>"), "Swap With Previous Parameter"}, ["<A-j>"] = {("<cmd>" .. "m +1" .. "<cr>"), "Move Line Upwards"}, ["<A-k>"] = {("<cmd>" .. "m -2" .. "<cr>"), "Move Line Downwards"}, ["<C-P>"] = {("<cmd>" .. "Legendary" .. "<cr>"), "Command Palette"}, ["<A-x>"] = {("<cmd>" .. "bdelete! %" .. "<cr>"), "Delete Buffer"}, ["<A-h>"] = {("<cmd>" .. "BufferLineCyclePrev" .. "<cr>"), "Previous Buffer"}, ["<A-l>"] = {("<cmd>" .. "BufferLineCycleNext" .. "<cr>"), "Next Buffer"}, ["<A-H>"] = {("<cmd>" .. "BufferLineMovePrev" .. "<cr>"), "Previous Buffer"}, ["<A-L>"] = {("<cmd>" .. "BufferLineMoveNext" .. "<cr>"), "Next Buffer"}, K = {("<cmd>" .. ("lua vim.lsp.buf." .. "hover" .. "()") .. "<cr>"), "Show Symbol Info"}, ["<A-K>"] = {("<cmd>" .. "DocsViewToggle" .. "<cr>"), "Language LSP Documentation"}, g = {name = "Go To", b = {("<cmd>" .. "BufferLinePick" .. "<cr>"), "Buffer"}, d = {("<cmd>" .. ("lua require('Mapping')['" .. "definition" .. "']()") .. "<cr>"), "Definition"}, i = {("<cmd>" .. ("lua vim.lsp.buf." .. "implementation" .. "()") .. "<cr>"), "Implementation"}, t = {("<cmd>" .. "BufferLineMovePrev" .. "<cr>"), "Previous Buffer"}, T = {("<cmd>" .. "BufferLineMoveNext" .. "<cr>"), "Next Buffer"}, ["]"] = {("<cmd>" .. "lua vim.diagnostic.goto_next()" .. "<cr>"), "Next Diagnostic"}, ["["] = {("<cmd>" .. "lua vim.diagnostic.goto_prev()" .. "<cr>"), "Previous Diagnostic"}}})
local norm_binds = {["<leader>"] = {":Telescope find_files<cr>", "Find Files"}, c = {name = "Comment", b = {("<cmd>" .. "lua require('nvim-comment-frame').add_multiline_comment" .. "<cr>"), "Boxed Comment"}}, d = {name = "Debug", b = {("<cmd>" .. ("lua require('dap')." .. "toggle_breakpoint" .. "()") .. "<cr>"), "Toggle Breakpoint"}, B = {("<cmd>" .. "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))" .. "<cr>"), "Set Conditional Breakpoint"}, ["<A-b>"] = {("<cmd>" .. "lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log Point Messsage: '))" .. "<cr>"), "Set Logpoint"}, h = {("<cmd>" .. ("lua require('dap')." .. "step_out" .. "()") .. "<cr>"), "Step Out"}, l = {("<cmd>" .. ("lua require('dap')." .. "step_into" .. "()") .. "<cr>"), "Step Into"}, j = {("<cmd>" .. ("lua require('dap')." .. "step_over" .. "()") .. "<cr>"), "Step Over"}, k = {("<cmd>" .. ("lua require('dap')." .. "step_back" .. "()") .. "<cr>"), "Step Back"}, p = {("<cmd>" .. string.format("Telescope %s %s", "dap list_breakpoints", "") .. "<cr>"), "List Breakpoints"}, f = {("<cmd>" .. string.format("Telescope %s %s", "dap frames", "") .. "<cr>"), "Frames"}, t = {("<cmd>" .. "DapTerminate" .. "<cr>"), "Terminate"}, n = {("<cmd>" .. ("lua require('dap')." .. "continue" .. "()") .. "<cr>"), "Continue"}, _ = {("<cmd>" .. ("lua require('dap')." .. "run_last" .. "()") .. "<cr>"), "Run Last"}, u = {("<cmd>" .. "lua require'dapui'.toggle()" .. "<cr>"), "Toggle DAP UI"}}, f = {name = "Find", f = {("<cmd>" .. string.format("Telescope %s %s", "find_files", "") .. "<cr>"), "Find File"}, m = {("<cmd>" .. string.format("Telescope %s %s", "media_files", "") .. "<cr>"), "Find Media Files"}, r = {("<cmd>" .. string.format("Telescope %s %s", "oldfiles", "") .. "<cr>"), "Recently Opened Files"}, R = {("<cmd>" .. ("lua vim.lsp.buf." .. "references" .. "()") .. "<cr>"), "Find References"}, t = {("<cmd>" .. string.format("Telescope %s %s", "live_grep", "theme=ivy") .. "<cr>"), "Text"}, s = {("<cmd>" .. ("lua require('Mapping')['" .. "symbol-search" .. "']()") .. "<cr>"), "Document Symbols"}}, p = {name = "Project", p = {":Telescope projects<cr>", "Projects"}}, g = {name = "Git", b = {("<cmd>" .. ("lua require('gitsigns')." .. "blame_line" .. "()") .. "<cr>"), "Blame"}, B = {("<cmd>" .. string.format("Telescope %s %s", "git_branches", "") .. "<cr>"), "Branches"}, c = {("<cmd>" .. string.format("Telescope %s %s", "git_commits", "") .. "<cr>"), "Commit History"}, d = {("<cmd>" .. ("lua require('gitsigns')." .. "diffthis" .. "()") .. "<cr>"), "Diff"}, j = {("<cmd>" .. ("lua require('gitsigns')." .. "next_hunk" .. "()") .. "<cr>"), "Next Hunk"}, k = {("<cmd>" .. ("lua require('gitsigns')." .. "prev_hunk" .. "()") .. "<cr>"), "Previous Hunk"}, l = {("<cmd>" .. string.format("lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()", (("lazygit" and ("cmd='" .. "lazygit" .. "',")) or ""), (nil or "hidden=true, direction='float'")) .. "<cr>"), "Open Lazygit"}, n = {("<cmd>" .. "Neogit" .. "<cr>"), "NeoGit"}, p = {("<cmd>" .. ("lua require('gitsigns')." .. "preview_hunk" .. "()") .. "<cr>"), "Preview Diff"}, R = {("<cmd>" .. ("lua require('gitsigns')." .. "reset_hunk" .. "()") .. "<cr>"), "Reset Hunk"}, RR = {("<cmd>" .. ("lua require('gitsigns')." .. "reset_buffer" .. "()") .. "<cr>"), "Reset Buffer"}, s = {("<cmd>" .. string.format("Telescope %s %s", "git_status", "") .. "<cr>"), "Git Status"}, S = {("<cmd>" .. ("lua require('gitsigns')." .. "stage_hunk" .. "()") .. "<cr>"), "Stage Hunk"}, U = {("<cmd>" .. ("lua require('gitsigns')." .. "undo_stage_hunk" .. "()") .. "<cr>"), "Unstage Hunk"}}, l = {name = "Language", a = {("<cmd>" .. ("lua vim.lsp.buf." .. "code_action" .. "()") .. "<cr>"), "Code Action"}, d = {("<cmd>" .. string.format("Telescope %s %s", "diagnostics", "theme=ivy") .. "<cr>"), "Diagnostics"}, f = {("<cmd>" .. ("lua vim.lsp.buf." .. "formatting_sync" .. "()") .. "<cr>"), "Format"}, i = {("<cmd>" .. "LspInfo" .. "<cr>"), "LSP Info"}, l = {("<cmd>" .. "lua vim.diagnostic.open_float()" .. "<cr>"), "Line Diagnostic"}, L = {("<cmd>" .. "LspLog" .. "<cr>"), "LSP Log"}, k = {("<cmd>" .. "DocsViewToggle" .. "<cr>"), "Language LSP Documentation"}, r = {("<cmd>" .. ("lua require('Mapping')['" .. "rename" .. "']()") .. "<cr>"), "Rename"}, R = {("<cmd>" .. ("lua vim.lsp.buf." .. "references" .. "()") .. "<cr>"), "Find References"}, S = {("<cmd>" .. ("lua require('Mapping')['" .. "symbol_search" .. "']()") .. "<cr>"), "Document Symbols"}, s = {name = "Snippet", s = {("<cmd>" .. "SnipRun" .. "<cr>"), "Run Snippet"}, S = {("<cmd>" .. "SnipClose" .. "<cr>"), "Stop Snippet"}, t = {("<cmd>" .. "lua require'sniprun.live_mode'.toggle()" .. "<cr>"), "Toggle Live Snippet"}}, u = {("<cmd>" .. "RunCode" .. "<cr>"), "Run File"}, U = {("<cmd>" .. "RunProject" .. "<cr>"), "Run Project"}}, o = {name = "Open", b = {("<cmd>" .. string.format("lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()", (("btop" and ("cmd='" .. "btop" .. "',")) or ""), ("direction = 'float'" or "hidden=true, direction='float'")) .. "<cr>"), "Task Manager"}, d = {("<cmd>" .. "DocsViewToggle" .. "<cr>"), "Language LSP Documentation"}, e = {("<cmd>" .. "ene" .. "<cr>"), "Empty File"}, l = {"`0", "Last Opened File"}, n = {("<cmd>" .. ("lua require('Mapping')['" .. "newFile" .. "']()") .. "<cr>"), "New File"}, p = {("<cmd>" .. "NvimTreeToggle" .. "<cr>"), "File Explorer"}, P = {("<cmd>" .. "Telescope file_browser" .. "<cr>"), "File Browser"}, s = {("<cmd>" .. "SymbolsOutline" .. "<cr>"), "Document Symbol Tree"}, S = {("<cmd>" .. "RestoreSession" .. "<cr>"), "Last Session"}, t = {("<cmd>" .. string.format("lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()", ((nil and ("cmd='" .. nil .. "',")) or ""), ("direction = 'horizontal', size=1" or "hidden=true, direction='float'")) .. "<cr>"), "Terminal"}, T = {("<cmd>" .. string.format("lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()", ((nil and ("cmd='" .. nil .. "',")) or ""), ("direction='float' , float_opts={border='rounded'}" or "hidden=true, direction='float'")) .. "<cr>"), "Floating Terminal"}, v = {("<cmd>" .. string.format("lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()", ((nil and ("cmd='" .. nil .. "',")) or ""), ("direction='vertical'" or "hidden=true, direction='float'")) .. "<cr>"), "Vertical Terminal"}, Z = {("<cmd>" .. "ZenMode" .. "<cr>"), "Zen Mode"}}, P = {name = "Packer", i = {("<cmd>" .. "PackerInstall" .. "<cr>"), "Install"}, s = {("<cmd>" .. "PackerSync" .. "<cr>"), "Sync"}, S = {("<cmd>" .. "PackerStatus" .. "<cr>"), "Status"}}}
_2amodule_locals_2a["norm-binds"] = norm_binds
which_key.register(norm_binds, {prefix = "<leader>"})
local function lang_specific_binds(filetype)
  local _11_ = filetype
  if (_11_ == "markdown") then
    return {["<leader>lm"] = {("<cmd>" .. "MarkdownPreview" .. "<cr>"), "Preview Markdown"}}
  elseif true then
    local _ = _11_
    return {}
  else
    return nil
  end
end
_2amodule_locals_2a["lang-specific-binds"] = lang_specific_binds
local function _13_()
  return which_key.register(lang_specific_binds(vim.bo.filetype))
end
vim.api.nvim_create_autocmd({"BufEnter", "BufRead"}, {pattern = "*", callback = _13_})
vim.api.nvim_set_keymap("v", "<C-c>", "\"+y", {silent = false})
which_key.register({["<space>s"] = {name = "Snippet", s = {("<cmd>" .. "SnipRun" .. "<cr>"), "Run Snippet"}, S = {("<cmd>" .. "SnipClose" .. "<cr>"), "Stop Snippet"}, t = {("<cmd>" .. "lua require'sniprun.live_mode'.toggle()" .. "<cr>"), "Toggle Live Snippet"}}, ["<space>d"] = {name = "Debug", e = {("<cmd>" .. "lua require'dapui'.eval()" .. "<cr>"), "Start Debugging"}}, ["<DOWN>"] = {":m '>+1<CR>gv=gv", "Move Selected Lines Downwards"}, ["<A-j>"] = {":m '>+1<CR>gv=gv", "Move Selected Lines Downwards"}, ["<UP>"] = {":m '<-2<CR>gv=gv", "Move Selected Lines Downwards"}, ["<A-k>"] = {":m '<-2<CR>gv=gv", "Move Selected Lines Downwards"}, ["<space>c<space>"] = {"<Plug>NERDCommenterToggle", "Comment Selection"}, ["<"] = {"<gv", "Unindent"}, [">"] = {">gv", "Indent"}}, {mode = "v"})
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {silent = true})
vim.api.nvim_set_keymap("t", "<Space>ot", "<C-\\><C-n>:q<CR>", {silent = true})
vim.api.nvim_set_keymap("t", "<Space>oT", "<C-\\><C-n>:q<CR>", {silent = true})
vim.api.nvim_set_keymap("t", "<Space>ov", "<C-\\><C-n>:q<CR>", {silent = true})
do
  local to_leader
  local function _14_(key)
    if (vim.g.mapleader == vim.api.nvim_replace_termcodes(key, true, false, true)) then
      return "<leader>"
    else
      return key
    end
  end
  to_leader = _14_
  local function get_action(bind)
    local bind_table = {["<leader>"] = norm_binds}
    for _, key in ipairs(bind) do
      if (bind_table == nil) then
        break
      else
      end
      bind_table = bind_table[to_leader(key)]
    end
    return bind_table
  end
  _2amodule_2a["get-action"] = get_action
end
vim.api.nvim_create_user_command("W", ":execute \"SaveSession\" | w", {})
vim.api.nvim_create_user_command("WQ", ":execute \"SaveSession\" | wqall", {})
return _2amodule_2a