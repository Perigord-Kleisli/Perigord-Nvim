(vim.keymap.set :t :<Esc> "<C-\\><C-n>"
                {:noremap true :silent true :desc "Exit terminal"})

(vim.keymap.set :v :<C-c> "\"+y"
                {:silent false :desc "Copy to system clipboard"})

(vim.keymap.set :i :<C-v> :<C-r>+
                {:silent false :desc "Paste from system clipboard"})

(vim.keymap.set :n :<C-Up> ":resize +3<CR>"
                {:noremap true :silent true :desc "Vertical Resize+"})

(vim.keymap.set :n :<C-Down> ":resize -3<CR>"
                {:noremap true :silent true :desc "Vertical Resize-"})

(vim.keymap.set :n :<C-Left> ":vertical resize +3<CR>"
                {:noremap true :silent true :desc "Horizontal Resize+"})

(vim.keymap.set :n :<C-Right> ":vertical resize -3<CR>"
                {:noremap true :silent true :desc "Horizontal Resize-"})

(vim.keymap.set [:n :o :x :v] :gh "^"
                {:noremap true :silent true :desc "Go to line start"})

(vim.keymap.set [:n :o :x :v] :gl "$"
                {:noremap true :silent true :desc "Go to line end"})

(vim.keymap.set :t :<leader>ot :<cmd>ToggleTerm<CR>
                {:noremap true :silent true :desc "Toggle Terminal"})

(vim.keymap.set :n :vv :v$ {:noremap true :silent true :desc "Select Line"})

(vim.keymap.set :n :<C-l> :<cmd>nohl<CR>
                {:noremap true :silent true :desc "Toggle Terminal"})

(vim.keymap.set :n :U :<cmd>UndotreeToggle<CR>
                {:noremap true :silent true :desc "Toggle undotree"})

(vim.keymap.set :n :w "<Plug>(smartword-w)"
                {:noremap true :silent true :desc "Next Word"})

(vim.keymap.set :n :<A-k> :<Plug>GoNSMUp
                {:noremap true :silent true :desc "Move up"})

(vim.keymap.set :n :<A-j> :<Plug>GoNSMDown
                {:noremap true :silent true :desc "Move down"})

(vim.keymap.set :x :<A-k> :<Plug>GoVSMUp
                {:noremap true :silent true :desc "Move up"})

(vim.keymap.set :x :<A-j> :<Plug>GoVSMDown
                {:noremap true :silent true :desc "Move down"})

(let [leap (require :leap)]
  (vim.keymap.set [:n :x :o] :s #(leap.leap [])
                  {:noremap true :silent true :desc "Leap forwards"})
  (vim.keymap.set [:n :x :o] :S #(leap.leap {:backward true})
                  {:noremap true :silent true :desc "Leap backwards"}))

(local {:register wk} (require :which-key))
(local telescope (require :telescope.builtin))

(local {: cmd} (require :hydra.keymap-util))
(local {: Terminal} (require :toggleterm.terminal))
(local btop (Terminal:new {:cmd :btop :direction :float}))

(let [ufo (require :ufo)]
  (var peek? false)
  (let [peek #(let [winid (ufo.peekFoldedLinesUnderCursor)]
                (if winid
                    (set peek? true)
                    (vim.lsp.buf.hover)))]
    (vim.keymap.set :n :K #(if peek? (set peek? false) (peek))
                    {:noremap true :silent true :desc :Hover}))
  (vim.keymap.set :n :zR ufo.openAllFolds
                  {:noremap true :silent true :desc "Open all folds"})
  (vim.keymap.set :n :zM ufo.closeAllFolds
                  {:noremap true :silent true :desc "Close all folds"}))

(local harpoon (require :harpoon))
(harpoon:setup)

(require :Mapping.Git)
(wk {:o {:name :Open
         :p [(cmd :NvimTreeToggle) :Sidebar]
         :t [(cmd :ToggleTerm) :Terminal]
         :T [(cmd "ToggleTerm direction=float") "Floating Terminal"]
         :n [(cmd "Telescope notify") "Recent Notifications"]
         :b [#(btop:toggle) "Task Manager"]
         :r [telescope.oldfiles "Recent Files"]}
     :h {:name :Harpoon
         :a [#(: (harpoon:list) :prepend) :Add]
         :h [#(harpoon.ui:toggle_quick_menu (harpoon:list)) "Quick Menu"]
         :d [#(: (harpoon:list) :removeAt 1) "Delete"]
         :D {:name "Remove At"
             :1 [#(: (harpoon:list) :removeAt 1) "Harpoon 1"]
             :2 [#(: (harpoon:list) :removeAt 2) "Harpoon 2"]
             :3 [#(: (harpoon:list) :removeAt 3) "Harpoon 3"]
             :4 [#(: (harpoon:list) :removeAt 4) "Harpoon 4"]
             :5 [#(: (harpoon:list) :removeAt 5) "Harpoon 5"]
             :6 [#(: (harpoon:list) :removeAt 6) "Harpoon 6"]}
         :1 [#(: (harpoon:list) :select 1) "Harpoon 1"]
         :2 [#(: (harpoon:list) :select 2) "Harpoon 2"]
         :3 [#(: (harpoon:list) :select 3) "Harpoon 3"]
         :4 [#(: (harpoon:list) :select 4) "Harpoon 4"]
         :5 [#(: (harpoon:list) :select 5) "Harpoon 5"]
         :6 [#(: (harpoon:list) :select 6) "Harpoon 6"]}
     :d [nil :+Debug]
     :x [(. (require :notify) :dismiss) "Dismiss notifications"]
     :<leader> [telescope.find_files "Browse Files"]} {:prefix :<leader>})

(require :Mapping.Buffers)
(require :Mapping.Lang)
(require :Mapping.Debug)
