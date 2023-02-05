(vim.keymap.set :t :<Esc> "<C-\\><C-n>"
                {:noremap true :silent true :desc "Exit terminal"})

(vim.keymap.set :v :<C-c> "\"+y"
                {:silent false :desc "Copy to system clipboard"})

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

(vim.keymap.set :n :<C-l> :<cmd>nohl<CR>
                {:noremap true :silent true :desc "Toggle Terminal"})

(vim.keymap.set :n :U :<cmd>UndotreeToggle<CR>
                {:noremap true :silent true :desc "Toggle undotree"})

(let [{: save} (require :sesh)]
  (vim.keymap.set [:n :x :o] :<C-s> save {:noremap true :desc "Save session"}))

(let [leap (require :leap)]
  (vim.keymap.set [:n :x :o] :s #(leap.leap [])
                  {:noremap true :silent true :desc "Leap forwards"})
  (vim.keymap.set [:n :x :o] :S #(leap.leap {:backward true})
                  {:noremap true :silent true :desc "Leap backwards"}))

(local {:register wk} (require :which-key))
(local telescope (require :telescope.builtin))
(local {:extensions telescope-extension} (require :telescope))

(local {: cmd} (require :hydra.keymap-util))
(local {: Terminal} (require :toggleterm.terminal))
(local btop (Terminal:new {:cmd :btop :direction :float}))

(wk {:o {:name :Open
         :p [(cmd :NvimTreeToggle) :Sidebar]
         :t [(cmd :ToggleTerm) :Terminal]
         :s [telescope-extension.sesh.sesh :Session]
         :T [(cmd "ToggleTerm direction=float") "Floating Terminal"]
         :n [(cmd "Telescope notify") "Recent Notifications"]
         :b [#(btop:toggle) "Task Manager"]
         :r [telescope.oldfiles "Recent Files"]}
     :f {:name :Find :t [telescope.live_grep :Text]}
     :<leader> [telescope.find_files "Browse Files"]} {:prefix :<leader>})

(require :Mapping.Buffers)
(require :Mapping.Lang)
