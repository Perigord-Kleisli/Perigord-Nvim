local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
   vim.notify "Error importing: Which-key"
   return
end

local function map(name, command, opts)
   if opts == nil then
      return { "<CMD>" .. command .. "<CR>", name }
   else
      return { command, name }
   end
end

local function telescope(command, _theme)
   local theme = ""
   if _theme == nil then
      theme = "()"
   elseif _theme:find "[(){}]" then
      theme = "(require('telescope.themes').get_" .. _theme .. ")"
   else
      theme = "(require('telescope.themes').get_" .. _theme .. "())"
   end
   return "lua require('telescope.builtin')." .. command .. theme
end

local function toggleterm(cmd, opts)
   return "lua require('toggleterm.terminal').Terminal:new({"
      .. (cmd and ("cmd = '" .. cmd .. "',") or "")
      .. (opts or " hidden = true, direction = float")
      .. "}):toggle()"
end

which_key.register(
   -- Mapping
   {

      ["<C-f>"] = map("File Explorer", "NvimTreeToggle"),

      ["<A-h>"] = map("Prev", "BufferLineCyclePrev"),
      ["<A-l>"] = map("Next", "BufferLineCycleNext"),
      ["<A-S-h>"] = map("Move forward", "BufferLineMovePrev"),
      ["<A-S-l>"] = map("Move back", "BufferLineMoveNext"),

      g = {
         name = "Go to",
         d = map("Definition", "lua vim.lsp.buf.definition()"),
         i = map("Implementation", "lua vim.lsp.buf.implementation()"),
         T = map("Prev buffer", "BufferLineCyclePrev"),
         t = map("Next buffer", "BufferLineCycleNext"),
      },
      ["<leader>"] = {

         ["pp"] = map("Projects", "lua require('telescope').extensions.projects.projects()"),
         ["<leader>"] = map("Find File", telescope "find_files"),

         b = {
            name = "Buffer",

            h = map("Move forward", "BufferLineMovePrev"),
            l = map("Move back", "BufferLineMoveNext"),

            p = map("Pick", "BufferLinePick"),

            k = map("Prev", "BufferLineCyclePrev"),
            j = map("Next", "BufferLineCycleNext"),

            K = map("Delete", "bdelete! %"),
            x = map("Delete", "bdelete! %"),
         },

         f = {
            name = "Find",
            f = map("File", telescope "find_files"),
            m = map("Media File", "Telescope media_files"),
            p = map("Projects", "lua require('telescope').extensions.projects.projects()"),
            t = map("Text", telescope("live_grep", "ivy")),
         },

         g = {
            name = "Git",
            b = map("Blame", "lua require 'gitsigns'.blame_line()"),
            B = map("Branches", telescope "git_branches"),
            C = map("Commits", telescope "git_commits"),
            D = map("Get diff", "Gitsigns diffthis"),
            j = map("Next Hunk", "lua require'gitsigns'.next_hunk()"),
            k = map("Previous Hunk", "lua require'gitsigns'.prev_hunk()"),
            l = map("Lazygit", telescope "lazygit"),
            p = map("Preview Hunk", "lua require 'gitsigns'.preview_hunk()"),
            R = map("Reset hunk", "lua require 'gitsigns'.reset_hunk()"),
            ["RR"] = map("Reset Buffer", "lua require 'gitsigns'.reset_buffer()"),
            s = map("Status", telescope "git_status"),
            S = map("Stage hunk", "lua require 'gitsigns'.stage_hunk()"),
            U = map("Unstage hunk", "lua require 'gitsigns'.undo_stage_hunk()"),
         },

         l = {
            name = "Lsp",
            a = map("Code action", "lua vim.lsp.buf.code_action()"),
            d = map("Diagnostics", telescope("diagnostics", "ivy")),
            f = map("Format", "lua vim.lsp.buf.formatting_sync()"),
            i = map("File Lsp Info", "LspInfo"),
            l = map("Line diagnostics", "lua vim.diagnostic.open_float()"),
            s = map("Document symbols", telescope "lsp_document_symbols"),
            r = map("Rename variable", "lua vim.lsp.buf.rename()"),
         },

         h = {
            name = "Help",
            h = { ":help ", "Help" },
            c = map("Colorscheme", telescope "colorscheme"),
            m = map("Mappings", telescope "keymaps"),
            t = map("Tags", telescope "help_tags"),
         },

         o = {
            name = "Open",
            b = map("Btop", toggleterm "btop"),
            c = map("Configuration", "e" .. vim.fn.stdpath "config" .. "/init.lua"),
            e = map("Explorer", "NvimTreeToggle"),
            g = map("Ghci", toggleterm "ghci"),
            G = map("Lazygit", toggleterm "lazygit"),
            L = map("Lynx", toggleterm "lynx duckduckgo.com"),
            p = map("Explorer", "NvimTreeToggle"),
            r = map("Recent", telescope "oldfiles"),
            t = map("terminal", toggleterm(nil, "direction = 'horizontal'")),
            T = map("Floating terminal", toggleterm(nil, "direction='float', float_opts={border='rounded'}")),
            v = map("Vertical terminal", toggleterm(nil,"direction='vertical', size = vim.fn.winwidth(0)"))
         },

         p = {
            name = "Packer",
            c = map("Compile", "PackerCompile"),
            i = map("Install", "PackerInstall"),
            s = map("Sync", "PackerSync"),
            S = map("Status", "PackerStatus"),
            u = map("Update", "PackerUpdate"),
         },

         r = map("Run", ":Run")
      },
   },

   --Opts
   {}
)
